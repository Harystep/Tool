//
//  HCDateSelectorView.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCDateSelectorView.h"

static HCDateSelectorView *dateTool;

@implementation HCDateSelectorView

+ (instancetype)shareDate{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dateTool == nil) {
            dateTool = [[HCDateSelectorView alloc] init];
        }
    });
    return dateTool;
}

- (NSString *)getDateView:(BRDatePickerMode)mode {
    
    NSString *defaultSelectDate;
    NSDate *dateStrF = [self getPriousorYearDateFromDate:[NSDate date] withYear:0 withMonth:0 withDay:0];
    if (mode == BRDatePickerModeYM) {
        defaultSelectDate = dateStrF.yyyyMMByLineWithDate;
    } else if (mode == BRDatePickerModeY) {
        defaultSelectDate = dateStrF.mmYearChineseWithDate;
    }else if(mode == BRDatePickerModeYMD){
        defaultSelectDate = dateStrF.yyyyMMddByLineWithDate;
    }
    return defaultSelectDate;
    
}

- (NSString *)getNewDate {
    NSDateFormatter * fmt = [[hczyDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss" andLocaleIdentifier:@"zh_CN"];
    NSDate *dateStrF = [self getPriousorYearDateFromDate:[NSDate date] withYear:0 withMonth:0 withDay:0];
    NSString *nowStr = [fmt stringFromDate:dateStrF];
    return nowStr;
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
@end
