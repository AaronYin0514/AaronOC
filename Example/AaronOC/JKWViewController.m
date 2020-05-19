//
//  JKWViewController.m
//  AaronOC
//
//  Created by AaronYin0514 on 01/11/2020.
//  Copyright (c) 2020 AaronYin0514. All rights reserved.
//

#import "JKWViewController.h"
#import "WKWebViewController.h"
#import <SafariServices/SafariServices.h>
#import "KeychainItemWrapper.h"

@interface TestNavigationController : UINavigationController

@end

@implementation TestNavigationController

@end

@interface JKWViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<NSString *> *dataSource;

@end

@implementation JKWViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource = @[
        @"Sort",
        @"Router",
        @"WebTest",
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"事例";
    [self.view addSubview:self.tableView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 100, 44)];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)testAction:(UIButton *)sender {
//    Class class = TestNavigationController.class;
//    if (class && [[[class alloc] init] isKindOfClass:[UINavigationController class]]) {
//        UIViewController *controller = [UIViewController new];
//        controller.view.backgroundColor = [UIColor greenColor];
//        UINavigationController *nav = [[class alloc] initWithRootViewController:controller];
//        [self presentViewController:nav animated:YES completion:^{
//
//        }];
//    }
    
    
    
    SFSafariViewControllerConfiguration *c = [[SFSafariViewControllerConfiguration alloc] init];
    c.entersReaderIfAvailable = YES;
    c.barCollapsingEnabled = YES;
    NSURL *url = [NSURL URLWithString:@"https://www.github.com"];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url configuration:c];
//    safariVC.delegate = self;
    //    self.navigationController.navigationBarHidden = YES;
    //    [self.navigationController pushViewController:safariVC animated:YES];
        // 建议
    [self presentViewController:safariVC animated:YES completion:nil];
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
