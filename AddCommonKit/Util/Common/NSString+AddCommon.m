//
//  NSString+AddCommon.m
//  111
//
//  Created by hfk on 2020/6/24.
//  Copyright © 2020 hfk. All rights reserved.
//

#import "NSString+AddCommon.h"

@implementation NSString (AddCommon)

+ (NSString*)transformToJson:(id)obj
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}
+ (id)transformToObj:(NSString*)json
{
    if ([NSString isNotEmpty:json]) {
        NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSError* error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        return jsonObject;
    }
    return nil;
}
+ (BOOL)isNotEmpty:(NSString *)str
{
    NSString *string = [NSString stringWithFormat:@"%@",str];
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (string == nil) {
        return NO;
    }
    if ([string isEqualToString:@""]) {
        return NO;
    }
    if ([string isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([string isEqualToString:@"<null>"]) {
        return NO;
    }
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length == 0) {
        return NO;
    }
    return YES;
}

+ (NSString *)stringIsExist:(NSString *)string
{
    if ([NSString isNotEmpty:string]) {
        return [NSString stringWithFormat:@"%@",string];
    }
    return @"";
}


- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self getSizeWithSpeace:0 withFont:font constrainedToSize:size];
}

- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}

- (CGSize)getSizeWithSpeace:(CGFloat)lineSpeace withFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    if (lineSpeace > 0) {
        style.lineSpacing = lineSpeace;
    }
    resultSize = [self boundingRectWithSize:CGSizeMake(floor(size.width), floor(size.height))//用相对小的 width 去计算 height / 小 heigth 算 width
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font,
                                              NSParagraphStyleAttributeName: style}
                                    context:nil].size;
    resultSize = CGSizeMake(floor(resultSize.width + 1), floor(resultSize.height + 1));//上面用的小 width（height） 来计算了，这里要 +1
    return resultSize;
}
- (CGFloat)getHeightWithSpeace:(CGFloat)lineSpeace withFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self getSizeWithSpeace:lineSpeace withFont:font constrainedToSize:size].height;
}
- (CGFloat)getWidthWithSpeace:(CGFloat)lineSpeace withFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self getSizeWithSpeace:lineSpeace withFont:font constrainedToSize:size].width;
}

+ (NSString *)getSelectResultWithArray:(NSArray *)array WithCompare:(NSString *)compare
{
    NSMutableArray *resultArray = [NSMutableArray array];
    for (id obeject in array) {
        if ([NSString isNotEmpty:obeject]) {
            [resultArray addObject:[NSString stringWithFormat:@"%@",obeject]];
        }
    }
    return  resultArray.count>0?[resultArray componentsJoinedByString:compare]:@"";
}

+ (NSString *)getDateStringFromtempString:(NSString*)tmp withFormat:(NSString *)format
{
    if (!format) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSTimeInterval time = [tmp doubleValue] / 1000;
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate: detaildate];
}

