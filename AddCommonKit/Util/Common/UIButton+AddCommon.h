//
//  UIButton+AddCommon.h
//  111
//
//  Created by hfk on 2020/6/24.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (AddCommon)
///按钮创建
+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate;

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
                      type:(UIButtonType)type;

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
               normalImage:(UIImage *)normalImage
          highlightedImage:(UIImage *)highlightedImage;

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
               normalImage:(UIImage *)normalImage
          highlightedImage:(UIImage *)highlightedImage
                     title:(NSString *)title
                      font:(UIFont *)font
                     color:(UIColor *)color;

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
     normalBackgroundImage:(UIImage *)normalImage
highlightedBackgroundImage:(UIImage *)highlightedImage
                     title:(NSString *)title
                      font:(UIFont *)font
                     color:(UIColor *)color;

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
               normalImage:(UIImage *)normalImage
             selectedImage:(UIImage *)selImage
                     title:(NSString *)title
                      font:(UIFont *)font
               normalcolor:(UIColor *)norcolor
             selectedcolor:(UIColor *)selcolor;

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
                     title:(NSString *)title
                      font:(UIFont *)font
                titleColor:(UIColor *)color;

// 文字对齐
- (void)setImage:(UIImage *)image
     buttonTitle:(NSString *)title
        forState:(UIControlState)stateType;


//上下居中，图片在上，文字在下
- (void)verticalCenterImageAndTitle:(CGFloat)spacing;
- (void)verticalCenterImageAndTitle; //默认6.0

//左右居中，文字在左，图片在右
- (void)horizontalCenterTitleAndImage:(CGFloat)spacing;
- (void)horizontalCenterTitleAndImage; //默认6.0

//左右居中，图片在左，文字在右
- (void)horizontalCenterImageAndTitle:(CGFloat)spacing;
- (void)horizontalCenterImageAndTitle; //默认6.0

//文字居中，图片在左边
- (void)horizontalCenterTitleAndImageLeft:(CGFloat)spacing;
- (void)horizontalCenterTitleAndImageLeft; //默认6.0

//文字居中，图片在右边
- (void)horizontalCenterTitleAndImageRight:(CGFloat)spacing;
- (void)horizontalCenterTitleAndImageRight; //默认6.0

- (void)addAttrDict:(NSDictionary *)attrDict toStr:(NSString *)str;
- (void)addAttrDict:(NSDictionary *)attrDict toRange:(NSRange)range;


@end

NS_ASSUME_NONNULL_END
