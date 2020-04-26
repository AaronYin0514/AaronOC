//
//  UITableView+ZZExtras.m
//  FutureWindow
//
//  Created by Aaron on 16/8/12.
//  Copyright © 2016年 Newtouch. All rights reserved.
//

#import "UITableView+Ext.h"

@implementation UITableView (Ext)

- (void)tableViewScrollToBottom:(BOOL)animated {
    NSInteger sectionCount = self.numberOfSections;
    if (sectionCount < 1) return;
    NSInteger rowCount = [self numberOfRowsInSection:(sectionCount - 1)];
    if (rowCount < 1) return;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(rowCount - 1) inSection:(sectionCount - 1)];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

- (void)tableViewScrollToTop:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

@end
