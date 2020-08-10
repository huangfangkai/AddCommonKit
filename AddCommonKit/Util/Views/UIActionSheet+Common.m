//
//  UIActionSheet+Common.m
//  DreamWeaver
//
//  Created by hfk on 2018/7/13.
//  Copyright © 2018年 hfk. All rights reserved.
//

#import "UIActionSheet+Common.h"

@implementation UIActionSheet (Common)

+ (instancetype)bk_actionSheetCustomWithTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles destructiveTitle:(NSString *)destructiveTitle cancelTitle:(NSString *)cancelTitle andDidDismissBlock:(void (^)(UIActionSheet *sheet, NSInteger index))block{
    UIActionSheet *actionSheet = [UIActionSheet bk_actionSheetWithTitle:title];
    if (buttonTitles && buttonTitles.count > 0) {
        for (NSString *buttonTitle in buttonTitles) {
            [actionSheet bk_addButtonWithTitle:buttonTitle handler:nil];
        }
    }
    if (destructiveTitle) {
        [actionSheet bk_setDestructiveButtonWithTitle:destructiveTitle handler:nil];
    }
    if (cancelTitle) {
        [actionSheet bk_setCancelButtonWithTitle:cancelTitle handler:nil];
    }
    [actionSheet bk_setDidDismissBlock:block];
    return actionSheet;
}

@end
