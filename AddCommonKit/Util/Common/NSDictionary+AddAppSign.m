//
//  NSDictionary+AddAppSign.m
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/16.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "NSDictionary+AddAppSign.h"

static NSString *APPKEY = @"app_ios_client";
static NSString *APPSERCERT = @"da883025fdb3d982ebf7110d78deae74";

@implementation NSDictionary (AddAppSign)

-(NSDictionary *)addAppSign{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self];
    NSString *time_stamp = [NSString stringWithFormat:@"%.0u", (unsigned int)[NSString getTimeStamp]];
    NSString *nonce_str = [NSString randomStringWithLength:10];
//    NSString *app_Version = [NSString getAppVersion];
    [params setObject:APPKEY forKey:@"app_key"];
    [params setObject:time_stamp forKey:@"time_stamp"];
    [params setObject:nonce_str forKey:@"nonce_str"];
    
    NSArray *allkeys = [params.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *key1 = [obj1 description];
        NSString *key2 = [obj2 description];
        return [key1 compare:key2];
    }];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in allkeys) {
        if ([NSString isNotEmpty:[params objectForKey:key]]) {
            [array addObject:[NSString stringWithFormat:@"%@=%@",key,[params objectForKey:key]]];
        }
    }
    [array addObject:[NSString stringWithFormat:@"app_secret=%@",APPSERCERT]];
    
    NSString *sign = [NSString getSelectResultWithArray:array WithCompare:@"&"];
    sign = sign.md5String;
    sign = sign.uppercaseString;
    [params setObject:sign forKey:@"sign"];
    return params;
}

@end
