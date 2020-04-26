//
//  NSString+Encoding.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Encoding)

#pragma mark - Base64
/**
 Returns an NSString for base64 encoded.
 */
- (nullable NSString *)base64EncodedString;

/**
 Returns an NSString from base64 encoded string.
 @param base64EncodedString The encoded string.
 */
+ (nullable NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;

#pragma mark - URL

- (NSString *)stringByURLEncode;

- (NSString *)stringByURLDecode;

#pragma mark - Unicode
/**
Returns a percent-escaped string following RFC 3986 for a query string key or value.
RFC 3986 states that the following characters are "reserved" characters.
   - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
   - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="

In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
should be percent-escaped in the query string.
   - parameter string: The string to be percent-escaped.
   - returns: The percent-escaped string.
*/
- (NSString *)unicodeEncodingString;

- (NSString *)unicodeDecodingString;

@end

NS_ASSUME_NONNULL_END
