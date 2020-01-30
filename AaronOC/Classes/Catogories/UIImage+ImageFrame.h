//
//  UIImage+ImageFrame.h
//  GitHubC
//
//  Created by AaronYin on 2019/9/6.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHImageFrameProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ImageFrame) <GHImageFrameProtocol>

/**
 GIF图片每一帧的时间长度
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 GIF图片循环次数
 */
@property (nonatomic, assign) NSUInteger imageLoopCount;

@end

NS_ASSUME_NONNULL_END
