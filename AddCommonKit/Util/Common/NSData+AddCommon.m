//
//  NSData+AddCommon.m
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/13.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "NSData+AddCommon.h"

@implementation NSData (AddCommon)

+(double)CompareDateStartTime:(NSString *)startTime endTime:(NSString *)endTime WithFormatter:(NSString *)format{
    double result = 0;
    if ([NSString isNotEmpty:startTime] && [NSString isNotEmpty:endTime]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:format];
        NSDate *startdate = [formatter dateFromString:startTime];
        NSDate *enddate = [formatter dateFromString:endTime];
        result = [enddate timeIntervalSinceReferenceDate] - [startdate timeIntervalSinceReferenceDate];
    }
    return result;
}
@end
