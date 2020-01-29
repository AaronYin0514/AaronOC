//
//  UITableView+ZZExtras.h
//  FutureWindow
//
//  Created by Aaron on 16/8/12.
//  Copyright © 2016年 Newtouch. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (ZZExtras)

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

/**
 *  上拉刷新后插入数据后更新
 *
 *  @param count 新插入数据的条数
 */
- (void)reloadDataAfterHeaderRefreshWithNewDataCount:(NSUInteger)count;

- (void)registerNibWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
