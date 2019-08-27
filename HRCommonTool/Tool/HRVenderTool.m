//
//  HRVenderTool.m
//  HRCommonTool
//
//  Created by pxsl on 2019/8/27.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "HRVenderTool.h"

@interface HRVenderTool ()

@property (nonatomic, strong) NSDateFormatter *dateformatter;

@property (strong, nonatomic) NSDateFormatter *yyDateformatter;

@property (strong, nonatomic) NSDateFormatter *ssDateformatter;

@property (strong, nonatomic) NSDateFormatter *formatter;

@end

#define PI 3.1415926

static HRVenderTool *venderTool;

@implementation HRVenderTool

- (NSDateFormatter *)formatter {
    
    if (_formatter == nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        _formatter = formatter;
    }
    return _formatter;
}

- (NSDateFormatter *)yyDateformatter {
    
    if (_yyDateformatter == nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        [formatter setDateFormat:@"YYYY-MM-dd"];
        _yyDateformatter = formatter;
    }
    return _yyDateformatter;
}

- (NSDateFormatter *)ssDateformatter {
    
    if (_ssDateformatter == nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        [formatter setDateFormat:@"HH:mm:ss"];
        _ssDateformatter = formatter;
    }
    return _ssDateformatter;
}

- (NSDateFormatter *)dateformatter {
    
    if (_dateformatter == nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        _dateformatter = formatter;
    }
    return _dateformatter;
}

+ (instancetype)shareTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (venderTool == nil) {
            venderTool = [[HRVenderTool alloc] init];
        }
    });
    
    return venderTool;
}

/* 获取当前时间戳 */
- (NSString*)getCurrentDate{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

- (NSString*)getCurrentTimes{
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [self.dateformatter stringFromDate:datenow];
    
    return currentTimeString;
    
}
- (NSInteger)getQuestionTimePlus:(NSString *)createTime withCloseTime:(NSString *)closeTime {
    
    NSDate *createDate = [self.dateformatter dateFromString:createTime];
    NSDate *closeDate = [self.dateformatter dateFromString:closeTime];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    unsigned int unitFlags = NSCalendarUnitHour;//年、月、日、时、分、秒、周等等都可以
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:createDate toDate:closeDate options:0];
    NSInteger hours = [comps hour];
    
    return hours;
}
- (NSInteger)getMinuteQuestionTimePlus:(NSString *)createTime withCloseTime:(NSString *)currentTime {
    
    NSDate *createDate = [self.dateformatter dateFromString:createTime];
    NSDate *closeDate = [self.dateformatter dateFromString:currentTime];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    unsigned int unitFlags = NSCalendarUnitMinute;//年、月、日、时、分、秒、周等等都可以
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:createDate toDate:closeDate options:0];
    //    NSInteger hours = [comps hour];
    NSInteger minute = [comps minute];
    
    return minute;
}

- (NSInteger)getSecondQuestionTimePlus:(NSString *)createTime withCloseTime:(NSString *)currentTime {
    
    NSDate *createDate = [self.dateformatter dateFromString:createTime];
    NSDate *closeDate = [self.dateformatter dateFromString:currentTime];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    unsigned int unitFlags = NSCalendarUnitMinute;//年、月、日、时、分、秒、周等等都可以
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:createDate toDate:closeDate options:0];
    //    NSInteger hours = [comps hour];
    NSInteger second = [comps second];
    
    return second;
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

- (NSString *)convertToJsonDataExistSpace:(NSDictionary *)dict {
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2{
    
    double er = 6378137.0f; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    
    return dist;
    
}
#pragma mark -- 时间戳转字符串
-(NSString *)timeConversionNSString:(NSString *)timeStamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]];
    
    NSString *dateStr = [self.dateformatter stringFromDate:date];
    return dateStr;
}

//时间戳转字符串
-(NSString *)timeStampConversionNSString:(NSString *)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    
    NSString *dateStr = [self.dateformatter stringFromDate:date];
    return dateStr;
}
//时间转时间戳
-(NSString *)dateConversionTimeStamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    return timeSp;
}
//字符串转时间
-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    
    NSDate *datestr = [self.dateformatter dateFromString:dateStr];
    return datestr;
}
//NSDate 转字符串
- (NSString *)nsdateConversionNSString:(NSDate *)date{
    
    NSString *strDate = [self.dateformatter stringFromDate:date];
    return strDate;
}

