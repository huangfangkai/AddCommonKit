//
//  Helper.h
//  DreamWeaver
//
//  Created by hfk on 2018/7/15.
//  Copyright © 2018年 hfk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PhotoAndCameraLibraryBlock)(BOOL success);

@interface Helper : NSObject

/**
 * 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (void)checkPhotoLibraryAuthorizationStatusWithBlock:(PhotoAndCameraLibraryBlock)block;

/**
 * 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (void)checkCameraAuthorizationStatusWithBlock:(PhotoAndCameraLibraryBlock)block;;

/**
 * 检查系统"定位"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkLocationAuthorizationStatus;

@end
