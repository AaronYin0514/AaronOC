//
//  UIImage+ZZExtras.h
//  FutureWindow
//
//  Created by Aaron on 16/8/12.
//  Copyright © 2016年 Newtouch. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZZExtras)

/**
 *  缩放图片
 *
 *  @param scale 缩放比例，大于0
 *
 *  @return 缩放后的图片
 */
-(nullable UIImage *)imageScale:(CGFloat)scale;

/**
 *  缩放图片
 *
 *  @param image 要缩放的图片
 *  @param scale 缩放比例，大于0
 *
 *  @return 缩放后的图片
 */
+(nullable UIImage *)scaleImage:(nullable UIImage *)image scale:(CGFloat)scale;

/**
 *  从边缘剪切下来的图片，insets值必须大于等于0
 *
 *  @param insets 边缘值
 *
 *  @return 剪切下来的图片
 */
-(nullable UIImage *)imageCropInsetEdge:(UIEdgeInsets)insets;

/**
 *  从边缘剪切下来的图片,并用颜色填充边缘，insets值必须大于等于0
 *
 *  @param insets 边缘值
 *  @param color  填充色
 *
 *  @return 剪切下来的图片
 */
-(nullable UIImage *)imageCropInsetEdge:(UIEdgeInsets)insets withColor:(UIColor *)color;

/**
 *  从指定view上截图
 *
 *  @param theView 要截取的视图
 *
 *  @return 截取下来的图片
 */
+(nullable UIImage *)captureView:(UIView *)theView;

/**
 *  截取视图上指定位置的图片
 *
 *  @param theView 要截取的视图
 *  @param rect    位置
 *
 *  @return 截取下来的图片
 */
+(nullable UIImage *)captureView:(UIView *)theView fromRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
