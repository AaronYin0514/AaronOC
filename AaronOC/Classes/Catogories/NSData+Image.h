//
//  NSData+Image.h
//  GitHubC
//
//  Created by AaronYin on 2019/9/5.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger GHImageFormat NS_TYPED_EXTENSIBLE_ENUM;
static const GHImageFormat GHImageFormatUndefined = -1;
static const GHImageFormat GHImageFormatJPEG      = 0;
static const GHImageFormat GHImageFormatPNG       = 1;
static const GHImageFormat GHImageFormatGIF       = 2;
static const GHImageFormat GHImageFormatTIFF      = 3;
static const GHImageFormat GHImageFormatWebP      = 4;
static const GHImageFormat GHImageFormatHEIC      = 5;
static const GHImageFormat GHImageFormatHEIF      = 6;

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Image)

#pragma mark - 图片格式
/**
 *  Return image format
 *
 *  @param data the input image data
 *
 *  @return the image format as `GHImageFormat` (enum)
 */
+ (GHImageFormat)imageFormatForImageData:(nullable NSData *)data;

#pragma mark - GIF

- (UIImage *)decodedGIFImageWithData:(NSData *)data scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
