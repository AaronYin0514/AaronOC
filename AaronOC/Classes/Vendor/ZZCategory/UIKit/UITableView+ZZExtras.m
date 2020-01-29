//
//  UITableView+ZZExtras.m
//  FutureWindow
//
//  Created by Aaron on 16/8/12.
//  Copyright © 2016年 Newtouch. All rights reserved.
//

#import "UITableView+ZZExtras.h"

@implementation UITableView (ZZExtras)

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

- (void)reloadDataAfterHeaderRefreshWithNewDataCount:(NSUInteger)count {
    if (count == 0) return;
    [self reloadData];
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

- (void)registerNibWithDictionary:(NSDictionary *)dict {
    __weak typeof(self) weakSelf = self;
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        UINib *nib = [UINib nibWithNibName:key bundle:nil];
        [weakSelf registerNib:nib forCellReuseIdentifier:obj];
    }];
}

@end
