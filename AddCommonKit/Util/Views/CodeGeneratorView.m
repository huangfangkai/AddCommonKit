//
//  CodeGeneratorView.m
//  WisdomRestaurant
//
//  Created by hfk on 2020/7/23.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "CodeGeneratorView.h"

@implementation CodeGeneratorView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //        self.layer.cornerRadius = 5.0;
        //        self.layer.masksToBounds = YES;
        float red = arc4random() % 100 / 100.0;
        float green = arc4random() % 100 / 100.0;
        float blue = arc4random() % 100 / 100.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.2];
        self.backgroundColor = color;
        self.userInteractionEnabled = YES;
        [self change];
        [self bk_whenTapped:^{
            [self changeCode];
        }];
    }
    return self;
}
-(void)changeCode{
    [self change];
    [self setNeedsDisplay];
}
- (void)change
{
    self.changeString = [NSString randomStringWithLength:4];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.5];
    [self setBackgroundColor:color];
    
    NSString *text = [NSString stringWithFormat:@"%@",self.changeString];
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}];
    int width = ceil(rect.size.width / text.length - cSize.width);
    int height = ceil(rect.size.height - cSize.height);
    CGPoint point;
    
    float pX, pY;
    for (int i = 0; i < text.length; i++)
    {
        pX = arc4random() % width + rect.size.width / text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        UIColor *color = [UIColor colorWithRed:(arc4random()%256)/256.f
                                         green:(arc4random()%256)/256.f
                                          blue:(arc4random()%256)/256.f
                                         alpha:1.0f];
        [textC drawAtPoint:point withAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName: [UIFont systemFontOfSize:20]}];
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    for(int cout = 0; cout < 10; cout++)
    {
        red = arc4random() % 100 / 100.0;
        green = arc4random() % 100 / 100.0;
        blue = arc4random() % 100 / 100.0;
        color = [UIColor colorWithRed:red green:green blue:blue alpha:0.2];
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