- (NSString *)getShowCreateTimeDetail:(NSString *)createTime {
    NSString *currentTime = [[HRVenderTool shareTool] getCurrentTimes];
    //昨天的截止时间
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *yearsterCurrentT = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    NSString *yearStr = [[HRVenderTool shareTool] nsdateConversionNSString:yearsterCurrentT];
    NSString *yearDay = [yearStr substringWithRange:NSMakeRange(0, 10)];
    NSString *currentDay = [currentTime substringWithRange:NSMakeRange(0, 10)];
    NSString *createDay = [createTime substringWithRange:NSMakeRange(0, 10)];
    
    //显示发布时间
    NSInteger minute = [[HRVenderTool shareTool] getMinuteQuestionTimePlus:createTime withCloseTime:currentTime];
    
    if ([createDay isEqualToString:currentDay]) {
        if (minute < 60) {
            if (minute < 1) {
                return @"刚刚";
            } else {
                return [NSString stringWithFormat:@"%tu分钟前", minute];
            }
            
        } else {
            
            return [NSString stringWithFormat:@"%tu小时前", minute / 60];
        }
    } else if ([createDay isEqualToString:yearDay]) {
        return [NSString stringWithFormat:@"昨天 %@", [createTime substringWithRange:NSMakeRange(11, 5)]];
    } else{
        return [createTime substringWithRange:NSMakeRange(5, createTime.length - 8)];
    }
}


- (NSString *)getShowTimeDetail:(NSString *)timeStr{
    NSString *currentTime = [[HRVenderTool shareTool] getCurrentTimes];
    
    //昨天的截止时间
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *yearsterCurrentT = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    NSString *yearStr = [[HRVenderTool shareTool] nsdateConversionNSString:yearsterCurrentT];
    NSString *yearDay = [yearStr substringWithRange:NSMakeRange(0, 10)];
    NSString *currentDay = [currentTime substringWithRange:NSMakeRange(0, 10)];
    NSString *createDay = [timeStr substringWithRange:NSMakeRange(0, 10)];
    
    //显示发布时间
    NSInteger minute = [[HRVenderTool shareTool] getMinuteQuestionTimePlus:timeStr withCloseTime:currentTime];
    
    if ([createDay isEqualToString:currentDay]) {
        if (minute < 60) {
            if (minute < 1) {
                return @"刚刚";
            } else {
                return [NSString stringWithFormat:@"%tu分钟前", minute];
            }
            
        } else {
            
            return [NSString stringWithFormat:@"%tu小时前", minute / 60];
        }
    } else if ([createDay isEqualToString:yearDay]) {
        //        return [NSString stringWithFormat:@"昨天 %@", [timeStr substringWithRange:NSMakeRange(11, 5)]];
        return @"昨天";
    } else{
        return [timeStr substringWithRange:NSMakeRange(5, timeStr.length - 13)];
    }
}

- (NSString *)md5WithTimeSmap {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *smap = [self dateConversionTimeStamp:date];
    //获取一个随机数范围在：[500,1000），包括500，不包括1000
    int y = arc4random() % 1000;
    NSString *endStr = [NSString stringWithFormat:@"+%d", y];
    NSLog(@"endstr--->%@", endStr);
    NSString *mdStr = [smap stringByAppendingString:endStr];
    return [self md5Digest:mdStr];
}

#pragma mark -- 计算视图宽度
- (CGFloat)compareViewWidth:(NSString *)title withFont:(CGFloat)font widthLimited:(CGFloat)limitWidth{
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:font];
    CGSize postJobSize = [title boundingRectWithSize:CGSizeMake(limitWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil].size;
    
    return postJobSize.width + 10;
}

- (CGFloat)compareContentHeight:(NSString *)title withFont:(CGFloat)font widthLimited:(CGFloat)limitWidth{
    UIFont *fnt = [UIFont systemFontOfSize:font];
    CGSize postJobSize = [title boundingRectWithSize:CGSizeMake(limitWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil].size;
    return postJobSize.height;
}
#pragma mark -- 检验字符串中是否全是数字
- (BOOL)deptNumInputShouldNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}


