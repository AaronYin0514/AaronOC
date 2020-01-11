//
//  UIPasteboard+Ext.m
//  GitHubC
//
//  Created by AaronYin on 2019/12/27.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import "UIPasteboard+Ext.h"

@implementation UIPasteboard (Ext)

+ (NSString *)pasteboardStrings {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *linkString = @"";
    for (NSString *str in pasteboard.strings) {
        linkString = [linkString stringByAppendingString:str];
    }
    if ([linkString isNotEmpty]) {
        return linkString;
    }
    return nil;
}

@end
