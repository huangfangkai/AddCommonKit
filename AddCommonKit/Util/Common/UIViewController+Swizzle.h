//
//  UIViewController+Swizzle.h
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/6.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Swizzle)

@end

void swizzleAllViewController(void);

NS_ASSUME_NONNULL_END
