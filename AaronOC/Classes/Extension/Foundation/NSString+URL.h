//
//  NSString+URL.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A helper method to generate encoded url query parameters for appending to the end of a URL.

 @param parameters A dictionary of key/values to be encoded.

 @return A url encoded query string
 */
FOUNDATION_EXPORT NSString * GHQueryStringFromParameters(NSDictionary *parameters);

FOUNDATION_EXPORT NSArray * GHQueryStringPairsFromDictionary(NSDictionary *dictionary);

@interface GHQueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (instancetype)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValue;
@end

//@interface NSString (URL)
//
//@end

NS_ASSUME_NONNULL_END
