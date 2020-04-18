//
//  NSString+Ext.m
//  AaronOC
//
//  Created by AaronYin on 2020/4/17.
//

#import "NSString+Ext.h"
#import "NSData+Ext.h"

@implementation NSString (Ext)

- (NSString *)md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}

@end
