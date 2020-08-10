//
//  Helper.m
//  DreamWeaver
//
//  Created by hfk on 2018/7/15.
//  Copyright © 2018年 hfk. All rights reserved.
//

#import "Helper.h"
#import <CoreLocation/CoreLocation.h>
@import AVFoundation;


@implementation Helper

+ (void)checkPhotoLibraryAuthorizationStatusWithBlock:(PhotoAndCameraLibraryBlock)block
{
    [self requestAuthorizationWithCompletion:^(NSInteger status) {
        BOOL success = YES;
        if (status != 3) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
            success = NO;
        }
        if (block) {
            block(success);
        }
    }];
}

+ (void)checkCameraAuthorizationStatusWithBlock:(PhotoAndCameraLibraryBlock)block
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        kTipAlert(@"该设备不支持拍照");
        if (block) {
            block(NO);
        }
        return;
    }
    [self requestAuthorizationWithCompletion:^(NSInteger status) {
        BOOL success = YES;
        if (status != 3) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
            success = NO;
        }
        if (block) {
            block(success);
        }
    }];
}
+ (BOOL)checkLocationAuthorizationStatus{
    if (![CLLocationManager locationServicesEnabled]) {
        kTipAlert(@"请在iPhone的“设置->隐私”中打开定位服务");
        return NO;
    }
    if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        [self showSettingAlertStr:@"请在iPhone的“设置->隐私->定位服务”中打开本应用的访问权限"];
        return NO;
    }
    return YES;
}
+ (void)showSettingAlertStr:(NSString *)tipStr{
    //iOS8+系统下可跳转到‘设置’页面，否则只弹出提示窗即可
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"提示" message:tipStr];
        [alertView bk_setCancelButtonWithTitle:@"取消" handler:nil];
        [alertView bk_addButtonWithTitle:@"设置" handler:nil];
        [alertView bk_setDidDismissBlock:^(UIAlertView *alert, NSInteger index) {
            if (index == 1) {
                UIApplication *app = [UIApplication sharedApplication];
                NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([app canOpenURL:settingsURL]) {
                    [app openURL:settingsURL];
                }
            }
        }];
        [alertView show];
    }else{
        kTipAlert(@"%@", tipStr);
    }
}

+ (void)requestAuthorizationWithCompletion:(void (^)(NSInteger status))completion {
    void (^callCompletionBlock)(NSInteger status) = ^(NSInteger status){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(status);
            }
        });
    };
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            callCompletionBlock(status);
        }];
    });
}


@end
