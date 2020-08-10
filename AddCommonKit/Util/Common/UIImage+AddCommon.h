//
//  UIImage+AddCommon.h
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/7.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (AddCommon)

/**
 颜色换成图片
 */
+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
//对图片尺寸进行压缩--
-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;

//对图片尺寸进行缩放
-(UIImage*)scaledToMaxSize:(CGSize )size;

//获取资源图片的高清图
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
//获取资源图片的全屏图
+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset;
//获取资源类型从而返回类型图片
+ (UIImage *)imageWithFileType:(NSString *)fileType;

//对图片压缩到固定大小
- (NSData *)dataSmallerThan:(NSUInteger)dataLength;
- (NSData *)dataForCodingUpload;


@end

NS_ASSUME_NONNULL_END
