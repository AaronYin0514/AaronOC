//
//  SortViewController.m
//  AaronOC_Example
//
//  Created by AaronYin on 2020/2/24.
//  Copyright © 2020 AaronYin0514. All rights reserved.
//

#import "SortViewController.h"
#import "ZZSort.h"

@interface SortModel : NSObject

@property (nonatomic, assign) NSInteger level;

@end

@implementation SortModel

@end

@interface SortViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<SortModel *> *models;

@property (nonatomic, strong) NSArray<NSString *> *dataSource;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SortViewController

- (instancetype)init {
    if (self = [super init]) {
        
        self.dataSource = @[
            @"冒泡排序",
            @"选择排序",
        ];
        
        NSArray<NSNumber *> *n = @[@9, @3, @7, @8, @2, @1, @5, @4, @6, @0];
        NSMutableArray<SortModel *> *models = [NSMutableArray arrayWithCapacity:n.count];
        for (NSNumber *num in n) {
            SortModel *model = [[SortModel alloc] init];
            model.level = num.integerValue;
            [models addObject:model];
        }
        self.models = models;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

// 冒泡排序
- (void)bubbleSort {
    NSArray *results = [ZZSort bubbleSortWithArray:self.models change:^BOOL(SortModel *value1, SortModel *value2) {
        return value1.level > value2.level;
    }];
    for (SortModel *model in results) {
        NSLog(@"%ld", model.level);
    }
}

- (void)selectSort {
    NSArray *results = [ZZSort selectSortWithArray:self.models change:^BOOL(SortModel *value1, SortModel *value2) {
        return value1.level > value2.level;
    }];
    for (SortModel *model in results) {
        NSLog(@"%ld", model.level);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self bubbleSort];
    } else if (indexPath.row == 1) {
        [self selectSort];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"id"];
    }
    return _tableView;
}

@end
