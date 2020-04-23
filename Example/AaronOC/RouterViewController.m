//
//  RouterViewController.m
//  AaronOC_Example
//
//  Created by AaronYin on 2020/4/12.
//  Copyright © 2020 AaronYin0514. All rights reserved.
//

#import "RouterViewController.h"
#import <AaronOC/AaronOC.h>
#import <objc/runtime.h>

static NSString *isRestFulURLKey = @"URL_COLA_IsRestFulURLKey";

@interface NSURL (Cola)

@property (nonatomic, assign) BOOL isRestFulURL;

+ (nullable instancetype)URLWithRestFulRegisterString:(NSString *)URLString;

@end

@interface RouterViewController ()

@property (nonatomic, strong) NSArray *aaray1;
@property (nonatomic, strong) NSArray *aaray2;

@property (nonatomic, strong) Cola *cola;

@end

@implementation RouterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    NSString *url = @"myapp://user/<int:id>/<string:name>/<float:height>";
    NSArray *paths = [url componentsSeparatedByString:@"/"];
    for (NSString *path in paths) {
        NSLog(@"%@", path);
        if (path.length <= 2 || ![path hasPrefix:@"<"] || ![path hasSuffix:@">"] || ![path containsString:@":"]) {
            continue;
        }
        NSString *str = [path substringWithRange:NSMakeRange(1, path.length - 2)];
        NSArray *arr = [str componentsSeparatedByString:@":"];
        if (arr.count != 2) { continue; }
        NSString *type = arr.firstObject;
        NSString *parameter = arr.lastObject;
        if ([type isEqualToString:@"string"]) {
//            NSLog(@"string类型：%@", parameter);
        } else if ([type isEqualToString:@"int"]) {
//            NSLog(@"int类型：%@", parameter);
        } else if ([type isEqualToString:@"float"]) {
//            NSLog(@"float类型：%@", parameter);
        } else {
//            NSLog(@"异常类型");
        }
    }
    
    NSString *url1 = @"myapp://user/1/dajiaho/10.5";
    
    NSURL *testURL = [NSURL URLWithString:url1];
    
    if (!testURL) {
        NSLog(@"URL XXXXXXX");
    } else {
        NSLog(@"URL");
    }
    
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
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, [UIScreen mainScreen].bounds.size.width - 200, 44)];
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
//    [self test1];
    
    NSURL *url = [NSURL URLWithString:@"navigator://test1?title=test1"];
    NSDictionary *userInfo = @{@"color": [UIColor orangeColor]};
//    [Cola.cola pushURL:[NSURL URLWithString:@"navigator://test1?title=test1"] withUserInfo:@{@"color": [UIColor greenColor]}];
    
//    [Cola.cola presentURL:[NSURL URLWithString:@"navigator://test1?title=test1"] withUserInfo:@{@"color": [UIColor orangeColor]} completion:^{
//        NSLog(@"xxx");
//    }];
    
    [Cola.cola presentURL:url withUserInfo:userInfo from:nil wrap:UINavigationController.class animated:YES completion:^{
        NSLog(@"xxx2");
    }];
    
    
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



@end

@implementation NSURL (Cola)

- (void)setIsRestFulURL:(BOOL)isRestFulURL {
    objc_setAssociatedObject(self, &isRestFulURLKey, @(isRestFulURL), OBJC_ASSOCIATION_COPY);
}

- (BOOL)isRestFulURL {
    return [objc_getAssociatedObject(self, &isRestFulURLKey) boolValue];
}

+ (nullable instancetype)URLWithRestFulRegisterString:(NSString *)URLString {
    NSArray *paths = [URLString componentsSeparatedByString:@"/"];
    NSMutableString *newURLString = [NSMutableString string];
    for (NSInteger idx = 0; idx < paths.count; idx++) {
        NSString *path = paths[idx];
        if (path.length <= 2 || ![path hasPrefix:@"<"] || ![path hasSuffix:@">"] || ![path containsString:@":"]) {
            [newURLString appendFormat:@"%@/", path];
            continue;
        }
        NSString *str = [path substringWithRange:NSMakeRange(1, path.length - 2)];
        NSArray *arr = [str componentsSeparatedByString:@":"];
        if (arr.count != 2) { continue; }
        NSString *type = arr.firstObject;
        NSString *parameter = arr.lastObject;
        [newURLString appendString:@"__/"];
        if ([type isEqualToString:@"string"]) {
            NSLog(@"string类型：%@", parameter);
        } else if ([type isEqualToString:@"int"]) {
            NSLog(@"int类型：%@", parameter);
        } else if ([type isEqualToString:@"float"]) {
            NSLog(@"float类型：%@", parameter);
        } else {
            NSLog(@"异常类型");
            return nil;
        }
    }
    NSURL *url = [NSURL URLWithString:newURLString];
    url.isRestFulURL = YES;
    return url;
}

@end
