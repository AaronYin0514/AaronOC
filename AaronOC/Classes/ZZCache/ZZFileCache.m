//
//  ZZFileCache.m
//  miaohong
//
//  Created by AaronYin on 2019/7/10.
//  Copyright © 2019 Neoclub. All rights reserved.
//

#import "ZZFileCache.h"
#import <CommonCrypto/CommonDigest.h>

static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7; // 1 week

@interface ZZFileCache ()

@property (nonatomic, strong, readonly) NSFileManager *fileManager;

@property (strong, nonatomic) NSString *diskCachePath;

@property (strong, nonatomic) dispatch_queue_t ioQueue;

@end

@implementation ZZFileCache

+ (ZZFileCache *)sharedFileCache {
    static dispatch_once_t once;
    static ZZFileCache *instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init {
    return [self initWithNamespace:@"default"];
}

- (id)initWithNamespace:(NSString *)ns {
    NSString *path = [self makeDiskCachePath:ns];
    return [self initWithNamespace:ns diskCacheDirectory:path];
}

- (id)initWithNamespace:(NSString *)ns diskCacheDirectory:(NSString *)directory {
    if ((self = [super init])) {
        NSString *fullNamespace = [@"zz.file.cache." stringByAppendingString:ns];
        _ioQueue = dispatch_queue_create("zz.file.cache.", DISPATCH_QUEUE_SERIAL);
        _maxCacheAge = kDefaultCacheMaxCacheAge;
        if (directory != nil) {
            _diskCachePath = [directory stringByAppendingPathComponent:fullNamespace];
        } else {
            NSString *path = [self makeDiskCachePath:ns];
            _diskCachePath = path;
        }
        _shouldDecompressFile = YES;
        dispatch_sync(_ioQueue, ^{
            _fileManager = [NSFileManager defaultManager];
            [_fileManager createDirectoryAtPath:_diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
        });
    }
    return self;
}

#pragma mark - Private
- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r); 
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    NSString *exestr = [key pathExtension];
    if (exestr.length) {
        filename = [NSString stringWithFormat:@"%@.%@", filename, exestr];
    }
    return filename;
}

-(NSString *)makeDiskCachePath:(NSString*)fullNamespace{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}

#pragma mark - File Cache
#pragma mark Cache
- (void)storeFileWithData:(NSData *)data forKey:(NSString *)key {
    if (!data || !key) {
        return;
    }
    dispatch_async(self.ioQueue, ^{
        if (![self.fileManager fileExistsAtPath:self.diskCachePath]) {
            [self.fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
        }
        NSString *cachePathForKey = [self defaultCachePathForKey:key];
        [self.fileManager createFileAtPath:cachePathForKey contents:data attributes:nil];
    });
}

- (void)storeFileWithData:(NSData *)data forKey:(NSString *)key completion:(ZZFileManagerStoreCompletedBlock)completion {
    if (!data || !key) {
        if (completion) {
            completion(nil);
        }
        return;
    }
    dispatch_async(self.ioQueue, ^{
        if (![self.fileManager fileExistsAtPath:self.diskCachePath]) {
            [self.fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
        }
        NSString *cachePathForKey = [self defaultCachePathForKey:key];
        [self.fileManager createFileAtPath:cachePathForKey contents:data attributes:nil];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(cachePathForKey);
            });
        }
    });
}

#pragma mark Take
- (NSData *)fileFromDiskCacheForKey:(NSString *)key {
    NSData *fileData = [self diskFileDataBySearchingAllPathsForKey:key];
    return fileData;
}

- (NSOperation *)fileFromDiskCacheForKey:(NSString *)key done:(ZZFileManagerQueryCompletedBlock)doneBlock {
    if (!doneBlock) {
        return nil;
    }
    if (!key) {
        doneBlock(nil);
        return nil;
    }
    NSOperation *operation = [NSOperation new];
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.ioQueue, ^{
        if (operation.isCancelled) {
            return;
        }
        @autoreleasepool {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            NSData *fileData = [strongSelf diskFileDataBySearchingAllPathsForKey:key];
            dispatch_async(dispatch_get_main_queue(), ^{
                doneBlock(fileData);
            });
        }
    });
    return operation;
}

- (NSData *)diskFileDataBySearchingAllPathsForKey:(NSString *)key {
    NSString *defaultPath = [self defaultCachePathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:defaultPath];
    if (data) {
        return data;
    }
    return nil;
}

#pragma mark Query
- (NSString *)cachePathForKey:(NSString *)key inPath:(NSString *)path {
    NSString *filename = [self cachedFileNameForKey:key];
    return [path stringByAppendingPathComponent:filename];
}

- (NSString *)defaultCachePathForKey:(NSString *)key {
    return [self cachePathForKey:key inPath:self.diskCachePath];
}

#pragma mark Judge
- (BOOL)diskFileExistsWithKey:(NSString *)key {
    BOOL exists = NO;
    exists = [[NSFileManager defaultManager] fileExistsAtPath:[self defaultCachePathForKey:key]];
    return exists;
}

- (void)diskFileExistsWithKey:(NSString *)key completion:(ZZFileManagerCheckCacheCompletionBlock)completion {
    dispatch_async(_ioQueue, ^{
        BOOL exists = [self.fileManager fileExistsAtPath:[self defaultCachePathForKey:key]];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(exists);
            });
        }
    });
}
#pragma mark Delegate
- (BOOL)removeFileForKey:(NSString *)key {
    if (key == nil) {
        return NO;
    }
    return [_fileManager removeItemAtPath:[self defaultCachePathForKey:key] error:nil];
}

