//
//  CodeGeneratorView.h
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/23.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CodeGeneratorView : UIView

@property (nonatomic, strong) NSString *changeString;
@property (nonatomic, strong) UILabel *codeLabel;

-(void)changeCode;


@end

NS_ASSUME_NONNULL_END
