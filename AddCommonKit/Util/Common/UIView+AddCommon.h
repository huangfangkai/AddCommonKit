//
//  UIView+AddCommon.h
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/6.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@class EaseBlankPageView;

typedef NS_ENUM(NSInteger, EaseBlankPageType){
    EaseBlankCommonEmpty = 0,
    EaseBlankEmptyCarView = 1,
    EaseBlankOrderHistoryEmpty = 2,
    EaseBlankMyOrderSubscribeEmpty = 3,
    EaseBlankMyOrderSendEmpty = 4,
    EaseBlankMyMessageEmpty = 5,

};

@interface UIView (AddCommon)

@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable BOOL masksToBounds;

- (void)doCircleFrame;
- (void)doNotCircleFrame;
- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

- (UIViewController *)findViewController;


- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setOrigin:(CGPoint)origin;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;
- (CGFloat)maxXOfFrame;

- (void)setSubScrollsToTop:(BOOL)scrollsToTop;


- (void)addGradientLayerWithColors:(NSArray *)cgColorArray;
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )aPoint endPoint:(CGPoint)endPoint;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;

- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

- (void)removeViewWithTag:(NSInteger)tag;
- (CGSize)doubleSizeOfFrame;
- (void)outputSubviewTree;//输出子视图的目录树

+ (CGRect)frameWithOutNav;
+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;
+ (void)outputTreeInView:(UIView *)view withSeparatorCount:(NSInteger)count;//输出某个View的subview目录


#pragma mark BlankPageView
@property (strong, nonatomic) EaseBlankPageView *blankPageView;
- (void)configBlankPage:(EaseBlankPageType)blankPageType hasTips:(NSString *)tips hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
- (void)configBlankPage:(EaseBlankPageType)blankPageType hasTips:(NSString *)tips hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void(^)(id sender))block;


@end

@interface EaseBlankPageView : UIView

@property (strong, nonatomic) UIImageView *showImageView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *actionButton;
@property (assign, nonatomic) EaseBlankPageType curType;
@property (copy, nonatomic) void(^clickButtonBlock)(id sender);
- (void)configWithType:(EaseBlankPageType)blankPageType hasTips:(NSString *)tips hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void(^)(id sender))block;


@end





NS_ASSUME_NONNULL_END
