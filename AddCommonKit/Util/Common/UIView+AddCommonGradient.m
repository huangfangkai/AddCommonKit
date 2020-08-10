//
//  UIView+AddCommonGradient.m
//  FirstaAPP
//
//  Created by hfk on 2020/7/1.
//  Copyright © 2020 葛泽宁. All rights reserved.
//

#import "UIView+AddCommonGradient.h"

@implementation UIView (AddCommonGradient)

+ (Class)layerClass {
    return [CAGradientLayer class];
}

+ (UIView *)ac_gradientViewWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    UIView *view = [[self alloc] init];
    [view ac_setGradientBackgroundWithColors:colors locations:locations startPoint:startPoint endPoint:endPoint];
    return view;
}

- (void)ac_setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    NSMutableArray *colorsM = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    self.ac_colors = [colorsM copy];
    self.ac_locations = locations;
    self.ac_startPoint = startPoint;
    self.ac_endPoint = endPoint;
}

#pragma mark- Getter&Setter

- (NSArray *)ac_colors {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAc_colors:(NSArray *)colors {
    objc_setAssociatedObject(self, @selector(ac_colors), colors, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setColors:self.ac_colors];
    }
}

- (NSArray<NSNumber *> *)ac_locations {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAc_locations:(NSArray<NSNumber *> *)locations {
    objc_setAssociatedObject(self, @selector(ac_locations), locations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setLocations:self.ac_locations];
    }
}

- (CGPoint)ac_startPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setAc_startPoint:(CGPoint)startPoint {
    objc_setAssociatedObject(self, @selector(ac_startPoint), [NSValue valueWithCGPoint:startPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setStartPoint:self.ac_startPoint];
    }
}

- (CGPoint)ac_endPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setAc_endPoint:(CGPoint)endPoint {
    objc_setAssociatedObject(self, @selector(ac_endPoint), [NSValue valueWithCGPoint:endPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setEndPoint:self.ac_endPoint];
    }
}


@end

@implementation UILabel (AddCommonGradient)

+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end

