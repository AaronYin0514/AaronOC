//
//  UITableView+ZZExtras.h
//  FutureWindow
//
//  Created by Aaron on 16/8/12.
//  Copyright © 2016年 Newtouch. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Ext)

/**
*  滚动到底部
*
*  @param animated 是否使用动画
*/
- (void)tableViewScrollToBottom:(BOOL)animated;

/**
 *  滚动到顶部
 *
 *  @param animated 是否使用动画
 */
- (void)tableViewScrollToTop:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
