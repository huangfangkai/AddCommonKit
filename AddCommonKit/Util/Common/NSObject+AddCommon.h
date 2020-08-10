//
//  NSObject+AddCommon.h
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/6.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AddCommon)


#pragma mark NetError
-(id)handleResponse:(id)responseJSON apath:(NSString *)apath;
-(id)handleResponse:(id)responseJSON apath:(NSString *)apath autoShowError:(BOOL)autoShowError autoShowSuccessMessage:(BOOL)autoShowSuccessMessage;

#pragma mark Tip M
//处理错误信息
+ (NSString *)tipFromError:(NSError *)error;
//中央显示错误信息提示
+ (BOOL)showError:(NSError *)error;
//中央显示提示只有文字
+ (void)showHudTipStr:(NSString *)tipStr;
//中央显示提示文字和加载图
+ (instancetype)showHUDQueryStr:(NSString *)titleStr;
//提示隐藏
+ (NSUInteger)hideHUDQuery;


/**
 *  延迟执行
 *
 *  @param block 执行的block
 *  @param delay 延迟的时间：秒
 */
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
