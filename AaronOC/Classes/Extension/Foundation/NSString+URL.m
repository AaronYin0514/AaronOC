//
//  NSString+URL.m
//  AaronOC
//
//  Created by AaronYin on 2020/4/20.
//

#import "NSString+URL.h"
#import "NSString+Encoding.h"

#pragma mark -

@implementation GHQueryStringPair

- (instancetype)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.field = field;
    self.value = value;

    return self;
}

- (NSString *)URLEncodedStringValue {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return [[self.field description] stringByURLEncode];
    } else {
        NSString *fieldURLEncodeString = [[self.field description] stringByURLEncode];
        NSString *valueURLEncodeString = [[self.value description] stringByURLEncode];
        return [NSString stringWithFormat:@"%@=%@", fieldURLEncodeString, valueURLEncodeString];
    }
}

@end

#pragma mark -

FOUNDATION_EXPORT NSArray * GHQueryStringPairsFromKeyAndValue(NSString * __nullable key, id value);

NSString * GHQueryStringFromParameters(NSDictionary *parameters) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (GHQueryStringPair *pair in GHQueryStringPairsFromDictionary(parameters)) {
        [mutablePairs addObject:[pair URLEncodedStringValue]];
    }

    return [mutablePairs componentsJoinedByString:@"&"];
}

NSArray * GHQueryStringPairsFromDictionary(NSDictionary *dictionary) {
    return GHQueryStringPairsFromKeyAndValue(nil, dictionary);
}

NSArray * GHQueryStringPairsFromKeyAndValue(NSString *key, id value) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];

    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];

    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = dictionary[nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:GHQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:GHQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:GHQueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[GHQueryStringPair alloc] initWithField:key value:value]];
    }

    return mutableQueryStringComponents;
}

//@implementation NSString (URL)
//
//@end
