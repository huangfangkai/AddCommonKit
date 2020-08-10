//
//  UIView+AddCommon.m
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/6.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "UIView+AddCommon.h"
#define kTagBadgeView  1000
#define kTagBadgePointView  1001
#define kTagLineView 1007
#import <objc/runtime.h>


@implementation UIView (AddCommon)

static char BlankPageViewKey;

@dynamic borderColor,borderWidth,cornerRadius, masksToBounds;

-(void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}

- (void)setMasksToBounds:(BOOL)masksToBounds{
    [self.layer setMasksToBounds:masksToBounds];
}

- (void)doCircleFrame{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithHexString:@"#dddddd"].CGColor;
}
- (void)doNotCircleFrame{
    self.layer.cornerRadius = 0.0;
    self.layer.borderWidth = 0.0;
}

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    if (!color) {
        self.layer.borderColor = [UIColor colorWithHexString:@"#dddddd"].CGColor;
    }else{
        self.layer.borderColor = color.CGColor;
    }
}

- (UIViewController *)findViewController{
    
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}

- (CGFloat)maxXOfFrame{
    return CGRectGetMaxX(self.frame);
}

- (void)setSubScrollsToTop:(BOOL)scrollsToTop{
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)obj setScrollsToTop:scrollsToTop];
            *stop = YES;
        }
    }];
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray{
    [self addGradientLayerWithColors:cgColorArray locations:nil startPoint:CGPointMake(0.0, 0.5) endPoint:CGPointMake(1.0, 0.5)];
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
}

+ (CGRect)frameWithOutNav{
    CGRect frame = Main_Screen_Bounds;
    frame.size.height -= (20+44);//减去状态栏、导航栏的高度
    return frame;
}

+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve{
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
            break;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
            break;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
            break;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
            break;
    }
    
    return kNilOptions;
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY{
    return [self lineViewWithPointYY:pointY andColor:[UIColor colorWithHexString:@"#dddddd"]];
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color{
    return [self lineViewWithPointYY:pointY andColor:color andLeftSpace:0];
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, pointY, Main_Screen_Width - leftSpace, 0.5)];
    lineView.backgroundColor = color;
    return lineView;
}

+ (void)outputTreeInView:(UIView *)view withSeparatorCount:(NSInteger)count{
    NSString *outputStr = @"";
    outputStr = [outputStr stringByReplacingCharactersInRange:NSMakeRange(0, count) withString:@"-"];
    outputStr = [outputStr stringByAppendingString:view.description];
    printf("%s\n", outputStr.UTF8String);
    
    if (view.subviews.count == 0) {
        return;
    }else{
        count++;
        for (UIView *subV in view.subviews) {
            [self outputTreeInView:subV withSeparatorCount:count];
        }
    }
}

- (void)outputSubviewTree{
    [UIView outputTreeInView:self withSeparatorCount:0];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown{
    [self addLineUp:hasUp andDown:hasDown andColor:[UIColor colorWithHexString:@"#dddddd"]];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color{
    return [self addLineUp:hasUp andDown:hasDown andColor:color andLeftSpace:0];
}
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointYY:0 andColor:color andLeftSpace:leftSpace];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color andLeftSpace:leftSpace];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
}
- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}

- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (CGSize)doubleSizeOfFrame{
    CGSize size = self.frame.size;
    return CGSizeMake(size.width*2, size.height*2);
}


#pragma mark BlankPageView

- (void)setBlankPageView:(EaseBlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (EaseBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasTips:(NSString *)tips hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    [self configBlankPage:blankPageType hasTips:tips hasData:hasData hasError:hasError offsetY:0 reloadButtonBlock:block];
}

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasTips:(NSString *)tips hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void(^)(id sender))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[EaseBlankPageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];//self.bounds
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer insertSubview:self.blankPageView atIndex:0];
        [self.blankPageContainer bringSubviewToFront:self.blankPageView];
        [self.blankPageView configWithType:blankPageType hasTips:tips hasData:hasData hasError:hasError offsetY:offsetY reloadButtonBlock:block];
    }
}

- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}
@end


