//
//  GuideTipsView.m
//  ihz
//
//  Created by hfk on 2019/12/23.
//  Copyright © 2019 张佳磊. All rights reserved.
//

#import "GuideTipsView.h"

@interface GuideTipsView ()<TTTAttributedLabelDelegate>

@property (nonatomic,assign)  GuideTipsType curType;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSDictionary *dict_UpdateInfo;//更新信息
@property (nonatomic, strong) UIViewController *vc_base;//根视图
@property (nonatomic, strong) NSDictionary *dict_AlertInfo;//警告框信息


@end

@implementation GuideTipsView
+(instancetype)initWithtType:(GuideTipsType)type withData:(id)data{
    GuideTipsView *view = [[self alloc] initWithtType:type withData:data];
    return view;
}
-(instancetype)initWithtType:(GuideTipsType)type withData:(id)data{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.curType = type;
        self.data = data;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [kKeyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(kKeyWindow);
        }];
        [self createView];
    }
    return self;
}
+(instancetype)initWithtType:(GuideTipsType)type withData:(id)data withBaseViewController:(nonnull UIViewController *)baseVC{
    GuideTipsView *view = [[self alloc] initWithtType:type withData:data withBaseViewController:baseVC];
    return view;
}
-(instancetype)initWithtType:(GuideTipsType)type withData:(id)data withBaseViewController:(nonnull UIViewController *)baseVC{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.curType = type;
        self.data = data;
        self.vc_base = baseVC;
//        UIViewController *vc = [NSObject getCurrentVC];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [baseVC.view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(baseVC.view);
        }];
        [self createView];
    }
    return self;
}
-(void)createView{
    if (self.curType == GuideTipsTypeGuide) {
        [self createHomeGuideView];
    }else if (self.curType == GuideTipsTypeUpdate){
        [self createHomeUpdateView];
    }else if (self.curType == GuideTipsTypeAlert || self.curType == GuideTipsTypeAlertLine){
        [self createAlertView];
    }
}
//MARK:创建主页面新手引导
-(void)createHomeGuideView{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];

    UIView *top = [UIView new];
    top.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8];
    [self addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(20.f + kTopBarDifHeight));
    }];
    
    __block NSInteger count = 0;
    UIImageView *imv_Guide = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"l_main_mask_10"]];
    imv_Guide.userInteractionEnabled = YES;
    [self addSubview:imv_Guide];
    
    if(kBottomSafeHeight > 0){
        imv_Guide.image = [UIImage imageNamed:@"l_main_mask_12"];
        [imv_Guide mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(20.f +kTopBarDifHeight, -3, -2, -3));
        }];
    }else{
        [imv_Guide mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(20.f +kTopBarDifHeight, -3, kBottomSafeHeight-2, -3));
        }];
    }
    [imv_Guide bk_whenTapped:^{
        if (count == 0) {
            imv_Guide.image = [UIImage imageNamed:kBottomSafeHeight > 0 ? @"l_main_mask_14":@"l_main_mask_13"];
        }else{
            [self removeViews:@""];
        }
        count += 1;
    }];
}
//MARK:创建主页面更新页面
-(void)createHomeUpdateView{
    self.dict_UpdateInfo = self.data;
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(265, 316));
    }];
    
    UIImageView *versonUp = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"version_up_bg"]];
    [bgView addSubview:versonUp];
    [versonUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    
    UILabel *titlelab = [UILabel createLable:CGRectZero text:@"更新内容:" font:[UIFont systemFontOfSize:16.0f] textColor:[UIColor colorWithHexString:@"222222"] textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:titlelab];
    [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(82);
        make.left.equalTo(bgView).offset(32);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    UITextView *contentTxv = [[UITextView alloc]init];
    contentTxv.textColor = [UIColor colorWithHexString:@"222222"];
    contentTxv.font = [UIFont systemFontOfSize:16.0f];
    contentTxv.textAlignment = NSTextAlignmentLeft;
    contentTxv.text = [NSString stringIsExist:self.dict_UpdateInfo[@"info"]];
    contentTxv.editable = NO;
    [bgView addSubview:contentTxv];
    [contentTxv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titlelab.mas_bottom).offset(8);
        make.left.equalTo(bgView).offset(30);
        make.right.equalTo(bgView).offset(-30);
        make.bottom.lessThanOrEqualTo(bgView).offset(-75);
    }];
    
    
    UIButton *VersionUpBtn = [UIButton createButton:CGRectZero action:@selector(goToVersionUp:) delegate:self title:@"立即升级" font:[UIFont systemFontOfSize:16.0f] titleColor:[UIColor whiteColor]];
    [bgView addSubview:VersionUpBtn];
    [VersionUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView).offset(-15);
        make.centerX.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(140, 32));
    }];
    
    if ([self.dict_UpdateInfo[@"isForce"] integerValue] != 1) {
        UIButton *closeBtn = [UIButton createButton:CGRectZero action:@selector(removeViews:) delegate:self normalImage:[UIImage imageNamed:@"version_up_close_icon"] highlightedImage:[UIImage imageNamed:@"version_up_close_icon"]];
        [self addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_bottom).equalTo(@30);
            make.centerX.equalTo(bgView);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        [self bk_whenTapped:^{
            [self removeViews:@""];
        }];
    }
        
}
//MARK:创建Alert样式
-(void)createAlertView{
    self.dict_AlertInfo = self.data;
    
    if (self.dict_AlertInfo[@"backColor"]) {
        self.backgroundColor = self.dict_AlertInfo[@"backColor"];
    }
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    bgView.layer.shadowColor = [UIColor colorWithHexString:@"999999"].CGColor;
    bgView.layer.shadowOffset = CGSizeZero;
    bgView.layer.shadowOpacity = 0.8;
    bgView.clipsToBounds = NO;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.equalTo(@295);
    }];
    //标题
    UILabel *lab_title = [UILabel createLable:CGRectZero text:[NSString stringIsExist:self.dict_AlertInfo[@"title"]] font:self.dict_AlertInfo[@"titleFont"] ? self.dict_AlertInfo[@"titleFont"]:(self.curType == GuideTipsTypeAlert ? [UIFont fontWithName:@"Helvetica-Bold" size:21.0f]:[UIFont systemFontOfSize:22.0f]) textColor:self.dict_AlertInfo[@"titleColor"] ? self.dict_AlertInfo[@"titleColor"]:[UIColor colorWithHexString:@"333333"] textAlignment:NSTextAlignmentCenter];
    [lab_title sizeToFit];
    [bgView addSubview:lab_title];
    [lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(25);
        make.centerX.equalTo(bgView);
        make.width.mas_lessThanOrEqualTo(247);
        make.height.equalTo(@0);
    }];
    
    //标题线
    UIView *lineleft = [[UIView alloc]init];
    lineleft.backgroundColor = [UIColor colorWithHexString:@"E4E8F1"];
    [bgView addSubview:lineleft];
    [lineleft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(24);
        make.centerY.equalTo(lab_title);
        make.right.equalTo(lab_title.mas_left).offset(-15);
        make.height.equalTo(@1);
    }];
    
    UIView *lineright = [[UIView alloc]init];
    lineright.backgroundColor = [UIColor colorWithHexString:@"E4E8F1"];
    [bgView addSubview:lineright];
    [lineright mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-24);
        make.centerY.equalTo(lab_title);
        make.left.equalTo(lab_title.mas_right).offset(15);
        make.height.equalTo(@1);
    }];
    
    if (self.curType != GuideTipsTypeAlertLine) {
        lineleft.hidden = YES;
        lineright.hidden = YES;
    }
    
    //内容
    UITTTAttributedLabel *lab_content = [[UITTTAttributedLabel alloc] init];
    lab_content.textAlignment = self.dict_AlertInfo[@"contentAlignment"] ? [self.dict_AlertInfo[@"contentAlignment"] integerValue]:NSTextAlignmentLeft;
    lab_content.font = self.dict_AlertInfo[@"contentFont"] ? self.dict_AlertInfo[@"contentFont"]:[UIFont systemFontOfSize:15.0f];
    lab_content.textColor = self.dict_AlertInfo[@"contentColor"] ? self.dict_AlertInfo[@"contentColor"]:(self.curType == GuideTipsTypeAlert ? [UIColor colorWithHexString:@"333333"]:[UIColor colorWithHexString:@"666666"]);
    lab_content.numberOfLines = 0;
    lab_content.lineBreakMode =  NSLineBreakByClipping;
