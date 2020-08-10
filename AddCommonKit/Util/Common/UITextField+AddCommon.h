//
//  UITextField+AddCommon.h
//  111
//
//  Created by hfk on 2020/6/28.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (AddCommon)

+(UITextField *)createTextField:(CGRect)rect;

+(UITextField *)createTextField:(CGRect)rect placeholder:(NSString *)placeholder delegate:(id)delegate font:(UIFont *)font textColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
