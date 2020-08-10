//
//  UIWindow+FLEXSetting.m
//  NiuTongSheClient
//
//  Created by hfk on 2019/12/13.
//  Copyright © 2019 XWQ. All rights reserved.
//

#import "UIWindow+FLEXSetting.h"

#if DEBUG
#import "FLEXManager.h"
#endif

@implementation UIWindow (FLEXSetting)
#if DEBUG
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [super motionBegan:motion withEvent:event];
    
    if (motion == UIEventSubtypeMotionShake) {
        [[FLEXManager sharedManager] showExplorer];
        
    }
}
#endif
@end
