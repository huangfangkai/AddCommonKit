//
//  NSObject+AddCommon.m
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/6.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "NSObject+AddCommon.h"
#define kHUDQueryViewTag 101

@implementation NSObject (AddCommon)

#pragma mark NetError

//显示请求错误处理
-(id)handleResponse:(id)responseJSON apath:(NSString *)apath{
    return [self handleResponse:responseJSON apath:apath autoShowError:YES autoShowSuccessMessage:NO];
}
-(id)handleResponse:(id)responseJSON apath:(NSString *)apath autoShowError:(BOOL)autoShowError autoShowSuccessMessage:(BOOL)autoShowSuccessMessage{
    NSError *error = nil;
    NSInteger errorCode = [(NSNumber *)[responseJSON valueForKeyPath:@"code"] integerValue];
    if (errorCode != 200) {
        error = [NSError errorWithDomain:[NSObject baseURLStr] code:errorCode userInfo:responseJSON];
        //错误提示
        if (autoShowError) {
            [NSObject showError:error];
        }
        if (errorCode == 1001 && [UserData sharedManager].token) {
            [UserData clearUserInfo];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [[AppDelegate shareAppDelegate] setupSelectRoleViewController];
            });
        }
    }else{
        if (autoShowSuccessMessage) {
            NSError *message = [NSError errorWithDomain:[NSObject baseURLStr] code:errorCode userInfo:responseJSON];
            [NSObject showError:message];
        }
    }
    return error;
}

#pragma mark Tip M
+ (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if ([error.userInfo objectForKey:@"message"]) {
            [tipStr appendString:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"message"]]];
        }else{
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            }else{
                [tipStr appendFormat:@"ErrorCode%ld", (long)error.code];
            }
        }
        return tipStr;
    }
    return nil;
}

+ (BOOL)showError:(NSError *)error{
    NSString *tipStr = [NSObject tipFromError:error];
    [NSObject showHudTipStr:tipStr];
    return YES;
}
+ (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr&&tipStr.length>0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabel.text = tipStr;
        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:2.0];
    }
}
+ (instancetype)showHUDQueryStr:(NSString *)titleStr{
    titleStr = titleStr.length > 0? titleStr: @"正在获取数据...";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.tag = kHUDQueryViewTag;
    hud.label.text = titleStr;
    hud.label.font = [UIFont boldSystemFontOfSize:15.0];
    hud.margin = 10.f;
    return hud;
}
+ (NSUInteger)hideHUDQuery{
    __block NSUInteger count = 0;
    NSArray *huds = [MBProgressHUD allHUDsForView:kKeyWindow];
    [huds enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if (obj.tag == kHUDQueryViewTag) {
            [obj removeFromSuperview];
            count++;
        }
    }];
    return count;
}

/**
 *  延迟执行
 *
 *  @param block 执行的block
 *  @param delay 延迟的时间：秒
 */
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
@end