- (void)removeFileForKey:(NSString *)key completion:(ZZFileManagerRemoveFileCompletionBlock)completion {
    if (key == nil) {
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(NO);
            });
        }
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.ioQueue, ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        BOOL result = [strongSelf removeFileForKey:key];
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(result);
            });
        }
    });
}

- (BOOL)clearDisk {
    BOOL result = [_fileManager removeItemAtPath:self.diskCachePath error:nil];
    [_fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
    return result;
}

- (void)clearDiskOnCompletion:(ZZFileManagerRemoveFileCompletionBlock)completion {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.ioQueue, ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        BOOL result = [strongSelf clearDisk];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(result);
            });
        }
    });
}

- (void)cleanDisk {
    [self cleanDiskWithCompletionBlock:nil];
}

- (void)cleanDiskWithCompletionBlock:(ZZFileManagerRemoveFileCompletionBlock)completionBlock {
    dispatch_async(self.ioQueue, ^{
        NSURL *diskCacheURL = [NSURL fileURLWithPath:self.diskCachePath isDirectory:YES];
        NSArray *resourceKeys = @[NSURLIsDirectoryKey, NSURLContentModificationDateKey, NSURLTotalFileAllocatedSizeKey];
        
        NSDirectoryEnumerator *fileEnumerator = [self.fileManager enumeratorAtURL:diskCacheURL includingPropertiesForKeys:resourceKeys options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:NULL];
        
        NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-self.maxCacheAge];
        NSMutableDictionary *cacheFiles = [NSMutableDictionary dictionary];
        NSUInteger currentCacheSize = 0;
        
        NSMutableArray *urlsToDelete = [[NSMutableArray alloc] init];
        for (NSURL *fileURL in fileEnumerator) {
            NSDictionary *resourceValues = [fileURL resourceValuesForKeys:resourceKeys error:NULL];
            
            if ([resourceValues[NSURLIsDirectoryKey] boolValue]) {
                continue;
            }
            
            NSDate *modificationDate = resourceValues[NSURLContentModificationDateKey];
            if ([[modificationDate laterDate:expirationDate] isEqualToDate:expirationDate]) {
                [urlsToDelete addObject:fileURL];
                continue;
            }
            
            NSNumber *totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
            currentCacheSize += [totalAllocatedSize unsignedIntegerValue];
            [cacheFiles setObject:resourceValues forKey:fileURL];
        }
        
        for (NSURL *fileURL in urlsToDelete) {
            [self.fileManager removeItemAtURL:fileURL error:nil];
        }
        
        if (self.maxCacheSize > 0 && currentCacheSize > self.maxCacheSize) {
            const NSUInteger desiredCacheSize = self.maxCacheSize / 2;
            NSArray *sortedFiles = [cacheFiles keysSortedByValueWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 [NSURLContentModificationDateKey] compare:obj2[NSURLContentModificationDateKey]];
            }];
            for (NSURL *fileURL in sortedFiles) {
                if ([self.fileManager removeItemAtURL:fileURL error:nil]) {
                    NSDictionary *resourceValues = cacheFiles[fileURL];
                    NSNumber *totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
                    currentCacheSize -= [totalAllocatedSize unsignedIntegerValue];
                    
                    if (currentCacheSize < desiredCacheSize) {
                        break;
                    }
                }
            }
        }
        
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(YES);
            });
        }
    });
}

- (NSUInteger)getSize {
    __block NSUInteger size = 0;
    dispatch_sync(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:self.diskCachePath];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    });
    return size;
}

- (NSUInteger)getDiskCount {
    __block NSUInteger count = 0;
    dispatch_sync(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:self.diskCachePath];
        count = [[fileEnumerator allObjects] count];
    });
    return count;
}

- (void)calculateSizeWithCompletionBlock:(ZZFileManagerCalculateSizeBlock)completionBlock {
    NSURL *diskCacheURL = [NSURL fileURLWithPath:self.diskCachePath isDirectory:YES];
    
    dispatch_async(self.ioQueue, ^{
        NSUInteger fileCount = 0;
        NSUInteger totalSize = 0;
        
        NSDirectoryEnumerator *fileEnumerator = [self.fileManager enumeratorAtURL:diskCacheURL includingPropertiesForKeys:@[NSFileSize] options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:NULL];
        
        for (NSURL *fileURL in fileEnumerator) {
            NSNumber *fileSize;
            [fileURL getResourceValue:&fileSize forKey:NSURLFileSizeKey error:NULL];
            totalSize += [fileSize unsignedIntegerValue];
            fileCount += 1;
        }
        
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(fileCount, totalSize);
            });
        }
    });
}

#pragma mark - Disk File Cache
- (BOOL)cacheDiskFileFromPath:(NSString *)path key:(NSString *)key cut:(BOOL)cut {
    NSString *toPath = [self defaultCachePathForKey:key];
    if ([_fileManager fileExistsAtPath:toPath]) {
        return NO;
    }
    BOOL result = NO;
    if (cut) {
        result = [_fileManager moveItemAtPath:path toPath:toPath error:nil];
    } else {
        result = [_fileManager copyItemAtPath:path toPath:toPath error:nil];
    }
    return result;
}

- (void)cacheDiskFileFromPath:(NSString *)path key:(NSString *)key cut:(BOOL)cut completion:(ZZFileManagerStoreCompletedBlock)completion {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.ioQueue, ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if ([strongSelf cacheDiskFileFromPath:path key:key cut:cut]) {
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion([strongSelf defaultCachePathForKey:key]);
                });
            }
        } else {
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil);
                });
            }
        }
    });
}

@end
