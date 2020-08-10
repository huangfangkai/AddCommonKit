//
//  PHAsset+AddCommon.h
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/7.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHAsset (AddCommon)

+ (PHAsset *)assetWithLocalIdentifier:(NSString *)localIdentifier;
+ (UIImage *)loadImageWithLocalIdentifier:(NSString *)localIdentifier;

- (UIImage *)loadThumbnailImage;
- (UIImage *)loadImage;
- (NSData *)loadImageData;
- (NSString *)fileName;

- (void)loadImageWithProgressHandler:(PHAssetImageProgressHandler)progressHandler resultHandler:(void (^)(UIImage *result, NSDictionary *info))resultHandler;



@end

NS_ASSUME_NONNULL_END
