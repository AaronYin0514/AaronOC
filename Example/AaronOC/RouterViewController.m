//
//  RouterViewController.m
//  AaronOC_Example
//
//  Created by AaronYin on 2020/4/12.
//  Copyright © 2020 AaronYin0514. All rights reserved.
//

#import "RouterViewController.h"
#import <AaronOC/ZZRouter.h>
#import <AaronOC/Cola.h>

@interface RouterViewController ()

@property (nonatomic, strong) NSArray *aaray1;
@property (nonatomic, strong) NSArray *aaray2;

@property (nonatomic, strong) Cola *cola;

@end

@implementation RouterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
//    [ZZRouter registerURLPattern:@"test://path1/path2/path3/name" toHandler:^(NSDictionary *routerParameters) {
//        NSLog(@"%@", routerParameters);
//    }];
//
//    [ZZRouter openURL:@"test://path1/path2/path3/name" completion:^(id result) {
//        NSLog(@"完成");
//    }];
    
    self.cola = [Cola new];
    self.cola.registerQueue = dispatch_get_main_queue();
    
//    self.cola = [Cola cola];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 100, 44)];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)testAction:(UIButton *)sender {
//    [Cola cola];
//    [self parsingParamsBenchmark];
//    [self.class test];
    [self test1];
}

- (void)test1 {
    int count = 20000;
    NSMutableArray<NSString *> *urlStrings = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray<NSURL *> *urls = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        NSString *urlString = [NSString stringWithFormat:@"navigaror://test.test1.com/path/subpath%i?a=a&b=b&c=%d", i, i];
        [urlStrings addObject:urlString];
        NSURL *url = [NSURL URLWithString:urlString];
        [urls addObject:url];
    }
    
    NSTimeInterval begin, end, time;
    
    begin = CACurrentMediaTime();
    @autoreleasepool {
        for (int i = 0; i < count; i++) {
            
        }
        end = CACurrentMediaTime();
        time = end - begin;
        printf("ZZCola1:   %8.2f\n", time * 1000);
        for (int i = 0; i < count; i++) {
//            [self.cola objectForURL:urls[i] withUserInfo:@{@"test": @"test1"}];
        }
    }
    end = CACurrentMediaTime();
    time = end - begin;
    printf("ZZCola:   %8.2f\n", time * 1000);

//    begin = CACurrentMediaTime();
//    @autoreleasepool {
//        for (int i = 0; i < count; i++) {
//            [ZZRouter registerURLPattern:urlStrings[i] toHandler:^(NSDictionary *routerParameters) {}];
//        }
//        end = CACurrentMediaTime();
//        time = end - begin;
//        printf("ZZRouter1:   %8.2f\n", time * 1000);
//        for (int i = 0; i < count; i++) {
//            [ZZRouter openURL:urlStrings[i] completion:nil];
//        }
//    }
//    end = CACurrentMediaTime();
//    time = end - begin;
//    printf("ZZRouter:   %8.2f\n", time * 1000);
    
//    NSString *urlString = @"navigaror:///path/subpath1/subpath2/3/5/6/7?a=a&b=b&c=c";
//    NSURL *url = [NSURL URLWithString:urlString];
//    [Cola registerWithURL:url toHandler:^id (NSDictionary * parameters) {
//        NSLog(@"%@", parameters);
//        return nil;
//    }];
//    NSString *urlString2 = @"navigaror:///path/subpath1/subpath2/3/5/6/7?a=b&b=c&c=d";
//    NSURL *url2 = [NSURL URLWithString:urlString2];
//    [Cola openURL:url2 withUserInfo:@{@"test": @"ssss"} completion:^(id result) {
//        NSLog(@"xxxx");
//    }];
}

+ (void)test {
//    NSString *urlString = @"navigaror://test.test1.com/path/subpath1/subpath2/3/5/6/7?a=a&b=b&c=c";
    NSString *urlString = @"navigaror:///path/subpath1/subpath2/3/5/6/7?a=a&b=b&c=c";
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"absoluteString: %@", url.absoluteString);
    NSLog(@"relativeString: %@", url.relativeString);
    NSLog(@"url.absoluteURL.absoluteString: %@", url.absoluteURL.absoluteString);
    NSLog(@"url.baseURL.absoluteString: %@", url.baseURL.absoluteString);
    NSLog(@"scheme: %@", url.scheme);
    NSLog(@"resourceSpecifier: %@", url.resourceSpecifier);
    NSLog(@"host: %@", url.host);
    NSLog(@"port: %@", url.port);
    NSLog(@"user: %@", url.user);
    NSLog(@"password: %@", url.password);
    NSLog(@"path: %@", url.path);
    NSLog(@"fragment: %@", url.fragment);
    NSLog(@"query: %@", url.query);
    NSLog(@"relativePath: %@", url.relativePath);
    NSLog(@"pathComponents: %@", url.pathComponents);
    
    NSLog(@"pathExtension: %@", url.pathExtension);
    NSLog(@"parameterString: %@", url.parameterString);
}

- (void)parsingParamsBenchmark {
    int count = 2000;
    NSMutableArray<NSString *> *urlStrings = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray<NSURL *> *urls = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        NSString *urlString = [NSString stringWithFormat:@"navigaror://test.test1.com/path/subpath%i?a=a&b=b&c=%d", i, i];
        [urlStrings addObject:urlString];
        [ZZRouter registerURLPattern:urlString toHandler:nil];
        NSURL *url = [NSURL URLWithString:urlString];
        [urls addObject:url];
    }
    
//    self.aaray1 = urlStrings;
//    self.aaray2 = urls;
    
    NSMutableArray *results1 = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *results2 = [NSMutableArray arrayWithCapacity:count];

    NSTimeInterval begin, end, time;

    begin = CACurrentMediaTime();
    @autoreleasepool {
        for (int i = 0; i < count; i++) {
            NSURLComponents *components = [[NSURLComponents alloc] initWithURL:urls[i] resolvingAgainstBaseURL:NO];
            NSMutableDictionary *r = [NSMutableDictionary dictionaryWithCapacity:components.queryItems.count];
            for (NSURLQueryItem *item in components.queryItems) {
                r[item.name] = item.value;
            }
            [results1 addObject:r];
        }
    }
    end = CACurrentMediaTime();
    time = end - begin;
    printf("URL:   %8.2f\n", time * 1000);

    begin = CACurrentMediaTime();
    @autoreleasepool {
        for (int i = 0; i < count; i++) {
            NSDictionary *r = [[ZZRouter new] extractParametersFromURL:urlStrings[i] matchExactly:NO];
            [results2 addObject:r];
        }
    }
    end = CACurrentMediaTime();
    time = end - begin;
    printf("Router:   %8.2f\n", time * 1000);
    
}



@end
