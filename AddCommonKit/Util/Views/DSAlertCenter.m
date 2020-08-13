//
//  DSAlertCenter.m
//  wuliu
//
//  Created by Fxxx on 2017/9/11.
//  Copyright © 2017年 zhangjl. All rights reserved.
//

#import "DSAlertCenter.h"

@interface DSAlertCenter ()

/**
 * 背景view
 */
@property (strong ,nonatomic ,readonly) UIControl *backgroundView;

/**
 * 弹层view
 */
@property (strong ,nonatomic ,readonly) UIView *contentView;

/**
 * 图片view
 */
@property (strong ,nonatomic ,readonly) UIImageView *imageView;

/**
 * 文字label
 */
@property (strong ,nonatomic ,readonly) UILabel *label;

/**
 * 绑定的父view
 */
@property (weak ,nonatomic ,readonly) UIView *view;

/**
 * 移除时间 (时间戳)
 */
@property (assign ,nonatomic ,readonly) NSTimeInterval dismissTime;

/**
 * 记录是否自动隐藏
 */
@property (assign ,nonatomic ,readonly) BOOL autoDismiss;

/**
 * 用来自动隐藏弹层
 */
@property (strong ,nonatomic ,readonly) NSTimer *timer;

/**
 * 用来判断布局结束后是否添加弹出的动画效果
 */
@property (assign ,nonatomic ,readonly) BOOL animation;

/**
 * 用来接收父视图的滑动事件
 */
@property (strong ,nonatomic ,readonly) UISwipeGestureRecognizer *swipeGestureRecognizer;

/**
 * 记录拖动手势起始位置
 */
@property (assign ,nonatomic ,readonly) CGFloat touchBegan;

@end

@implementation DSAlertCenter

+ (DSAlertCenter *)alertWithView:(UIView *)view {
    DSAlertCenter *instance = [DSAlertCenter findAlertInView:view];
    if (!instance) {
        instance = [[DSAlertCenter alloc] initWithFrame:view.bounds superview:view];
        instance.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    [instance setup];
    return instance;
}

+ (DSAlertCenter *)findAlertInView:(UIView *)view {
    DSAlertCenter *instance = nil;
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[DSAlertCenter class]]) {
            instance = (DSAlertCenter *)subview; break;
        }
    } return instance;
}

+ (DSAlertCenter *)windowAlert {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    return [DSAlertCenter alertWithView:window];
}

- (id)initWithFrame:(CGRect)frame superview:(UIView *)superview {
    self = [super initWithFrame:frame];
    if (self) {
        _view = superview;
        _swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(superviewSGR:)];
        _swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        [_view addGestureRecognizer:_swipeGestureRecognizer];
        
        _backgroundView = [[UIControl alloc] initWithFrame:self.bounds];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_backgroundView];
        
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
        
        _imageView = [[UIImageView alloc] initWithImage:nil];
        [_contentView addSubview:_imageView];
        
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        [_contentView addSubview:_label];
        
    } return self;
}

// 初始化默认设置
- (void)setup {
    _maxWidth = 0.7;
    _padding = 15.f;
    _centerSpacing = 8.f;
    _images = nil;
    _animationDuration = 0;
    _animationRepeatCount = 0;
    _message = nil;
    _labelFont = [UIFont systemFontOfSize:14];
    _labelTextColor = nil;
    _mode = DSAlertCenterToast;
    _displaySeconds = 3;
    _allowInteraction = YES;
    _shadow = YES;
    _color = [[UIColor whiteColor] colorWithAlphaComponent:.8];
    _maskColor = nil;
}