//    NSLineBreakByWordWrapping = 0,         // Wrap at word boundaries, default
//    NSLineBreakByCharWrapping,        // Wrap at character boundaries
//    NSLineBreakByClipping,        // Simply clip
//    NSLineBreakByTruncatingHead,    // Truncate at head of line: "...wxyz"
//    NSLineBreakByTruncatingTail,    // Truncate at tail of line: "abcd..."
//    NSLineBreakByTruncatingMiddle    // Truncate middle of line:  "ab...yz"

    lab_content.linkAttributes = kLinkAttributes;
    lab_content.activeLinkAttributes = kLinkAttributesActive;
    lab_content.delegate = self;
    lab_content.text = [NSString stringIsExist:self.dict_AlertInfo[@"content"]];
    [bgView addSubview:lab_content];
    [lab_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab_title.mas_bottom).offset(11);
        make.left.equalTo(bgView).offset(24);
        make.right.equalTo(bgView).offset(-24);
        make.left.equalTo(bgView).offset(24);
        make.height.equalTo(@0);
    }];
    
    CGFloat titleHeight = [(lab_title.text.length > 0 ? @"标题":@"") getHeightWithFont:lab_title.font constrainedToSize:CGSizeMake(100, MAXFLOAT)];
    [lab_title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(titleHeight);
    }];
    if (titleHeight == 0) {
        [lab_content mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lab_title.mas_bottom);
        }];
        lineleft.hidden = YES;
        lineright.hidden = YES;
    }
    NSString *content = [NSString stringIsExist:self.dict_AlertInfo[@"content"]];
    CGFloat contentHeight = [lab_content.text getHeightWithFont:lab_content.font constrainedToSize:CGSizeMake(247, MAXFLOAT)];
    CGFloat oneHeight = [@"内容" getHeightWithFont:lab_content.font constrainedToSize:CGSizeMake(247, MAXFLOAT)];
    if (contentHeight - oneHeight < 1 && contentHeight - oneHeight >= 0) {
        lab_content.textAlignment = NSTextAlignmentCenter;
    }
    [lab_content mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentHeight);
    }];
    
    if (self.dict_AlertInfo[@"contentAim"] && [self.dict_AlertInfo[@"contentAim"] isKindOfClass:[NSArray class]] && content.length > 0) {
        for (NSInteger i = 0; i < [self.dict_AlertInfo[@"contentAim"] count]; i++) {
            [lab_content addLinkToTransitInformation:@{@"index" : [NSString stringWithFormat:@"%ld",i]} withRange:[content rangeOfString:self.dict_AlertInfo[@"contentAim"][i]]];
        }
    }
    
    UIView *longView = [[UIView alloc]init];
    longView.backgroundColor = [UIColor colorWithHexString:@"E4E8F1"];
    [bgView addSubview:longView];
    [longView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab_content.mas_bottom).offset(19);
        make.left.right.equalTo(bgView);
        make.height.equalTo(@1);
    }];
    
    if (self.dict_AlertInfo[@"btns"] && [self.dict_AlertInfo[@"btns"] isKindOfClass:[NSArray class]] && [self.dict_AlertInfo[@"btns"] count] > 0) {
        NSInteger count = [self.dict_AlertInfo[@"btns"] count];
        CGFloat width = 295/count;
        for (NSInteger i = 0; i < count; i++) {
            NSDictionary *dict = self.dict_AlertInfo[@"btns"][i];
            UIColor *color = dict[@"color"] ? dict[@"color"]:[UIColor colorWithHexString:@"F85906"];
            UIButton *btn = [UIButton createButton:CGRectZero action:@selector(btnsClick:) delegate:self title:dict[@"title"] font:[UIFont systemFontOfSize:15.0f] titleColor:color];
            btn.tag = i + 1024;
            [bgView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(longView.mas_bottom);
                make.left.equalTo(bgView).offset(width * i);
                make.size.mas_equalTo(CGSizeMake(width, 50));
            }];
            if (i != count - 1) {
                UIView *midView = [[UIView alloc]init];
                midView.backgroundColor = [UIColor colorWithHexString:@"E4E8F1"];
                [bgView addSubview:midView];
                [midView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(longView.mas_bottom);
                    make.left.equalTo(bgView).offset(width * (i + 1));
                    make.size.mas_equalTo(CGSizeMake(1, 50));
                }];
            }
        }
    }
    
    [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(longView.mas_bottom).offset(50);
    }];
    
}
//MARK: TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components{
    if (self.wordClickBlock && components[@"index"]) {
        self.wordClickBlock([components[@"index"] integerValue]);
    }
}
//MARK:Action
//MARK:前往版本更新
-(void)goToVersionUp:(id)sender{
    [[UIApplication sharedApplication] openURL: [ NSURL URLWithString:[self.dict_UpdateInfo[@"appaddress"] description]]];
}
-(void)btnsClick:(UIButton *)btn{
    if (self.btnClickBlock) {
        self.btnClickBlock(btn.tag - 1024);
    }
    [self removeViews:[NSString stringWithFormat:@"%ld",btn.tag - 1024]];
}

-(void)removeViews:(id)sender{
    self.alpha = 0;
    if (self.dict_AlertInfo[@"afterMis"] && [self.dict_AlertInfo[@"afterMis"] isKindOfClass:[NSArray class]] && [sender isKindOfClass:[NSString class]] && [self.dict_AlertInfo[@"afterMis"] containsObject:sender]) {
        if (self.vc_base) {
            self.vc_base.view.userInteractionEnabled = NO;
            [NSObject performBlock:^{
                self.vc_base.view.userInteractionEnabled = YES;
            } afterDelay:0.5];
        }
    }
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
