//
//  Cola.m
//  AaronOC
//
//  Created by AaronYin on 2020/4/17.
//

#import "Cola.h"
#import "NSString+Ext.h"
#import "NSURL+Ext.h"

ColaKey const ColaKeyUserInfo = @"com.cola.key.user.info";
//ColaKey const ColaKeyCompletion = @"com.cola.key.completion";
ColaKey const ColaKeyURL = @"com.cola.key.url";
ColaKey const ColaKeyURLParameters = @"com.cola.key.url.parameters";

static dispatch_queue_t cola_register_queue() {
    static dispatch_queue_t cola_register_queue;
    static dispatch_once_t cola_register_queue_once_token;
    dispatch_once(&cola_register_queue_once_token, ^{
        cola_register_queue = dispatch_queue_create("com.cola.queue.register", DISPATCH_QUEUE_CONCURRENT);
    });
    return cola_register_queue;
}

/**
static dispatch_queue_t cola_read_queue() {
    static dispatch_queue_t cola_read_queue;
    static dispatch_once_t cola_read_queue_once_token;
    dispatch_once(&cola_read_queue_once_token, ^{
        cola_read_queue = dispatch_queue_create("com.cola.queue.read", DISPATCH_QUEUE_SERIAL);
    });
    return cola_read_queue;
}
 */

@interface Cola()

@property (nonatomic, strong) NSMutableDictionary *routes;

@property (nonatomic, strong) dispatch_semaphore_t lock;

@end

@implementation Cola

+ (instancetype)cola {
    static Cola *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _lock = dispatch_semaphore_create(1);
        _routes = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - 注册URL

- (void)registerURL:(NSURL *)URL toHandler:(ColaHandler)handler {
    [self addURL:URL andHandler:handler];
}

- (void)registerURLPattern:(NSString *)URLPattern toHandler:(ColaHandler)handler {
    NSURL *url = [NSURL URLWithString:URLPattern];
    NSAssert(url != nil, @"URL格式不正确");
    [self registerURL:url toHandler:handler];
}

- (void)deregisterURL:(NSURL *)URL {
    [self removeURL:URL];
}

#pragma mark - 打开路由

- (BOOL)openURL:(NSURL *)URL object:(void(^)(id obj))object {
    return [self openURL:URL withUserInfo:nil object:object];
}

- (BOOL)openURL:(NSURL *)URL withUserInfo:(NSDictionary *)userInfo object:(void(^)(id obj))object {
    if (!URL) { return NO; }
    NSString *key = [self getKeyWithURL:URL];
    if (!key.length) { return NO; }
    ColaHandler handler = [self.routes objectForKey:key];
    if (handler) {
        NSMutableDictionary *urlParams = [self parametersForURL:URL];
        id obj = handler(URL, urlParams, userInfo);
        if (object) {
            object(obj);
        }
        return YES;
    }
    return NO;
}

#pragma mark - Private

- (void)addURL:(NSURL *)URL andHandler:(ColaHandler)handler {
    if (!URL || !handler) { return; }
    dispatch_async(self.registerQueue ?: cola_register_queue(), ^{
        NSString *key = [self getKeyWithURL:URL];
        if (!key.length) { return; }
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        self.routes[key] = [handler copy];
        dispatch_semaphore_signal(self.lock);
    });
}

- (void)removeURL:(NSURL *)URL {
    if (!URL) { return; }
    dispatch_async(self.registerQueue ?: cola_register_queue(), ^{
        NSString *key = [self getKeyWithURL:URL];
        if (!key.length) { return; }
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        [self.routes removeObjectForKey:key];
        dispatch_semaphore_signal(self.lock);
    });
}

#pragma mark - Utils

- (NSMutableDictionary *)parametersForURL:(NSURL *)URL {
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:URL resolvingAgainstBaseURL:NO];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:components.queryItems.count];
    for (NSURLQueryItem *item in components.queryItems) {
        params[item.name] = item.value;
    }
    return params;
}

- (NSString *)getKeyWithURL:(NSURL *)URL {
    NSString *apiString = [URL apiString];
    if (!apiString.length) { return nil; }
    return [apiString md5String];
}

@end
