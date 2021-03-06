//
//  UITableView+Common.h
//  DreamWeaver
//
//  Created by hfk on 2018/6/24.
//  Copyright © 2018年 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Common)

- (void)addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpaceAndSectionLine:(CGFloat)leftSpace;
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine;

//- (UITapImageView *)getHeaderViewWithStr:(NSString *)headerStr andBlock:(void(^)(id obj))tapAction;
//- (UITapImageView *)getHeaderViewWithStr:(NSString *)headerStr color:(UIColor *)color andBlock:(void(^)(id obj))tapAction;
//- (UITapImageView *)getHeaderViewWithStr:(NSString *)headerStr color:(UIColor *)color leftNoticeColor:(UIColor*)noticeColor andBlock:(void(^)(id obj))tapAction;


@end
