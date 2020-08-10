//
//  UIView+AddCommonShadow.h
//  111
//
//  Created by hfk on 2020/7/2.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum :NSInteger{
    
    AddShadowPathLeft,
    
    AddShadowPathRight,
    
    AddShadowPathTop,

    AddShadowPathBottom,

    AddShadowPathNoTop,
    
    AddShadowPathAllSide

} AddShadowPathSide;

@interface UIView (AddCommonShadow)

/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，

 */

-(void)AddCommon_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(AddShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;

@end

NS_ASSUME_NONNULL_END
