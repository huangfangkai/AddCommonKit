//
//  UIButton+AddCommon.m
//  111
//
//  Created by hfk on 2020/6/24.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "UIButton+AddCommon.h"

@implementation UIButton (AddCommon)
+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
                      type:(UIButtonType)type
{
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = rect;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    if ([delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
               normalImage:(UIImage *)normalImage
          highlightedImage:(UIImage *)highlightedImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = rect;
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
               normalImage:(UIImage *)normalImage
          highlightedImage:(UIImage *)highlightedImage
                     title:(NSString *)title
                      font:(UIFont *)font
                     color:(UIColor *)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = rect;
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateHighlighted];
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
     normalBackgroundImage:(UIImage *)normalImage
highlightedBackgroundImage:(UIImage *)highlightedImage
                     title:(NSString *)title
                      font:(UIFont *)font
                     color:(UIColor *)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = rect;
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    btn.titleLabel.font = font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateHighlighted];
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}
+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
               normalImage:(UIImage *)normalImage
             selectedImage:(UIImage *)selImage
                     title:(NSString *)title
                      font:(UIFont *)font
               normalcolor:(UIColor *)norcolor
             selectedcolor:(UIColor *)selcolor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = rect;
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:norcolor forState:UIControlStateNormal];
    [btn setTitleColor:selcolor forState:UIControlStateSelected];
    btn.titleLabel.font = font;
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+ (UIButton *)createButton:(CGRect)rect
                    action:(SEL)sel
                  delegate:(id)delegate
                     title:(NSString *)title
                      font:(UIFont *)font
                titleColor:(UIColor *)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = rect;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateHighlighted];
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

// 文字对齐
- (void)setImage:(UIImage *)image
     buttonTitle:(NSString *)title
        forState:(UIControlState)stateType
{
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    CGSize titleSize;
    if ([NSString instancesRespondToSelector:@selector(sizeWithAttributes:)]) {
        titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    }
//    else {
//        titleSize = [title sizeWithFont:[UIFont systemFontOfSize:10]];
//    }
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0,
                                              0.0,
                                              20,
                                              0)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(CGRectGetHeight(self.bounds)-20,
                                              -image.size.width,
                                              0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}


- (void)verticalCenterImageAndTitle:(CGFloat)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing/2), 0.0);
    
    // the text width might have changed (in case it was shortened before due to
    // lack of space and isn't anymore now), so we get the frame size again
    titleSize = self.titleLabel.frame.size;
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing/2), 0.0, 0.0, - titleSize.width);
}

- (void)verticalCenterImageAndTitle
{
    const int DEFAULT_SPACING = 6.0f;
    [self verticalCenterImageAndTitle:DEFAULT_SPACING];
}


- (void)horizontalCenterTitleAndImage:(CGFloat)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing/2);
    
    // the text width might have changed (in case it was shortened before due to
    // lack of space and isn't anymore now), so we get the frame size again
    titleSize = self.titleLabel.frame.size;
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing/2, 0.0, - titleSize.width);
}

- (void)horizontalCenterTitleAndImage
{
    const int DEFAULT_SPACING = 6.0f;
    [self horizontalCenterTitleAndImage:DEFAULT_SPACING];
}


- (void)horizontalCenterImageAndTitle:(CGFloat)spacing;
{

    self.titleEdgeInsets = UIEdgeInsetsMake(0.0,  0.0, 0.0,  - spacing/2);
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, - spacing/2, 0.0, 0.0);
}

- (void)horizontalCenterImageAndTitle;
{
    const int DEFAULT_SPACING = 6.0f;
    [self horizontalCenterImageAndTitle:DEFAULT_SPACING];
}


- (void)horizontalCenterTitleAndImageLeft:(CGFloat)spacing
{
    // get the size of the elements here for readability
    //    CGSize imageSize = self.imageView.frame.size;
    //    CGSize titleSize = self.titleLabel.frame.size;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, - spacing, 0.0, 0.0);
}

- (void)horizontalCenterTitleAndImageLeft
{
    const int DEFAULT_SPACING = 6.0f;
    [self horizontalCenterTitleAndImageLeft:DEFAULT_SPACING];
}


- (void)horizontalCenterTitleAndImageRight:(CGFloat)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, 0.0);
    
    // the text width might have changed (in case it was shortened before due to
    // lack of space and isn't anymore now), so we get the frame size again
    titleSize = self.titleLabel.frame.size;
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + imageSize.width + spacing, 0.0, - titleSize.width);
}

- (void)horizontalCenterTitleAndImageRight
{
    const int DEFAULT_SPACING = 6.0f;
    [self horizontalCenterTitleAndImageRight:DEFAULT_SPACING];
}
- (void)addAttrDict:(NSDictionary *)attrDict toStr:(NSString *)str{
    if (str.length <= 0) {
        return;
    }
    NSMutableAttributedString *attrStr = self.titleLabel.attributedText ? self.titleLabel.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    [self addAttrDict:attrDict toRange:[attrStr.string rangeOfString:str]];
}

- (void)addAttrDict:(NSDictionary *)attrDict toRange:(NSRange)range{
    if (range.location == NSNotFound || range.length <= 0) {
        return;
    }
    NSMutableAttributedString *attrStr = self.titleLabel.attributedText ? self.titleLabel.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    if (range.location + range.length > attrStr.string.length) {
        return;
    }
    [attrStr addAttributes:attrDict range:range];
    self.titleLabel.attributedText = attrStr;
}

@end
