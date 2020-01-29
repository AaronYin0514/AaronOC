//
//  UIImage+ZZExtras.m
//  FutureWindow
//
//  Created by Aaron on 16/8/12.
//  Copyright © 2016年 Newtouch. All rights reserved.
//

#import "UIImage+ZZExtras.h"
#import "UIImage+YYAdd.h"

@implementation UIImage (ZZExtras)

-(UIImage *)imageScale:(CGFloat)scale {
    if (scale <= 0) {
        return nil;
    }
    scale *= self.scale;
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scale, self.size.height * scale));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scale, self.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+(UIImage *)scaleImage:(UIImage *)image scale:(CGFloat)scale {
    if (!image || scale <= 0) {
        return nil;
    }
    return [image imageScale:scale];
}

-(UIImage *)imageCropInsetEdge:(UIEdgeInsets)insets {
    if (insets.top < 0 || insets.left <0 || insets.bottom < 0 || insets.right < 0) {
        return nil;
    }
    CGSize size = self.size;
    size.width -= insets.left + insets.right;
    size.height -= insets.top + insets.bottom;
    if (size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(-insets.left, -insets.top, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIImage *)imageCropInsetEdge:(UIEdgeInsets)insets withColor:(UIColor *)color {
    if (insets.top < 0 || insets.left <0 || insets.bottom < 0 || insets.right < 0) {
        return nil;
    }
    
    if (!color) {
        return [self imageCropInsetEdge:insets];
    }
    
    CGRect rect = CGRectMake(insets.left, insets.top, self.size.width - insets.left - insets.right, self.size.height - insets.top - insets.bottom);
    
    UIImage *cropImage = [self imageByCropToRect:rect];
    
    if (cropImage) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0, 0, self.size.width, self.size.height));
        CGContextAddPath(context, path);
        CGContextEOFillPath(context);
        CGPathRelease(path);
        [cropImage drawInRect:rect];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    } else {
        return nil;
    }
}

+(UIImage *)captureView:(UIView *)theView {
    if (!theView) return nil;
    CGRect rect = theView.frame;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(UIImage *)captureView:(UIView *)theView fromRect:(CGRect)rect {
    if (!theView) {
        return nil;
    }
    CGRect standardizeRect = CGRectStandardize(rect);
    CGRect captureRect = CGRectIntersection(theView.bounds, standardizeRect);
    if (CGRectIsNull(captureRect) || CGRectIsEmpty(captureRect)) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(captureRect.size, NO, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
