//
//  UIColor+AddCommon.h
//  111
//
//  Created by hfk on 2020/6/24.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (AddCommon)

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
};
/// 随机颜色
+(UIColor *)randomColor;

/// 从十六进制字符串获取颜色
/// @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color;

/// 从十六进制字符串获取颜色
/// @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
/// @param alpha 透明度
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
///渐变色
+ (UIImage *)getGradientImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;


@end

NS_ASSUME_NONNULL_END
