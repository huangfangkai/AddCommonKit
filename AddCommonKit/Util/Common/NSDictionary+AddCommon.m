//
//  NSDictionary+AddCommon.m
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/8.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "NSDictionary+AddCommon.h"

@implementation NSDictionary (AddCommon)

- (NSDictionary *)deleteAllNullValue{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in self.allKeys) {
        if ([[self objectForKey:keyStr] isEqual:[NSNull null]]) {
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            [mutableDic setObject:[self objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}

@end
