//
//  NSURL+Ext.m
//  AaronOC
//
//  Created by AaronYin on 2020/4/17.
//

#import "NSURL+Ext.h"
#import "NSString+URL.h"

@implementation NSURL (Ext)

- (NSString *)apiString {
    NSString *apiString = @"";
    if (self.scheme) {
        apiString = [apiString stringByAppendingFormat:@"%@://", self.scheme];
    }
    if (self.host) {
        apiString = [apiString stringByAppendingString:self.host];
    }
    if (self.port) {
        apiString = [apiString stringByAppendingFormat:@":%@", self.port];
    }
    if (self.path) {
        apiString = [apiString stringByAppendingString:self.path];
    }
    return apiString;
}

- (NSURL *)addParameter:(NSString *)parameter forKey:(NSString *)aKey {
    if (!parameter.length || !aKey.length) { return nil; }
    return [self addParametersWithDictionary:@{aKey: parameter}];
}

- (NSURL *)addParametersWithDictionary:(NSDictionary<NSString *, NSString *> *)parameters {
    if (!self.absoluteString.length || !parameters.count) { return nil; }
    NSString *query = GHQueryStringFromParameters(parameters);
    return [NSURL URLWithString:[self.absoluteString stringByAppendingFormat:self.query ? @"&%@" : @"?%@", query]];
}

@end
