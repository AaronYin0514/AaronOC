//
//  JKWViewController.m
//  AaronOC
//
//  Created by AaronYin0514 on 01/11/2020.
//  Copyright (c) 2020 AaronYin0514. All rights reserved.
//

#import "JKWViewController.h"

@interface JKWViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<NSString *> *dataSource;

@end

@implementation JKWViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource = @[
        @"Sort"
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"事例";
    [self.view addSubview:self.tableView];
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
    NSString *controllerString = [NSString stringWithFormat:@"%@ViewController", self.dataSource[indexPath.row]];
    Class controllerClass = NSClassFromString(controllerString);
    UIViewController *controller = [[controllerClass alloc] init];
    controller.navigationItem.title = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
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
