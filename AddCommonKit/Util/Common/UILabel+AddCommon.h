//
//  UILabel+AddCommon.h
//  111
//
//  Created by hfk on 2020/6/24.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (AddCommon)

+ (UILabel *)createLable:(CGRect)rect;

+ (UILabel *)createLable:(CGRect)rect
                    text:(NSString *)text
                    font:(UIFont *)font
               textColor:(UIColor *)color
           textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)createLable:(CGRect)rect
                    text:(NSString *)text
                    font:(UIFont *)font
               textColor:(UIColor *)color
           textAlignment:(NSTextAlignment)textAlignment
             shadowColor:(UIColor *)shadowColor
            shadowOffset:(CGSize)size;

- (void)addAttrDict:(NSDictionary *)attrDict
              toStr:(NSString *)str;

- (void)addAttrDict:(NSDictionary *)attrDict
            toRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
