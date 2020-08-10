//
//  NSDictionary+AddCommon.h
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/8.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (AddCommon)
//删除空类型
-(NSDictionary *)deleteAllNullValue;

@end

NS_ASSUME_NONNULL_END
