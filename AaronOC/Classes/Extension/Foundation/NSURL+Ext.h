//
//  NSURL+Ext.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Ext)

@property (nullable, readonly, copy) NSString *apiString;

- (NSURL *)addParameter:(NSString *)parameter forKey:(NSString *)aKey;

- (NSURL *)addParametersWithDictionary:(NSDictionary<NSString *, NSString *> *)parameters;

@end

NS_ASSUME_NONNULL_END
