//
//  UILabel+AddCommon.m
//  111
//
//  Created by hfk on 2020/6/24.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "UILabel+AddCommon.h"

@implementation UILabel (AddCommon)
+ (UILabel *)createLable:(CGRect)rect
{
    UILabel *lbl = [[UILabel alloc]initWithFrame:rect];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textColor = [UIColor blackColor];
    return lbl;
}

+ (UILabel *)createLable:(CGRect)rect
                    text:(NSString *)text
                    font:(UIFont *)font
               textColor:(UIColor *)color
           textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label=[[UILabel alloc] initWithFrame:rect];
    label.text = [NSString stringIsExist:text];
    label.font = font;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *)createLable:(CGRect)rect
                    text:(NSString *)text
                    font:(UIFont *)font
               textColor:(UIColor *)color
           textAlignment:(NSTextAlignment)textAlignment
             shadowColor:(UIColor *)shadowColor
            shadowOffset:(CGSize)size
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    label.font = font;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = textAlignment;
    label.shadowColor = shadowColor;
    label.shadowOffset = size;
    return label;
}
- (void)addAttrDict:(NSDictionary *)attrDict
              toStr:(NSString *)str
{
    if (str.length <= 0) {
        return;
    }
    NSMutableAttributedString *attrStr = self.attributedText? self.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.text];
    [self addAttrDict:attrDict toRange:[attrStr.string rangeOfString:str]];
}
- (void)addAttrDict:(NSDictionary *)attrDict
            toRange:(NSRange)range
{
    if (range.location == NSNotFound || range.length <= 0) {
        return;
    }
    NSMutableAttributedString *attrStr = self.attributedText ? self.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.text];
    if (range.location + range.length > attrStr.string.length) {
        return;
    }
    [attrStr addAttributes:attrDict range:range];
    self.attributedText = attrStr;
}


@end
