//
//  UITextView+AddCommon.m
//  111
//
//  Created by hfk on 2020/6/29.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "UITextView+AddCommon.h"

@implementation UITextView (AddCommon)

+(UITextView *)createUITextView:(CGRect)rect delegate:(id)delegate font:(UIFont *)font textColor:(UIColor *)color
{
    UITextView *textView=[[UITextView alloc] initWithFrame:rect];
    textView.delegate=delegate;

    textView.font=font;
    textView.textColor=color;
    textView.backgroundColor=[UIColor clearColor];
    return textView;
}


@end
