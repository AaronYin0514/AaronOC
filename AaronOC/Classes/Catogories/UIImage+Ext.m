//
//  UIImage+Ext.m
//  GitHubC
//
//  Created by AaronYin on 2019/9/5.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import "UIImage+Ext.h"
#import "GHAlgorithm.h"

@implementation UIImage (Ext)

#pragma mark - 判断Image是否包含Alpha信息

- (BOOL)containsAlpha {
    CGImageRef imageRef = self.CGImage;
    return [UIImage containsAlphaWithImageRef:imageRef];
}

+ (BOOL)containsAlphaWithImageRef:(CGImageRef)imageRef {
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef) & kCGBitmapAlphaInfoMask;
    BOOL hasAlpha = NO;
    if (alphaInfo == kCGImageAlphaPremultipliedLast ||
        alphaInfo == kCGImageAlphaPremultipliedFirst ||
        alphaInfo == kCGImageAlphaLast ||
        alphaInfo == kCGImageAlphaFirst) {
        hasAlpha = YES;
    }
    return hasAlpha;
}

#pragma mark - 返回当前设备色彩空间

+ (CGColorSpaceRef)colorSpaceGetDeviceRGB {
#if TARGET_OS_OSX
    CGColorSpaceRef screenColorSpace = NSScreen.mainScreen.colorSpace.CGColorSpace;
    if (screenColorSpace) {
        return screenColorSpace;
    }
#endif
    static CGColorSpaceRef colorSpace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if TARGET_OS_IOS || TARGET_OS_TV
        if (@available(iOS 9.0, tvOS 9.0, *)) {
            colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceSRGB);
        } else {
            colorSpace = CGColorSpaceCreateDeviceRGB();
        }
#else
        colorSpace = CGColorSpaceCreateDeviceRGB();
#endif
    });
    return colorSpace;
}

#pragma mark - GIF

+ (NSArray<UIImage *> *)fetchGIFImageFramesWithSource:(CGImageSourceRef)source scale:(CGFloat)scale {
    NSAssert(scale <= 1.0, @"scale小于等于1");
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray<UIImage *> *frames = [NSMutableArray array];
    for (size_t i = 0; i < count; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!imageRef) {
            continue;
        }
        float duration = [self frameDurationAtIndex:i source:source];
        UIImage *image = [[UIImage alloc] initWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
        CGImageRelease(imageRef);
        image.duration = duration;
        [frames addObject:image];
    }
    return [NSArray arrayWithArray:frames];
}

+ (UIImage *)fetchAnimatedImageWithSource:(CGImageSourceRef)source scale:(CGFloat)scale {
    NSAssert(scale <= 1.0, @"scale小于等于1");
    NSArray<UIImage *> *frames = [self fetchGIFImageFramesWithSource:source scale:scale];
    NSUInteger loopCount = [self imageLoopCountWithSource:source];
    NSUInteger frameCount = frames.count;
    if (frameCount == 0) {
        return nil;
    }
    
    UIImage *animatedImage;
    NSUInteger durations[frameCount];
    for (size_t i = 0; i < frameCount; i++) {
        durations[i] = frames[i].duration * 1000;
    }
    NSUInteger const gcd = [GHAlgorithm gcdArrayByEuclideanAlgorithmWithCount:frameCount andValues:durations];
    __block NSUInteger totalDuration = 0;
    NSMutableArray<UIImage *> *animatedImages = [NSMutableArray arrayWithCapacity:frameCount];
    [frames enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger duration = image.duration * 1000;
        totalDuration += duration;
        NSUInteger repeatCount;
        if (gcd) {
            repeatCount = duration / gcd;
        } else {
            repeatCount = 1;
        }
        for (size_t i = 0; i < repeatCount; ++i) {
            [animatedImages addObject:image];
        }
    }];
    animatedImage = [UIImage animatedImageWithImages:animatedImages duration:totalDuration / 1000.f];
    animatedImage.imageLoopCount = loopCount;
    return animatedImage;
}

+ (NSUInteger)imageLoopCountWithSource:(CGImageSourceRef)source {
    NSUInteger loopCount = 1;
    NSDictionary *imageProperties = (__bridge_transfer NSDictionary *)CGImageSourceCopyProperties(source, nil);
    NSDictionary *gifProperties = imageProperties[(__bridge NSString *)kCGImagePropertyGIFDictionary];
    if (gifProperties) {
        NSNumber *gifLoopCount = gifProperties[(__bridge NSString *)kCGImagePropertyGIFLoopCount];
        if (gifLoopCount != nil) {
            loopCount = gifLoopCount.unsignedIntegerValue;
        }
    }
    return loopCount;
}

+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    if (!cfFrameProperties) {
        return frameDuration;
    }
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp != nil) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    } else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp != nil) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

@end
