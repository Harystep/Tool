

#import <Foundation/Foundation.h>


typedef void(^RequestFinishedBlock)(id finishResult, NSURLSessionDataTask *requestTask);
typedef void(^RequestFailedBlock)(id failResult, NSURLSessionDataTask *requestTask);

@interface HRNetworkTool : NSObject

+(instancetype)shareTool;


-(void)showTipView:(NSString *)message;

//获取用户信息
- (void)getUserInfoOperateURL;

- (void)requestNewPostWithUrlStr:(NSString *)urlStr requestDict:(id)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock: (RequestFailedBlock)failBlock;

- (void)requestUpdateFileWithStr:(NSString *)urlStr withData:(NSData *)data requestDict:(id)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock;
/** 刷新token */
- (void)requestPostRefreshTokenWithUrlStr:(NSString *)urlStr withPreStr:(NSString *)preStr withInfoDic:(NSDictionary *)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock;

- (void)requestGetUsrInfoWithUrlStr:(NSString *)urlStr withPreStr:(NSString *)preStr withInfoDic:(NSDictionary *)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock;

/**
 *   普通POST请求
 *
 *  @param urlStr      请求地址
 *  @param dict        请求参数
 *  @param finishBlock 成功回调
 *  @param failBlock   失败回调
 */
- (void)requestPostWithUrlStr: (NSString *)urlStr requestDict: (id)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock: (RequestFailedBlock)failBlock;
//退出登录 不需要token的请求
- (void)requestPostWithNoTokenWithUrlStr:(NSString *)urlStr requestDict:(id)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock;
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

- (NSString*)getValue:(NSString*)str;
- (void)showTitleWithText:(NSString *)string;

- (NSString *)tranferJsonStringWithDic:(NSDictionary *)dic;

/** 比较时间 */
- (NSInteger)showRecruitTimeWithCloseTime:(NSString *)closeTime;
/** 显示时间 */
- (NSString *)getShowCreateTimeDetail:(NSString *)createTime;

/** 计算文字的宽度 */
- (CGFloat)compareViewWidth:(NSString *)title withFont:(CGFloat)font widthLimited:(CGFloat)limitWidth;

- (CGFloat)compareContentHeight:(NSString *)title withFont:(CGFloat)font widthLimited:(CGFloat)limitWidth;
//检验字符串中是否全是数字
- (BOOL)deptNumInputShouldNumber:(NSString *)str;

//计算文字长度
- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize;
@end
