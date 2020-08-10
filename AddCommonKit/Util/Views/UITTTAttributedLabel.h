//
//  UITTTAttributedLabel.h
//  DreamWeaver
//
//  Created by hfk on 2018/6/10.
//  Copyright © 2018年 hfk. All rights reserved.
//

#import "TTTAttributedLabel.h"

typedef void(^UITTTLabelTapBlock)(id aObj);

@interface UITTTAttributedLabel : TTTAttributedLabel

-(void)addLongPressForCopy;
-(void)addLongPressForCopyWithBGColor:(UIColor *)color;
-(void)addTapBlock:(UITTTLabelTapBlock)block;
-(void)addDeleteBlock:(UITTTLabelTapBlock)block;


@end