- (NSString *)tranferJsonStringWithDic:(NSDictionary *)dic {
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (NSString *)conversionStringWithContent:(NSString *)content {
    if ([content isEqual:[NSNull null]]) {
        return @"";
    } else {
        return content;
    }
}

- (BOOL)isCheckData:(id)data{
    if ([data isEqual:[NSNull null]]) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)stringUserfulContent:(id)content{
    if ([content isEqual:[NSNull null]]) {
        return @"";
    } else {
        if (content==nil) {
            return @"";
        }else{
            return content;
        }
    }
}

-(NSDate *)getPriousorYearDateFromDate:(NSDate *)date withYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day{
    //获取上一年时间
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    NSDate*mDate =[calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}


- (NSString *)getDayWithYYMMDD {
    
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [self.yyDateformatter stringFromDate:datenow];
    
    return currentTimeString;
}

- (NSString *)getDayWithHHMMSS {
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [self.ssDateformatter stringFromDate:datenow];
    
    return currentTimeString;
}
- (NSString *)dayCNTypeFromType:(NSInteger)type{
    NSString *dateType;
    switch (type) {
        case 0:
            dateType = @"";
            break;
        case 1:
            dateType = @"月";
            break;
        case 2:
            dateType = @"年";
            break;
            
        default:
            break;
    }
    return dateType;
}

- (NSString *)dayENTypeFromType:(NSInteger)type{
    NSString *dateType;
    switch (type) {
        case 0:
            dateType = @"day";
            break;
        case 1:
            dateType = @"month";
            break;
        case 2:
            dateType = @"year";
            break;
            
        default:
            break;
    }
    return dateType;
}

- (NSString *)getWeekDay {
    NSDate *date = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSNumber * weekNumber = @([comps weekday]);
    NSInteger weekInt = [weekNumber integerValue];
    NSString *week = @"星期一";
    switch (weekInt) {
        case 1:
            week = @"星期天";
            break;
        case 2:
            week = @"星期一";
            break;
        case 3:
            week = @"星期二";
            break;
        case 4:
            week = @"星期三";
            break;
        case 5:
            week = @"星期四";
            break;
        case 6:
            week = @"星期五";
            break;
        case 7:
            week = @"星期六";
            break;
            
        default:
            break;
    }
    return week;
}
#pragma mark -- 规范金额显示
- (NSString *)ruleMoneyType:(NSString *)money{
    //    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    //    NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithDouble:[money doubleValue]]];
    //    newAmount = [newAmount stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    //
    //    if ([newAmount doubleValue] >0) {
    //        return newAmount;
    //    }
    if ([[HRVenderTool shareTool] stringUserfulContent:money]) {
        money = [NSString stringWithFormat:@"%@", money];
        NSArray *moneyArr = [money componentsSeparatedByString:@"."];
        NSString *firM = moneyArr.firstObject;
        NSString *mouseM = moneyArr.lastObject;
        NSString *content;
        if (mouseM.length==0) {
            mouseM = @"00";
        }
        if ([money doubleValue] >0) {
            if (firM.length>9 && firM.length<12) {
                firM = [NSString stringWithFormat:@"%@,%@,%@,%@", [firM substringWithRange:NSMakeRange(0, firM.length-9)], [firM substringWithRange:NSMakeRange(firM.length-9, 3)], [firM substringWithRange:NSMakeRange(firM.length-6, 3)], [firM substringWithRange:NSMakeRange(firM.length-3, 3)]];
            } else if(firM.length>=7 && firM.length<=9) {
                firM = [NSString stringWithFormat:@"%@,%@,%@", [firM substringWithRange:NSMakeRange(0, firM.length-6)], [firM substringWithRange:NSMakeRange(firM.length-6, 3)], [firM substringWithRange:NSMakeRange(firM.length-3, 3)]];
            } else if (firM.length>=4 && firM.length<7) {
                firM = [NSString stringWithFormat:@"%@,%@", [firM substringWithRange:NSMakeRange(0, firM.length-3)], [firM substringWithRange:NSMakeRange(firM.length-3, 3)]];
            } else{
                firM = firM;
            }
            content = [NSString stringWithFormat:@"%@.%@", firM, mouseM];
            return content;
        }else{
            return @"0.00";
        }
    } else{
        return @"0.00";
    }
}

- (double)getMaxNumFromArray:(NSArray *)dataArr{
    double max_number = 0.0;
    int max_index = 0;
    
    double min_number = 0.0;
    int min_index = 0;
    
    double all = 0;
    float mid = 0;
    if ([[HRVenderTool shareTool] isCheckData:dataArr]) {
        for (int i = 0; i<dataArr.count; i++) {
            //取最大值和最大值的对应下标
            double a = [dataArr[i] doubleValue];
            if (a > max_number) {
                max_index = i;
            }
            max_number = a>max_number?a:max_number;
            //取最小值和最小值的对应下标
            
            double b = [dataArr[i] doubleValue];
            if (b<min_number) {
                min_index = i;
            }
            min_number = b<min_number?b:min_number;
            // 取平均数和总和
            double c = [dataArr[i] doubleValue];
            all += c;
            mid = all/dataArr.count;
        }
    }
    return max_number;
}
- (long)getMaxNumToInteger:(double)num {
    NSString *numStr = [NSString stringWithFormat:@"%@", @(num)];
    NSString *integerStr = [[numStr componentsSeparatedByString:@"."] firstObject];
    NSString *firstStr;
    NSString *secordStr;
    if (integerStr.length == 1) {
        return 20;
    } else if(integerStr.length == 2) {
        firstStr = [integerStr substringWithRange:NSMakeRange(0, 1)];
        secordStr = [integerStr substringWithRange:NSMakeRange(1, 1)];
        if ([firstStr integerValue] > 5) {
            return 100;
        } else{
            return 60;
        }
    } else {
        firstStr = [integerStr substringWithRange:NSMakeRange(0, 1)];
        secordStr = [integerStr substringWithRange:NSMakeRange(1, 1)];
        NSString *newStr;
        newStr = [self stringLength:integerStr.length withFirstNum:[firstStr integerValue] withSecondNum:[secordStr integerValue]];
        return [newStr longLongValue];
    }
}

- (NSString *)stringLength:(NSInteger)length withFirstNum:(NSInteger)firstNum withSecondNum:(NSInteger)secondNum {
    NSString *content;
    if (firstNum == 9) {
        if (secondNum == 9) {
            content = [self stringAppendWithMoreZore:length withTails:YES];
        }else if(secondNum == 8){
            content = [self stringAppendWithMoreZore:length withTails:NO];
        } else{
            content = [self stringWithMoreContent:length withFirstNum:firstNum withSecondNum:secondNum];
        }
    } else {
        content = [self stringWithContentLength:length withFirNum:firstNum withSecondNum:secondNum];
    }
    return content;
}

- (NSString *)stringWithContentLength:(NSInteger)length withFirNum:(NSInteger)firNum withSecondNum:(NSInteger)secNum{
    NSString *content;
    if (secNum == 9) {
        content = [NSString stringWithFormat:@"%tu%@", firNum+1, @"1"];
    } else if (secNum == 8) {
        content = [NSString stringWithFormat:@"%tu%@", firNum+1, @"0"];
    }else{
        content = [NSString stringWithFormat:@"%tu%tu", firNum, secNum+2];
    }
    for (int i = 2; i < length; i++) {
        content = [content stringByAppendingString:@"0"];
    }
    return content;
}


- (NSString *)stringWithMoreContent:(NSInteger)length withFirstNum:(NSInteger)firstNum withSecondNum:(NSInteger)secondNum {
    NSString *content;
    content = [NSString stringWithFormat:@"%tu%tu", firstNum, secondNum+2];
    for (int i = 2; i < length; i++) {
        content = [content stringByAppendingString:@"0"];
    }
    return content;
}

- (NSString *)stringAppendWithMoreZore:(NSInteger)num withTails:(BOOL)flag{
    NSString *content;
    if (flag) {
        content = @"11";
        for (int i = 1; i < num; i++) {
            content = [content stringByAppendingString:@"0"];
        }
    }else{
        content = @"1";
        for (int i = 0; i < num; i++) {
            content = [content stringByAppendingString:@"0"];
        }
    }
    return content;
}

- (kCompanyType)stringConvertCompanyMoney:(long)num {
    long maxNum = [self getMaxNumToInteger:num];
    NSString *maxStr = [NSString stringWithFormat:@"%@", @(maxNum)];
    kCompanyType company;
    if (maxStr.length >= 5 && maxStr.length<7) {
        company = kCompanyTypeWanYuan;
    } else if (maxStr.length >= 7&&maxStr.length<9) {
        company = kCompanyTypeBaiWan;
    } else if (maxStr.length >= 9) {
        company = kCompanyTypeYiYuan;
    } else {
        company = kCompanyTypeYuan;
    }
    return company;
}

- (NSMutableAttributedString *)attributedStringWitnContentString:(NSString *)contentStr withChangeRange:(NSRange)range withFont:(UIFont *)font withTxtColor:(UIColor *)color {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    [attr addAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color} range:range];
    return attr;
}

- (NSDictionary *)convertSafeDictWithDic:(NSDictionary *)dic {
    if ([[HRVenderTool shareTool] isCheckData:dic]) {
        NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
        NSArray *keyArr = dic.allKeys;
        for (NSString *key in keyArr) {
            if ([dic[key] isEqual:[NSNull null]]) {
                [dicM setObject:@"" forKey:key];
            }else{
                [dicM setObject:dic[key] forKey:key];
            }
        }
        return dicM;
    }else{
        return nil;
    }
}

@end
