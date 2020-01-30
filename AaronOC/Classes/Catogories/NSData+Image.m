//
//  NSData+Image.m
//  GitHubC
//
//  Created by AaronYin on 2019/9/5.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import "NSData+Image.h"
#import "UIImage+ImageFrame.h"
#import "UIImage+Ext.h"

@implementation NSData (Image)

+ (GHImageFormat)imageFormatForImageData:(nullable NSData *)data {
    if (!data) {
        return GHImageFormatUndefined;
    }
    
    // File signatures table: http://www.garykessler.net/library/file_sigs.html
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return GHImageFormatJPEG;
        case 0x89:
            return GHImageFormatPNG;
        case 0x47:
            return GHImageFormatGIF;
        case 0x49:
        case 0x4D:
            return GHImageFormatTIFF;
        case 0x52: {
            if (data.length >= 12) {
                //RIFF....WEBP
                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
                if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                    return GHImageFormatWebP;
                }
            }
            break;
        }
        case 0x00: {
            if (data.length >= 12) {
                //....ftypheic ....ftypheix ....ftyphevc ....ftyphevx
                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(4, 8)] encoding:NSASCIIStringEncoding];
                if ([testString isEqualToString:@"ftypheic"]
                    || [testString isEqualToString:@"ftypheix"]
                    || [testString isEqualToString:@"ftyphevc"]
                    || [testString isEqualToString:@"ftyphevx"]) {
                    return GHImageFormatHEIC;
                }
                //....ftypmif1 ....ftypmsf1
                if ([testString isEqualToString:@"ftypmif1"] || [testString isEqualToString:@"ftypmsf1"]) {
                    return GHImageFormatHEIF;
                }
            }
            break;
        }
    }
    return GHImageFormatUndefined;
}

- (UIImage *)decodedGIFImageWithData:(NSData *)data scale:(CGFloat)scale {
    CGFloat imageScale = scale;
    imageScale = MAX(imageScale, 1);
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    if (!source) {
        return nil;
    }
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data scale:imageScale];
    } else {
        animatedImage = [UIImage fetchAnimatedImageWithSource:source scale:imageScale];
    }
    CFRelease(source);
    return animatedImage;
}

@end
