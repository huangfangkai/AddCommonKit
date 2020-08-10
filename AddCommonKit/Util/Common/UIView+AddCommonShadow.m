//
//  UIView+AddCommonShadow.m
//  111
//
//  Created by hfk on 2020/7/2.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "UIView+AddCommonShadow.h"

@implementation UIView (AddCommonShadow)
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

-(void)AddCommon_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(AddShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth{

    
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = shadowColor.CGColor;
    
    self.layer.shadowOpacity = shadowOpacity;
    
    self.layer.shadowRadius =  shadowRadius;
    
    self.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    
    CGFloat originX = 0;
    
    CGFloat originY = 0;
    
    CGFloat originW = self.bounds.size.width;
    
    CGFloat originH = self.bounds.size.height;
    
    
    switch (shadowPathSide) {
        case AddShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case AddShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
            
        case AddShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
            
        case AddShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case AddShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case AddShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
       
          }
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    
    self.layer.shadowPath = path.CGPath;
    
}
@end