// 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect image_frame = {} ,label_frame = {} ,content_frame = {};
    switch (_mode) {
        case DSAlertCenterToast:
        {
            CGFloat max_width = _maxWidth;
            if (_maxWidth <= 1) {
                max_width = _view.frame.size.width * _maxWidth;
            }
            max_width = max_width - _padding * 2;
            
            if (_imageView.image) { // 有图片处理
                if (_label.text.length > 0) {
                    image_frame.size = [_imageView sizeThatFits:CGSizeMake(max_width * .3/* 防止图片太大布局错误 */, MAXFLOAT)];
                    label_frame.size = [_label sizeThatFits:CGSizeMake(max_width - _centerSpacing - image_frame.size.width, MAXFLOAT)];
                    content_frame.size = CGSizeMake(image_frame.size.width + _centerSpacing + label_frame.size.width + _padding * 2, MAX(image_frame.size.height, label_frame.size.height) + _padding * 2);
                    
                    image_frame.origin.x = _padding;
                    image_frame.origin.y = (content_frame.size.height - image_frame.size.height) * .5;
                    
                    label_frame.origin.x = CGRectGetMaxX(image_frame) + _centerSpacing;
                    label_frame.origin.y = (content_frame.size.height - label_frame.size.height) * .5;
                } else {
                    image_frame.size = [_imageView sizeThatFits:CGSizeMake(max_width , MAXFLOAT)];
                    content_frame.size = CGSizeMake(image_frame.size.width + _padding * 2, image_frame.size.height + _padding * 2);
                    
                    image_frame.origin.x = _padding;
                    image_frame.origin.y = _padding;
                }
            } else { // 无图片处理
                label_frame.size = [_label sizeThatFits:CGSizeMake(max_width, MAXFLOAT)];
                label_frame.origin.x = _padding;
                label_frame.origin.y = _padding;
                
                content_frame.size.width = label_frame.size.width + _padding * 2;
                content_frame.size.height = label_frame.size.height + _padding * 2;
            }
            
            content_frame.origin.x = (_view.frame.size.width - content_frame.size.width) * .5;
            content_frame.origin.y = _view.frame.size.height - content_frame.size.height - 44.f;
        }
            break;
        case DSAlertCenterMode1:
        case DSAlertCenterMode2:
        {
            CGFloat max_width = _maxWidth;
            if (_maxWidth <= 1) {
                max_width = _view.frame.size.width * _maxWidth;
            }
            max_width = max_width - _padding * 2;
            
            if (_imageView.image) { // 有图片处理
                if (_label.text.length > 0) {
                    if (_mode == DSAlertCenterMode1) {
                        image_frame.size = [_imageView sizeThatFits:CGSizeMake(max_width, MAXFLOAT)];
                        label_frame.size = [_label sizeThatFits:CGSizeMake(max_width, MAXFLOAT)];
                        content_frame.size = CGSizeMake(MAX(image_frame.size.width, label_frame.size.width) + _padding * 2, image_frame.size.height + _centerSpacing + label_frame.size.height + _padding * 2);
                        
                        image_frame.origin.x = (content_frame.size.width - image_frame.size.width) * .5;
                        image_frame.origin.y = _padding;
                        
                        label_frame.origin.x = (content_frame.size.width - label_frame.size.width) * .5;
                        label_frame.origin.y = CGRectGetMaxY(image_frame) + _centerSpacing;
                    } else if (_mode == DSAlertCenterMode2) {
                        image_frame.size = [_imageView sizeThatFits:CGSizeMake(max_width * .3/* 防止图片太大布局错误 */, MAXFLOAT)];
                        label_frame.size = [_label sizeThatFits:CGSizeMake(max_width - _centerSpacing - image_frame.size.width, MAXFLOAT)];
                        content_frame.size = CGSizeMake(image_frame.size.width + _centerSpacing + label_frame.size.width + _padding * 2, MAX(image_frame.size.height, label_frame.size.height) + _padding * 2);
                        
                        image_frame.origin.x = _padding;
                        image_frame.origin.y = (content_frame.size.height - image_frame.size.height) * .5;
                        
                        label_frame.origin.x = CGRectGetMaxX(image_frame) + _centerSpacing;
                        label_frame.origin.y = (content_frame.size.height - label_frame.size.height) * .5;
                    }
                } else {
                    image_frame.size = [_imageView sizeThatFits:CGSizeMake(max_width , MAXFLOAT)];
                    content_frame.size = CGSizeMake(image_frame.size.width + _padding * 2, image_frame.size.height + _padding * 2);
                    
                    image_frame.origin.x = _padding;
                    image_frame.origin.y = _padding;
                }
            } else { // 无图片处理
                label_frame.size = [_label sizeThatFits:CGSizeMake(max_width, MAXFLOAT)];
                label_frame.origin.x = _padding;
                label_frame.origin.y = _padding;
                
                content_frame.size.width = label_frame.size.width + _padding * 2;
                content_frame.size.height = label_frame.size.height + _padding * 2;
            }
            
            content_frame.origin.x = (_view.frame.size.width - content_frame.size.width) * .5;
            content_frame.origin.y = (_view.frame.size.height - content_frame.size.height) * .5;
        }
            break;
        case DSAlertCenterPush:
        {
            CGFloat max_width = _view.frame.size.width;
            max_width = max_width - _padding * 2;
            
            content_frame.origin.x = 0.f;
            content_frame.origin.y = 0.f;
            content_frame.size.width = _view.frame.size.width;
            content_frame.size.height = 64.f;
            
            if (_imageView.image) { // 有图片处理
                if (_label.text.length > 0) {
                    image_frame.size = [_imageView sizeThatFits:CGSizeMake(max_width , 44.f)];
                    image_frame.origin.y = 20.f + (44.f - image_frame.size.height) * .5;
                    image_frame.origin.x = _padding;
                    
                    label_frame.origin.x = CGRectGetMaxX(image_frame) + _centerSpacing;
                    label_frame.origin.y = 20.f;
                    label_frame.size.width = max_width - _centerSpacing - image_frame.size.width;
                    label_frame.size.height = 44.f;
                } else {
                    image_frame.size = [_imageView sizeThatFits:CGSizeMake(max_width , 44.f)];
                    image_frame.origin.y = 20.f + (44.f - image_frame.size.height) * .5;
                    image_frame.origin.x = (content_frame.size.width - image_frame.size.width) * .5;
                }
            } else { // 无图片处理
                label_frame.origin.x = _padding;
                label_frame.origin.y = 20.f;
                label_frame.size.width = max_width;
                label_frame.size.height = 44.f;
            }
        }
            break;
            
        default:
            break;
    }
    
    _imageView.frame = image_frame;
    _label.frame = label_frame;
    _contentView.frame = content_frame;
    
    [self animationForDisplay];
}

