//
//  AddCommonHead.h
//  111
//
//  Created by hfk on 2020/6/24.
//  Copyright © 2020 hfk. All rights reserved.
//

#ifndef AddCommonHead_h
#define AddCommonHead_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVAsset.h>
#import "NSString+AddCommon.h"
#import "UIColor+AddCommon.h"
#import "NSString+AddHash.h"
#import "UIButton+AddCommon.h"
#import "UILabel+AddCommon.h"
#import "UILabel+AddCopy.h"
#import "UITextField+AddCommon.h"
#import "ObjcRuntime.h"
#import <objc/runtime.h>
#import "UIView+AddCommonGradient.h"
#import "UIView+AddCommonShadow.h"
#import "NSObject+AddCommon.h"
#import "UIView+AddCommon.h"
#import "UIImage+AddCommon.h"
#import "PHAsset+AddCommon.h"
#import "UITableView+Common.h"
#import "NSDictionary+AddCommon.h"
#import "NSData+AddCommon.h"
#import "NSDictionary+AddAppSign.h"



#import "NetAPIClient.h"
#import "NSObject+NetHostSet.h"
#import "HostApiKeyManager.h"
#import "UserData.h"

#import "Helper.h"
#import "UITTTAttributedLabel.h"
#import "UIPlaceHolderTextView.h"
#import "HClActionSheet.h"
#import "GuideTipsView.h"
#import <Masonry.h>
#import <BlocksKit/BlocksKit+UIKit.h>


#ifdef DEBUG
#import "FLEXManager.h"
#endif



#define Main_Screen_Bounds      [UIScreen mainScreen].bounds
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width


//是否是IPhoneX
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)||CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)||CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size)) : NO)


//获取导航栏高度
#define kNavBarHeight      (iPhoneX ? 88.0:64.0)
//状态栏高度
#define kStatusBarHeight   (iPhoneX?(44):(20))
// 底部安全区域远离高度
#define kBottomSafeHeight  (iPhoneX ? 34: 0)
// TabBar高度
#define kTabBarHeight      (iPhoneX ? (49 + 34):(49))
// iPhoneX的状态栏高度差值
#define kTopBarDifHeight   (iPhoneX ? (24):(0))


#define kKeyWindow [[[UIApplication sharedApplication] windows] objectAtIndex:0]


#define kLinkAttributes     @{(__bridge NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[UIColor colorWithHexString:@"2471ff"].CGColor}
#define kLinkAttributesActive       @{(NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[UIColor colorWithHexString:@"2471ff"].CGColor}



#ifdef DEBUG
#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DebugLog(s, ...)
#endif



#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]


#endif /* AddCommonHead_h */
