//
//  UserData.m
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/7.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "UserData.h"

@implementation UserData

static UserData *userInfo;

static UserData *shared_manager = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedManager {
    dispatch_once(&onceToken, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *userInfoData = [userDefaults objectForKey:@"userData_userInfo"];
        UserData *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userInfoData];
        if (userInfo != nil) {
            self.account    = userInfo.account;
            self.password   = userInfo.password;
            self.token      = userInfo.token;
            self.loginType       = userInfo.loginType;
            self.merchantId       = userInfo.merchantId;
            self.merchantName       = userInfo.merchantName;
            
            if (userInfo.arr_selectGoods) {
                self.arr_selectGoods = userInfo.arr_selectGoods;
            }else{
                self.arr_selectGoods = [NSMutableArray array];
            }
        }else{
            self.account = @"";
            self.password = @"";
            self.loginType = @"0";
            self.merchantId = @"";
            self.merchantName = @"";
            self.arr_selectGoods = [NSMutableArray array];
        }
        //        self.cache01 = [userDefaults objectForKey:@"01"];
    }
    return self;
}
+(void)attempDealloc{
    onceToken = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    shared_manager= nil;
}
-(void)saveUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *userInfoData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [userDefaults setObject:userInfoData forKey:@"userData_userInfo"];
    userInfo = self;
    [userDefaults synchronize];
}
+ (void)clearUserInfo{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [self attempDealloc];
//
//    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
//    NSDictionary* defaults = [defs dictionaryRepresentation];
//    for (id key in defaults) {
//        if ([key isEqualToString:@"userData_userInfo"]) {
//            [defs removeObjectForKey:key];
//            [defs synchronize];
//        }
//    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_account    forKey:@"account"];
    [aCoder encodeObject:_password   forKey:@"password"];
    [aCoder encodeObject:_token     forKey:@"token"];
    [aCoder encodeObject:_loginType       forKey:@"loginType"];
    [aCoder encodeObject:_merchantId       forKey:@"merchantId"];
    [aCoder encodeObject:_merchantName       forKey:@"merchantName"];
    //    NSMutableArray *array = [NSMutableArray array];
    //    for (Goods *model in _arr_selectGoods) {
    //        [array addObject:model.mj_keyValues];
    //    }
    //    [aCoder encodeObject:array forKey:@"arr_goods"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.account    = [aDecoder decodeObjectForKey:@"account"];
        self.password   = [aDecoder decodeObjectForKey:@"password"];
        self.token   = [aDecoder decodeObjectForKey:@"token"];
        self.loginType       = [aDecoder decodeObjectForKey:@"loginType"];
        self.merchantId     = [aDecoder decodeObjectForKey:@"merchantId"];
        self.merchantName     = [aDecoder decodeObjectForKey:@"merchantName"];
        //
        //NSMutableArray *array = [aDecoder decodeObjectForKey:@"arr_goods"];
        //       self.arr_selectGoods = [NSMutableArray array];
        //       for (NSDictionary *dict in array) {
        //           [self.arr_selectGoods addObject:[Goods mj_objectWithKeyValues:dict]];
        //       }
    }
    return self;
}
- (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}



@end
