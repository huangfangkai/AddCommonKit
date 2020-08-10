//
//  UIViewController+Swizzle.m
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/6.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "UIViewController+Swizzle.h"
//#import "RDVTabBarController.h"

@implementation UIViewController (Swizzle)
- (void)customViewDidAppear:(BOOL)animated{
    if ([NSStringFromClass([self class]) rangeOfString:@"_RootViewController"].location != NSNotFound) {
//        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
        DebugLog(@"setTabBarHidden:NO --- customViewDidAppear : %@", NSStringFromClass([self class]));
    }
    [self customViewDidAppear:animated];
}

- (void)customviewWillAppear:(BOOL)animated{
    if ([[self.navigationController childViewControllers] count] > 1) {
//        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
        DebugLog(@"setTabBarHidden:YES --- customviewWillAppear : %@", NSStringFromClass([self class]));
    }
    [self customviewWillAppear:animated];
}


- (void)custompresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    if (@available(iOS 13.0, *)) {
        // iOS13以后style默认UIModalPresentationAutomatic，以前版本xcode没有这个枚举，所以只能写-2
        if (viewControllerToPresent.modalPresentationStyle == -2 || viewControllerToPresent.modalPresentationStyle == UIModalPresentationPageSheet) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverFullScreen;
        }
    }
    [self custompresentViewController:viewControllerToPresent animated:flag completion:completion];
}

+ (void)load{
    swizzleAllViewController();
}
@end

void swizzleAllViewController()
{
    Swizzle([UIViewController class], @selector(viewDidAppear:), @selector(customViewDidAppear:));
//    Swizzle([UIViewController class], @selector(viewWillDisappear:), @selector(customViewWillDisappear:));
    Swizzle([UIViewController class], @selector(viewWillAppear:), @selector(customviewWillAppear:));
    Swizzle([UIViewController class], @selector(presentViewController: animated: completion:), @selector(custompresentViewController: animated: completion:));

}
