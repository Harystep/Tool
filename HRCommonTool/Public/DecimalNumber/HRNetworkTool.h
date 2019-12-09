

#import <Foundation/Foundation.h>

typedef enum {
    kCompanyTypeYuan=0,
    kCompanyTypeWanYuan,
    kCompanyTypeBaiWan,
    kCompanyTypeYiYuan,
} kCompanyType;

@interface HRNetworkTool : NSObject

+(instancetype)shareTool;

/** 秒 */
-(NSString *)timeConversionNSString:(NSString *)timeStamp;

/* 获取当前时间戳 */
- (NSString*)getCurrentDate;

/* md5 加密 */
-(NSString*)md5Digest:(NSString *)str;

/* 获取当前时间 */
- (NSString*)getCurrentTimes;

/** 字典转Json */
- (NSString *)convertToJsonData:(NSDictionary *)dict;
/** 字典转Json（空格存在） */
- (NSString *)convertToJsonDataExistSpace:(NSDictionary *)dict;
/** Json转字典 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

-(double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2;

/** 时间戳转字符串 */
- (NSString *)timeStampConversionNSString:(NSString *)timeStamp;
/** 时间转时间戳 */
- (NSString *)dateConversionTimeStamp:(NSDate *)date;
/** 字符串转时间 */
- (NSDate *)nsstringConversionNSDate:(NSString *)dateStr;
/** 时间转字符串 */
- (NSString *)nsdateConversionNSString:(NSDate *)date;
/** 显示时间 */

/** 对时间戳进行加密 */
- (NSString *)md5WithTimeSmap;

- (NSString *)tranferJsonStringWithDic:(NSDictionary *)dic;

/** 显示时间 */
- (NSString *)getShowCreateTimeDetail:(NSString *)createTime;

/** 计算文字的宽度 */
- (CGFloat)compareViewWidth:(NSString *)title withFont:(CGFloat)font widthLimited:(CGFloat)limitWidth;

- (CGFloat)compareContentHeight:(NSString *)title withFont:(CGFloat)font widthLimited:(CGFloat)limitWidth;

//检验字符串中是否全是数字
- (BOOL)deptNumInputShouldNumber:(NSString *)str;

- (NSString *)conversionStringWithContent:(NSString *)content;

- (BOOL)isCheckData:(id)data;
/** 处理字符串赋值 */
- (NSString *)stringUserfulContent:(id)content;
/** 处理纯数字赋值 */
- (NSString *)stringIntegerSafeNum:(id)content;

/**
 获取当前时间的年月日
 */
- (NSString *)getDayWithYYMMDD;
/**
 获取当前时间的时分秒
 */
- (NSString *)getDayWithHHMMSS;
/**
 获取当前时间星期几
 */
- (NSString *)getWeekDay;
/** 获取当前日期 */
- (NSString *)getCurrentDay;

- (NSString *)dayENTypeFromType:(NSInteger)type;
- (NSString *)dayCNTypeFromType:(NSInteger)type;

/** 获取上一年的时间 */
-(NSDate *)getPriousorYearDateFromDate:(NSDate *)date withYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day;
/** 规范金额显示 */
- (NSString *)ruleMoneyType:(NSString *)money;
/** 取出数组里面的最大值 */
- (double)getMaxNumFromArray:(NSArray *)dataArr;
/** 获取最接近的整数 */
- (long)getMaxNumToInteger:(double)num;
/** 转换单位 */
- (kCompanyType)stringConvertCompanyMoney:(long)num;
/** 设置富文本信息 */
- (NSMutableAttributedString *)attributedStringWitnContentString:(NSString *)contentStr withChangeRange:(NSRange)range withFont:(UIFont *)font withTxtColor:(UIColor *)color;
/** 转换安全字典 */
- (NSDictionary *)convertSafeDictWithDic:(NSDictionary *)dic;
/** 根据不同时间转换时间格式 */
- (NSString *)stringConvertTimeFromFormatter:(NSString *)formatter toFormatter:(NSString *)toFormatter withTimeStr:(NSString *)timeStr;
/** 对纯数字数组进行排序 */
- (NSArray *)sortArrayFromNumArray:(NSArray *)array;
//转换企业类型
- (NSString *)convertBusinessTypeWithString:(NSString *)string;
//比较两个时间差
- (NSString *)compareTimeDifferenceStartTime:(NSString *)startTime withEndTime:(NSString *)endTime;

@end
