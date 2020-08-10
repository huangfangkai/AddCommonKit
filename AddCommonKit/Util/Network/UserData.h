//
//  UserData.h
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/7.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserData : NSObject

@property (nonatomic, copy) NSString *account;        //登录账号
@property (nonatomic, copy) NSString *password;       //密码
@property (nonatomic, copy) NSString *token;          //token
@property (nonatomic, copy) NSString *loginType;    //类型 0-用户 1-管家
@property (nonatomic, copy) NSString *merchantId;     //商家id
@property (nonatomic, copy) NSString *merchantName;     //商家name
@property (nonatomic, strong) NSMutableArray *arr_selectGoods; //已选商品数组

//单例对象
+ (instancetype)sharedManager;
//单列销毁
+(void)attempDealloc;

- (void)saveUserInfo;

+ (void)clearUserInfo;



@end

NS_ASSUME_NONNULL_END
