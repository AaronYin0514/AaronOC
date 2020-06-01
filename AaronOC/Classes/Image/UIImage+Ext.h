//
//  UIImage+Ext.h
//  GitHubC
//
//  Created by AaronYin on 2019/9/5.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ImageFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Ext)

#pragma mark - 判断Image是否包含Alpha信息

- (BOOL)containsAlpha;

+ (BOOL)containsAlphaWithImageRef:(CGImageRef)imageRef;

#pragma mark - 返回当前设备色彩空间

+ (CGColorSpaceRef)colorSpaceGetDeviceRGB;

#pragma mark - GIF

+ (NSArray<UIImage *> *)fetchGIFImageFramesWithSource:(CGImageSourceRef)source scale:(CGFloat)scale;

+ (UIImage *)fetchAnimatedImageWithSource:(CGImageSourceRef)source scale:(CGFloat)scale;

#pragma mark - Orientation(图片方向)

/**
 Convert an EXIF image orientation to an iOS one.

 @param exifOrientation EXIF orientation
 @return iOS orientation
 */
+ (UIImageOrientation)imageOrientationFromEXIFOrientation:(CGImagePropertyOrientation)exifOrientation;

/**
 Convert an iOS orientation to an EXIF image orientation.

 @param imageOrientation iOS orientation
 @return EXIF orientation
 */
+ (CGImagePropertyOrientation)exifOrientationFromImageOrientation:(UIImageOrientation)imageOrientation;


@end

NS_ASSUME_NONNULL_END
