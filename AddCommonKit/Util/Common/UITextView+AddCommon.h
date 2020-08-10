//
//  UITextView+AddCommon.h
//  111
//
//  Created by hfk on 2020/6/29.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (AddCommon)

+(UITextView *)createUITextView:(CGRect)rect delegate:(id)delegate font:(UIFont *)font textColor:(UIColor *)color;


@end

NS_ASSUME_NONNULL_END
