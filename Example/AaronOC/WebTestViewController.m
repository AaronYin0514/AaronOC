//
//  WebTestViewController.m
//  AaronOC_Example
//
//  Created by AaronYin on 2020/5/13.
//  Copyright © 2020 AaronYin0514. All rights reserved.
//

#import "WebTestViewController.h"

@interface WebTestViewController ()

@end

@implementation WebTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRequestWithURLString:@"https://www.github.com"];
}

@end
