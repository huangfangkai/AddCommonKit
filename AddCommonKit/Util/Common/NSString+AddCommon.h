//
//  NSString+AddCommon.h
//  111
//
//  Created by hfk on 2020/6/24.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AddCommon)

/// obj转json格式字符串
/// @param obj 需要转换对象
+ (NSString*)transformToJson:(id)obj;

/// json转对象
/// @param json 需要转换的json
+ (id)transformToObj:(NSString*)json;

/// 判断是否为空
/// @param str 需要判断的
+ (BOOL)isNotEmpty:(NSString *)str;


/// 如果是空返回""
/// @param string 需要判断的
+ (NSString *)stringIsExist:(NSString *)string;

/// 计算字符显示size
/// @param font 字体
/// @param size size
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)getSizeWithSpeace:(CGFloat)lineSpeace withFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithSpeace:(CGFloat)lineSpeace withFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithSpeace:(CGFloat)lineSpeace withFont:(UIFont *)font constrainedToSize:(CGSize)size;

/// 拼接字符串
/// @param array 需要拼接字符串集合
/// @param compare 分割符
+ (NSString *)getSelectResultWithArray:(NSArray *)array WithCompare:(NSString *)compare;

/// 时间戳转换
/// @param tmp 时间戳时间
/// @param format 转换格式
+ (NSString *)getDateStringFromtempString:(NSString*)tmp withFormat:(NSString *)format;

/// 修正浮点型精度丢失
/// @param str 传入接口取到的数据
+ (NSString *)reviseString:(NSString *)str;
//大额金钱计算
+(NSString *)decimalNumberAddWithString:(NSString *)multiplierValue with:(NSString *)multiplicandValue;
+(NSString *)decimalNumberSubWithString:(NSString *)multiplierValue with:(NSString *)multiplicandValue;
+(NSString *)decimalNumberMultipWithString:(NSString *)multiplierValue with:(NSString *)multiplicandValue;
+(NSString *)decimalNumberDividingWithString:(NSString *)multiplierValue with:(NSString *)multiplicandValue;
+(NSString *)getRoundingOffNumber:(NSString *)string afterPoint:(int)position;
//千分位金额
+(NSString *)transformNsNumber:(NSString *)string withZeroNum:(NSInteger)zeroNum;


/// 判断身份证号码是否正确
/// @param value 身份证号码
+ (BOOL)validateIDCardNumber:(NSString *)value;

/// 编码
/// @param inputString 输入字符串
+ (NSString *)encodeToPercentEscapeString: (NSString *) inputString;

/// 解码
/// @param inputString 输入字符串
+ (NSString *)decodeFromPercentEscapeString: (NSString *) inputString;

/// 获取当前时间
/// @param formatter 时间格式
+ (NSString *)getCurTimeWithFormatter:(NSString *)formatter;

/// 获取当前时间戳
+ (UInt32 )getTimeStamp;
/// 获取时间戳
/// @param time 时间格式必须为yyyy/MM/dd HH:mm:ss
+ (UInt32 )getTimeStampWithTime:(NSString *)time;

//获取当前时间
+(NSString *)getNowTimeDateWithFormatter:(NSString *)formatter;

//获取app版本号
+(NSString *)getAppVersion;

//生成随机字符串
+(NSString *)randomStringWithLength:(NSInteger)length;

@end

NS_ASSUME_NONNULL_END
