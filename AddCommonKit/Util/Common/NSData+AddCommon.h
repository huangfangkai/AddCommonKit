//
//  NSData+AddCommon.h
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/13.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AddCommon)

+(double)CompareDateStartTime:(NSString *)startTime endTime:(NSString *)endTime WithFormatter:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