@implementation EaseBlankPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configWithType:(EaseBlankPageType)blankPageType hasTips:(NSString *)tips hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void (^)(id))block{
    _curType = blankPageType;
    _clickButtonBlock = block;
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    //    图片
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _showImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_showImageView];
    }
    
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _tipLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    //    按钮
    if (!_actionButton) {//新增按钮
        _actionButton = ({
            UIButton *button = [UIButton new];
            button.backgroundColor =[UIColor colorWithHexString:@"425063"];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 4;
            button.layer.masksToBounds = YES;
            button;
        });
        [self addSubview:_actionButton];
    }
    NSString *imageName, *tipStr;
    NSString *buttonTitle, *buttonTitleColor, *buttonBackColor;
    CGSize buttonSize = CGSizeMake(130, 44);
    CGSize imageSize = CGSizeMake(175, 175);
    CGFloat cornerRadius = 4;
    if (hasError) {
        //加载失败
        _actionButton.hidden = NO;
        tipStr = @"呀，网络出了问题";
        imageName = @"blankpage_image_LoadFail";
        buttonTitle = @"重新连接网络";
    }else{
        _actionButton.hidden = YES;
        if (tips) {
            tipStr = tips;
        }else{
            tipStr = @"暂无数据";
        }
        switch (_curType) {
            case EaseBlankEmptyCarView: {
                imageName = @"image_car_empty";
                imageSize = CGSizeMake(244, 204);
                _actionButton.hidden = NO;
                buttonTitle = @"去逛逛";
                buttonSize = CGSizeMake(Main_Screen_Width - 60, 48);
                buttonTitleColor = @"FFFFFF";
                buttonBackColor = @"00A47D";
                cornerRadius = 24;
            }
                break;
            case EaseBlankOrderHistoryEmpty: {
                imageName = @"image_orderHistory_nodata";
                imageSize = CGSizeMake(213, 206);
            }
                break;
            case EaseBlankMyOrderSubscribeEmpty: {
                imageName = @"image_myOrderSubscribe_nodata";
                imageSize = CGSizeMake(242, 169);
            }
                break;
            case EaseBlankMyOrderSendEmpty: {
                imageName = @"image_myOrderSend_nodata";
                imageSize = CGSizeMake(172, 131);
            }
                break;
            case EaseBlankMyMessageEmpty: {
                imageName = @"image_message_nodata";
                imageSize = CGSizeMake(257, 195);
                _actionButton.hidden = NO;
                buttonTitle = @"回首页";
                buttonSize = CGSizeMake(255, 48);
                buttonTitleColor = @"FFFFFF";
                buttonBackColor = @"00A47D";
                cornerRadius = 24;
            }
                break;
            default:
                break;
        }        
    }
    imageName = imageName ?: @"image_car_empty";
    if (cornerRadius) {
        _actionButton.layer.cornerRadius = cornerRadius;
    }
    if (buttonTitleColor) {
        [_actionButton setTitleColor:[UIColor colorWithHexString:buttonTitleColor] forState:UIControlStateNormal];
    }
    if (buttonBackColor) {
        _actionButton.backgroundColor = [UIColor colorWithHexString:buttonBackColor];
    }
    _showImageView.image = [UIImage imageNamed:imageName];
    _tipLabel.text = tipStr;
    [_actionButton setTitle:buttonTitle forState:UIControlStateNormal];
    _actionButton.hidden = buttonTitle.length <= 0;
    _tipLabel.hidden = tipStr.length <= 0;
    //    布局
    [_showImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_bottom).multipliedBy(0.2);
        make.size.mas_equalTo(imageSize);
    }];
    
    [_tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.showImageView.mas_bottom).offset(60);
        
    }];
    
    [_actionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(buttonSize);
        make.top.equalTo(self.tipLabel.mas_bottom).offset( _tipLabel.hidden ? 0:50);
    }];
}

- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.clickButtonBlock) {
            self.clickButtonBlock(sender);
        }
    });
}

-(void)btnAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.clickButtonBlock) {
            self.clickButtonBlock([NSDictionary dictionary]);
        }
    });
}


@end
