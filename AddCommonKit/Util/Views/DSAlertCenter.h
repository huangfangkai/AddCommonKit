//
//  DSAlertCenter.h
//  wuliu
//
//  Created by Fxxx on 2017/9/11.
//  Copyright © 2017年 zhangjl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /** 经典底部 toast */
    DSAlertCenterToast,
    
    /** 仿QQ 顶部推送提示栏 */
    DSAlertCenterPush,
    
    /** 屏幕中心提示框 */
    DSAlertCenterMode1, // 图片在文字上边
    DSAlertCenterMode2, // 图片在文字左边
    /** ----------- */
} DSAlertMode;

@interface DSAlertCenter : UIView

/**
 * 在指定view上创建一个弹层
 */
+ (DSAlertCenter *)alertWithView:(UIView *)view;


/**
 * 弹层模式 默认: DSAlertCenterToast
 */
@property (assign ,nonatomic) DSAlertMode mode;


/**
 * 提示文本
 */
@property (strong ,nonatomic) NSString *message;


/**
 * 文本字体 默认: [UIFont systemFontOfSize:14]
 */
@property (strong ,nonatomic) UIFont *labelFont;


/**
 * 文本字体颜色 默认: nil
 */
@property (strong ,nonatomic) UIColor *labelTextColor;


/**
 * 显示时长 单位: 秒  默认: 3 (0为不自动移除)
 */
@property (assign ,nonatomic) NSTimeInterval displaySeconds;


/**
 * 设置图片 ,可一张或一组帧图
 */
@property (strong ,nonatomic) NSArray <UIImage *>*images;
@property (assign ,nonatomic) NSTimeInterval animationDuration; // 帧动画时间 (images为组图时生效)
@property (assign ,nonatomic) NSInteger animationRepeatCount; // 帧动画播放次数 (images为组图时生效)


/**
 * 阴影效果 默认: YES
 */
@property (assign ,nonatomic) BOOL shadow;


/**
 * 设置弹层背景色 默认: [[UIColor whiteColor] colorWithAlphaComponent:.8]
 */
@property (strong ,nonatomic) UIColor *color;



/**
 * 设置遮挡层背景色 默认: nil
 */
@property (strong ,nonatomic) UIColor *maskColor;



/**
 * 弹层存在期间是否允许用户交互 默认: YES
 */
@property (assign ,nonatomic) BOOL allowInteraction;


/**
 * 设置弹层最大宽度 (DSAlertCenterPush模式无效 ,宽度固定为绑定父view宽度不可修改)
 * 可设置具体宽度，也可以设置相对于父视图宽比(取值范围 0-1). 默认: 0.7,即父视图宽的70%
 */
@property (assign ,nonatomic) CGFloat maxWidth;


/**
 * 内边距 默认: 15.f
 */
@property (assign ,nonatomic) CGFloat padding;


/**
 * 图片与label间距 默认: 8.f;
 */
@property (assign ,nonatomic) CGFloat centerSpacing;


/**
 * 移除弹层
 */
- (void)dismiss;


/**
 * 弹出到绑定view
 */
- (void)show;


+ (void)makeToast:(NSString *)text;


@end

