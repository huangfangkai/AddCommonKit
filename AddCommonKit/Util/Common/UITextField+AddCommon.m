//
//  UITextField+AddCommon.m
//  111
//
//  Created by hfk on 2020/6/28.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "UITextField+AddCommon.h"

@implementation UITextField (AddCommon)

//创建UITextField
+(UITextField *)createTextField:(CGRect)rect
{
    UITextField *txtField = [[UITextField alloc]initWithFrame:rect];
    txtField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtField.borderStyle = UITextBorderStyleRoundedRect;
    txtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtField.font = [UIFont systemFontOfSize:16];
    txtField.textColor = [UIColor blackColor];
    return txtField;
}

+(UITextField *)createTextField:(CGRect)rect placeholder:(NSString *)placeholder delegate:(id)delegate font:(UIFont *)font textColor:(UIColor *)color
{
    UITextField *textField = [[UITextField alloc]initWithFrame:rect];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = font;
    textField.textColor = color;
    textField.placeholder = [placeholder isEqual:[NSNull null]]?@"":placeholder;
    textField.delegate = delegate;
    return textField;
}


@end
