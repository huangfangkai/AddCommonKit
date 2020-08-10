//
//  GuideTipsView.h
//  ihz
//
//  Created by hfk on 2019/12/23.
//  Copyright © 2019 张佳磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, GuideTipsType) {
    GuideTipsTypeGuide = 0,
    GuideTipsTypeUpdate = 1,
    GuideTipsTypeAlert = 2,
    GuideTipsTypeAlertLine = 3
};

@interface GuideTipsView : UIView

@property (nonatomic, copy) void(^btnClickBlock)(NSInteger index);
@property (nonatomic, copy) void(^wordClickBlock)(NSInteger index);

+(instancetype)initWithtType:(GuideTipsType)type withData:(id)data;
-(instancetype)initWithtType:(GuideTipsType)type withData:(id)data;

+(instancetype)initWithtType:(GuideTipsType)type withData:(id)data withBaseViewController:(nonnull UIViewController *)baseVC;
-(instancetype)initWithtType:(GuideTipsType)type withData:(id)data withBaseViewController:(nonnull UIViewController *)baseVC;

- (void)removeViews:(id)sender;


@end

NS_ASSUME_NONNULL_END
