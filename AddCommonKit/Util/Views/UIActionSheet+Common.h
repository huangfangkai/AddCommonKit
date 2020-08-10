//
//  UIActionSheet+Common.h
//  DreamWeaver
//
//  Created by hfk on 2018/7/13.
//  Copyright © 2018年 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Common)

+ (instancetype)bk_actionSheetCustomWithTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles destructiveTitle:(NSString *)destructiveTitle cancelTitle:(NSString *)cancelTitle andDidDismissBlock:(void (^)(UIActionSheet *sheet, NSInteger index))block;


@end