+ (NSString *)reviseString:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [[NSString stringIsExist:str] doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

+(NSString *)decimalNumberAddWithString:(NSString *)multiplierValue with:(NSString *)multiplicandValue{
    multiplierValue = [[NSString stringWithFormat:@"%@",multiplierValue] stringByReplacingOccurrencesOfString:@"," withString:@""];
    multiplicandValue = [[NSString stringWithFormat:@"%@",multiplicandValue] stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (![NSString isNotEmpty:multiplierValue] || [multiplierValue doubleValue] == 0) {
        multiplierValue = @"0";
    }
    if (![NSString isNotEmpty:multiplicandValue] || [multiplicandValue doubleValue] == 0) {
        multiplicandValue = @"0";
    }
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplierNumber decimalNumberByAdding:multiplicandNumber];
    return [product stringValue];
}
+(NSString *)decimalNumberSubWithString:(NSString *)multiplierValue with:(NSString *)multiplicandValue{
    multiplierValue = [[NSString stringWithFormat:@"%@",multiplierValue] stringByReplacingOccurrencesOfString:@"," withString:@""];
    multiplicandValue = [[NSString stringWithFormat:@"%@",multiplicandValue] stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (![NSString isNotEmpty:multiplierValue] || [multiplierValue doubleValue] == 0) {
        multiplierValue = @"0";
    }
    if (![NSString isNotEmpty:multiplicandValue] || [multiplicandValue doubleValue] == 0) {
        multiplicandValue = @"0";
    }
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplierNumber decimalNumberBySubtracting:multiplicandNumber];
    return [product stringValue];
}
+(NSString *)decimalNumberMultipWithString:(NSString *)multiplierValue with:(NSString *)multiplicandValue{
    multiplierValue = [[NSString stringWithFormat:@"%@",multiplierValue] stringByReplacingOccurrencesOfString:@"," withString:@""];
    multiplicandValue = [[NSString stringWithFormat:@"%@",multiplicandValue] stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (![NSString isNotEmpty:multiplierValue] || [multiplierValue doubleValue] == 0) {
        multiplierValue = @"0";
    }
    if (![NSString isNotEmpty:multiplicandValue] || [multiplicandValue doubleValue] == 0) {
        multiplicandValue = @"0";
    }
    
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplierNumber decimalNumberByMultiplyingBy:multiplicandNumber];
    return [product stringValue];
}
+(NSString *)decimalNumberDividingWithString:(NSString *)multiplierValue with:(NSString *)multiplicandValue{
    multiplierValue = [[NSString stringWithFormat:@"%@",multiplierValue] stringByReplacingOccurrencesOfString:@"," withString:@""];
    multiplicandValue = [[NSString stringWithFormat:@"%@",multiplicandValue] stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (![NSString isNotEmpty:multiplierValue] || [multiplierValue doubleValue] == 0) {
        multiplierValue = @"0";
    }
    if (![NSString isNotEmpty:multiplicandValue] || [multiplicandValue doubleValue] == 0) {
        multiplicandValue = @"1";
    }
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplierNumber decimalNumberByDividingBy:multiplicandNumber];
    return [product stringValue];
}
+(NSString *)getRoundingOffNumber:(NSString *)string afterPoint:(int)position{
    if (![NSString isNotEmpty:string]) {
        string = @"0";
    }
    string = [[NSString stringWithFormat:@"%@",string] stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithString:string];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [roundedOunces stringValue];
}

+(NSString *)transformNsNumber:(NSString *)string withZeroNum:(NSInteger)zeroNum{
    string = [[NSString stringIsExist:string] stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithString:string];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setDecimalSeparator:@"."];
    [numberFormatter setGroupingSeparator:@","];
    NSMutableString *format = [NSMutableString stringWithString:@"###,##"];
    if (zeroNum > 0) {
        [format appendString:@"0."];
        for (NSInteger i = 0; i < zeroNum; i++) {
            [format appendString:@"0"];
        }
    }
    [numberFormatter setPositiveFormat:format];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:roundedOunces];
    return formattedNumberString;
}

+ (BOOL)validateIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (unsigned)(long)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) inputString
{
    CFStringRef cfString = CFURLCreateStringByAddingPercentEscapes(
                                                                   NULL, /* allocator */
                                                                   (__bridge CFStringRef)inputString,
                                                                   NULL, /* charactersToLeaveUnescaped */
                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                   kCFStringEncodingUTF8);
    NSString *outputStr = [NSString stringWithString:(__bridge NSString *)cfString];
    CFRelease(cfString);
    return outputStr;
    
}
+ (NSString *)decodeFromPercentEscapeString: (NSString *) inputString
{
    NSMutableString *outputStr = [NSMutableString stringWithString:inputString];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)getCurTimeWithFormatter:(NSString *)formatter
{
    NSDate *pickerDate = [NSDate date];
    NSDateFormatter * pickerFormatter = [[NSDateFormatter alloc]init];
    pickerFormatter.timeZone = [NSTimeZone localTimeZone];
    [pickerFormatter setDateFormat:formatter];
    return  [pickerFormatter stringFromDate:pickerDate];
}
+ (UInt32 )getTimeStamp{
    return [NSString getTimeStampWithTime:@""];
}
+ (UInt32 )getTimeStampWithTime:(NSString *)time
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    if (time && time.length > 0) {
        NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
        dateFomatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
        NSTimeZone *fromzone = [NSTimeZone localTimeZone];
        timeInterval = [[dateFomatter dateFromString:time] timeIntervalSince1970];
    }
    UInt32 dTime = [[NSNumber numberWithDouble:timeInterval] intValue];
    return dTime;;
}
//获取当前时间
+(NSString *)getNowTimeDateWithFormatter:(NSString *)formatter{
    NSDate *pickerDate = [NSDate date];
    NSDateFormatter * pickerFormatter = [[NSDateFormatter alloc]init];
    pickerFormatter.timeZone = [NSTimeZone localTimeZone];
    [pickerFormatter setDateFormat:formatter];
    return  [pickerFormatter stringFromDate:pickerDate];
}

+(NSString *)getAppVersion{
    NSDictionary *infoDictionary= [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Version;
}

+(NSString *)randomStringWithLength:(NSInteger)length{
    NSString *string = @"";
    for (NSInteger i = 0; i < length; i ++) {
        NSInteger number = arc4random() % 36;
        if (number < 10) {
            NSInteger figure = arc4random() % 10;
            NSString *temp = [NSString stringWithFormat:@"%ld", figure];
            string = [string stringByAppendingString:temp];
        }else {
            NSInteger figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *temp = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:temp];
        }
    }
    return string;
}


@end