// 添加弹出动画
- (void)animationForDisplay {
    if (!_animation) return;
    _animation = NO;
    switch (_mode) {
        case DSAlertCenterToast:
        {
            CGFloat positiony = _contentView.layer.position.y;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            animation.values = @[@(positiony + 44.f),
                                 @(positiony),
                                 @(positiony + 4.f),
                                 @(positiony)];
            animation.duration = .4;
            [_contentView.layer addAnimation:animation forKey:nil];
        }
            break;
        case DSAlertCenterMode1:
        case DSAlertCenterMode2:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(.6),@(1.0),@(0.9),@(1.0)];
            animation.duration = .4;
            animation.keyTimes = @[@(.0),@(.2),@(.4),@(1.f)];
            [_contentView.layer addAnimation:animation forKey:nil];
        }
            break;
        case DSAlertCenterPush:
        {
            CGFloat positiony = _contentView.layer.position.y;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            animation.values = @[@(positiony - _contentView.frame.size.height),
                                 @(positiony),
                                 @(positiony - 4.f),
                                 @(positiony)];
            animation.duration = .4;
            [_contentView.layer addAnimation:animation forKey:nil];
        }
            break;
            
        default:
            break;
    }
}

- (void)show {
    _autoDismiss = (_displaySeconds > 0);
    _animation = YES; // 开启弹出动画处理
    
    self.userInteractionEnabled = !_allowInteraction;
    self.backgroundColor = _maskColor;
    _contentView.backgroundColor = _color;
    
    if (_shadow) {
        _contentView.layer.shadowRadius = 8.f;
        _contentView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _contentView.layer.shadowOffset = CGSizeMake(1, 1);
        _contentView.layer.shadowOpacity = .5;
    } else {
        _contentView.layer.shadowRadius = 0;
        _contentView.layer.shadowColor = nil;
        _contentView.layer.shadowOffset = CGSizeZero;
        _contentView.layer.shadowOpacity = 0;
    }
    
    _label.text = _message;
    _label.font = _labelFont;
    _label.textColor = _labelTextColor;
    
    _imageView.image = _images.firstObject;
    if (_images.count > 1) {
        _imageView.animationImages = _images;
        _imageView.animationDuration = _animationDuration;
        _imageView.animationRepeatCount = _animationRepeatCount;
        [_imageView startAnimating];
    } else {
        _imageView.animationImages = nil;
    }
    
    if (_mode == DSAlertCenterPush) {
        _contentView.layer.cornerRadius = 0;
    } else {
        _contentView.layer.cornerRadius = 5.f;
    }
    
    if ([_view.subviews containsObject:self]) {
        [_view bringSubviewToFront:self];
        [self setNeedsLayout];
    } else {
        [_view addSubview:self];
    }
    
    if (_autoDismiss) {
        _dismissTime = [[NSDate date] timeIntervalSince1970] + _displaySeconds;
        if (_timer == nil) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
        }
        _timer.fireDate = [NSDate dateWithTimeIntervalSince1970:_dismissTime];
    } else {
        if (_timer) {
            [_timer invalidate]; _timer = nil;
        }
    }
}

- (void)dismiss {
    if (_mode == DSAlertCenterPush) {
        CGRect frame = _contentView.frame;
        frame.origin.y = - frame.size.height;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:.2 animations:^{
            weakSelf.contentView.frame = frame;
        } completion:^(BOOL finished) {
            if (weakSelf.timer) {
                [weakSelf.timer invalidate];
                _timer = nil;
            }
            [weakSelf.view removeGestureRecognizer:weakSelf.swipeGestureRecognizer];
            [self removeFromSuperview];
        }];
    } else {
        if (_timer) {
            [_timer invalidate]; _timer = nil;
        }
        [_view removeGestureRecognizer:_swipeGestureRecognizer];
        [self removeFromSuperview];
    }
}

- (void)superviewSGR:(UISwipeGestureRecognizer *)swipe {
    if (_mode == DSAlertCenterPush) {
        [self dismiss];
    }
}

#pragma mark - setter

- (void)setPadding:(CGFloat)padding {
    _padding = padding;
    [self setNeedsLayout];
}

- (void)setCenterSpacing:(CGFloat)centerSpacing {
    _centerSpacing = centerSpacing;
    [self setNeedsLayout];
}

- (void)setMaxWidth:(CGFloat)maxWidth {
    if (_mode == DSAlertCenterPush) return;
    _maxWidth = maxWidth;
    [self setNeedsLayout];
}

+ (void)makeToast:(NSString *)text {
    if([NSString isNotEmpty:text]){
        DSAlertCenter *alert = [DSAlertCenter alertWithView:[UIApplication sharedApplication].delegate.window];
        alert.message = text;
        alert.color = [[UIColor blackColor] colorWithAlphaComponent:.7];
        alert.labelTextColor = [UIColor whiteColor];
        alert.mode = DSAlertCenterToast;
        [alert show];
    }
}
@end

