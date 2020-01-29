//
//  UIImage+ImageFrame.m
//  GitHubC
//
//  Created by AaronYin on 2019/9/6.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import "UIImage+ImageFrame.h"
#import <objc/runtime.h>

static const void *durationKey = &durationKey;
static const void *imageLoopCountKey = &imageLoopCountKey;

@implementation UIImage (ImageFrame)

@dynamic duration;
@dynamic imageLoopCount;

- (NSTimeInterval)duration {
    NSTimeInterval duration = 0.0;
    NSNumber *durationNumber = objc_getAssociatedObject(self, durationKey);
    if ([durationNumber isKindOfClass:[NSNumber class]]) {
        duration = durationNumber.doubleValue;
    }
    return duration;
}

- (void)setDuration:(NSTimeInterval)duration {
    objc_setAssociatedObject(self, durationKey, @(duration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)imageLoopCount {
    NSUInteger imageLoopCount = 0;
    NSNumber *value = objc_getAssociatedObject(self, imageLoopCountKey);
    if ([value isKindOfClass:[NSNumber class]]) {
        imageLoopCount = value.unsignedIntegerValue;
    }
    return imageLoopCount;
}

- (void)setImageLoopCount:(NSUInteger)imageLoopCount {
    objc_setAssociatedObject(self, imageLoopCountKey, @(imageLoopCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
