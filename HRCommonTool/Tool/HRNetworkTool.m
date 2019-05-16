

#import "HRNetworkTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "DBTipView.h"

@interface HRNetworkTool ()

@property (nonatomic, strong) NSDateFormatter *dateformatter;
/** token失效是的url */
@property (nonatomic, copy) NSString *refreshStr;
/** token失效是的参数 */
@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, strong) DBTipView *tipView;

@end

#define PI 3.1415926

static HRNetworkTool *requestTool;



@implementation HRNetworkTool

- (DBTipView *)tipView{
    if (!_tipView) {
        _tipView = [[DBTipView alloc] init];
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        [win addSubview:_tipView];
    }
    return _tipView;
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
        if (requestTool == nil) {
            requestTool = [[HRNetworkTool alloc] init];
        }
    });
    
    return requestTool;
}
/*
- (void)requestNewPostWithUrlStr:(NSString *)urlStr requestDict:(id)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock{
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是JSON类型
    //    [manager.requestSerializer setTimeoutInterval:10.0];
    //
    //
    //    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //    policy.validatesDomainName = NO;
    //    manager.securityPolicy = policy;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //application/x-www-form-urlencoded
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager.requestSerializer setTimeoutInterval:15.0];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishBlock(responseObject, task);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failBlock(error, task);
    }];
    
}

- (void)requestPostWithUrlStr:(NSString *)urlStr requestDict:(id)dict completeModelBlock:(RequestFinishedModelBlock)finishBlock failBlock:(RequestFailedBlock)failBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //application/x-www-form-urlencoded
    //设置中英文
    [manager.requestSerializer setValue:@"cn" forHTTPHeaderField:@"language"];
    //    [manager.requestSerializer setValue:@"en" forHTTPHeaderField:@"language"];
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:kAppUserToken];
    if (userToken != nil) {
        [manager.requestSerializer setValue:userToken forHTTPHeaderField:@"X-s-top-Authorization"];
    }
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager.requestSerializer setTimeoutInterval:10.0];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WHSRequestModel *dataModel = [WHSRequestModel requestModelWithDic:responseObject];
        
        finishBlock(dataModel, task);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failBlock(error, task);
    }];
}

- (void)requestPostWithNoTokenWithUrlStr:(NSString *)urlStr requestDict:(id)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置中英文
    [manager.requestSerializer setValue:@"cn" forHTTPHeaderField:@"language"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager.requestSerializer setTimeoutInterval:15.0];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishBlock(responseObject, task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == 500) {
            [self showWithStatus:@"服务器错误！"];
        }
        failBlock(error, task);
    }];
}
//获取用户信息
- (void)requestGetUsrInfoWithUrlStr:(NSString *)urlStr withPreStr:(NSString *)preStr withInfoDic:(NSDictionary *)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置中英文
    [manager.requestSerializer setValue:@"cn" forHTTPHeaderField:@"language"];
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:kAppUserToken];
    if (userToken != nil) {
        [manager.requestSerializer setValue:userToken forHTTPHeaderField:@"X-s-top-Authorization"];
    }
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager.requestSerializer setTimeoutInterval:15.0];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if ([responseObject[@"code"] integerValue] == -1) { //token 过期
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kAppUserToken];
            if (kUsertoken != nil) {
                
                [self showTipView:@"登录时间过长,请重新登录！"];
            } else {
                
            }
            
//            NSString *tokenUrl = [NSString stringWithFormat:@"%@%@", HOST_W, kRefreshTokenURL];
//            [self requestPostRefreshTokenWithUrlStr:tokenUrl withPreStr:urlStr withInfoDic:dict completeBlock:^(id finishResult, NSURLSessionDataTask *requestTask) {
//
//            } failBlock:^(id failResult, NSURLSessionDataTask *requestTask) {
//
//            }];
            
        } else {
            
        }
        finishBlock(responseObject, task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (error.code == 500) {
            [self showWithStatus:@"服务器错误！"];
        }
        failBlock(error, task);
    }];
}
//正常的POST请求
- (void)requestPostWithUrlStr:(NSString *)urlStr requestDict:(id)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置中英文
    if (ISChineseLangue) {
        
        [manager.requestSerializer setValue:@"cn" forHTTPHeaderField:@"language"];
    } else if (ISEnglishLangue) {
        [manager.requestSerializer setValue:@"en" forHTTPHeaderField:@"language"];
    }
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:kAppUserToken];
    if (userToken != nil) {
        [manager.requestSerializer setValue:userToken forHTTPHeaderField:@"X-s-top-Authorization"];
    }
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager.requestSerializer setTimeoutInterval:15.0];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if ([responseObject[@"code"] integerValue] == -1) { //token 过期
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kAppUserToken];
            if (kUsertoken != nil) {
                
                [self showTipView:@"登录时间过长,请重新登录！"];
            }
            
//            NSString *tokenUrl = [NSString stringWithFormat:@"%@%@", HOST_W, kRefreshTokenURL];
//            [self requestPostRefreshTokenWithUrlStr:tokenUrl withPreStr:urlStr withInfoDic:dict completeBlock:^(id finishResult, NSURLSessionDataTask *requestTask) {
//
//            } failBlock:^(id failResult, NSURLSessionDataTask *requestTask) {
//
//            }];
           
        }
        finishBlock(responseObject, task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[HRProgressView shareProressView] dismiss];
        });
        if (error.code == 500) {
            [self showWithStatus:@"服务器错误！"];
        }
        failBlock(error, task);
    }];
    
}


- (void)requestPostRefreshTokenWithUrlStr:(NSString *)urlStr withPreStr:(NSString *)preStr withInfoDic:(NSDictionary *)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置中英文
    if (ISChineseLangue) {
        
        [manager.requestSerializer setValue:@"cn" forHTTPHeaderField:@"language"];
    } else if (ISEnglishLangue)  {
        [manager.requestSerializer setValue:@"en" forHTTPHeaderField:@"language"];
    }
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:kAppUserRefreshToken];
    NSDictionary *reDic = nil;
    if (userToken != nil) {
        [manager.requestSerializer setValue:userToken forHTTPHeaderField:@"X-s-top-Authorization"];
        reDic = @{@"token":userToken};
    }
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager.requestSerializer setTimeoutInterval:15.0];
    
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:urlStr parameters:reDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 200) { //token 过期
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:kAppUserToken];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"refresh_token"] forKey:kAppUserRefreshToken];
            [self requestPostWithUrlStr:preStr requestDict:dict completeBlock:^(id finishResult, NSURLSessionDataTask *requestTask) {
                
            } failBlock:^(id failResult, NSURLSessionDataTask *requestTask) {
                
            }];
        } else {//再次返回登录界面
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)requestUpdateFileWithStr:(NSString *)urlStr withData:(NSData *)data requestDict:(id)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    application/x-www-form-urlencoded
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    if (ISChineseLangue) {
        
        [manager.requestSerializer setValue:@"cn" forHTTPHeaderField:@"language"];
    } else if (ISEnglishLangue)  {
        [manager.requestSerializer setValue:@"en" forHTTPHeaderField:@"language"];
    }
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",nil];
    manager.requestSerializer.timeoutInterval = 20;
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:kAppUserToken];
    if (userToken != nil) {
        [manager.requestSerializer setValue:userToken forHTTPHeaderField:@"X-s-top-Authorization"];
    }
    [manager POST:urlStr parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@", str];
        
        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%@%@", fileName, @".jpg"] mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        finishBlock(responseObject, task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
  
        if (error.code == 500) {
            [self showTitleWithText:@"服务器错误,请稍后重试!"];
        } else {
            [self showTitleWithText:@"请检查您的网络设置!"];
        }
        failBlock(error, task);
    }];
   
}


- (void)requestGetWithUrlStr:(NSString *)urlStr requestDict:(NSDictionary *)dict completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock{
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer setTimeoutInterval:10.0];
//
//
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    manager.securityPolicy = policy;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager.requestSerializer setTimeoutInterval:20.0];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlStr parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishBlock(responseObject, task);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failBlock(error, task);
    }];
}
*/
/* 获取当前时间戳 */
- (NSString*)getCurrentDate{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
/* md5 加密 */
-(NSString*)md5Digest:(NSString *)str{
    
    //32位MD5小写
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
}


- (NSString*)getCurrentTimes{
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [self.dateformatter stringFromDate:datenow];
    
//    NSLog(@"currentTimeString =  %@",currentTimeString);
    
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
    
//    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
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
/*
#pragma mark -- 显示时间
- (NSString *)getShowCreateDetail:(HRQuestionModel *)infoModel{
    NSString *currentTime = [[HRNetworkTool shareTool] getCurrentTimes];
    
    //昨天的截止时间
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *yearsterCurrentT = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    NSString *yearStr = [[HRNetworkTool shareTool] nsdateConversionNSString:yearsterCurrentT];
    NSString *yearDay = [yearStr substringWithRange:NSMakeRange(0, 10)];
    NSString *currentDay = [currentTime substringWithRange:NSMakeRange(0, 10)];
    NSString *createDay = [infoModel.create_at substringWithRange:NSMakeRange(0, 10)];
    
    //显示发布时间
    NSInteger minute = [[HRNetworkTool shareTool] getMinuteQuestionTimePlus:infoModel.create_at withCloseTime:currentTime];
    
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
        return [NSString stringWithFormat:@"昨天 %@", [infoModel.create_at substringWithRange:NSMakeRange(11, 5)]];
    } else{
        return [infoModel.create_at substringWithRange:NSMakeRange(5, infoModel.create_at.length - 8)];
    }
}
*/
- (NSString *)getShowCreateTimeDetail:(NSString *)createTime {
    NSString *currentTime = [[HRNetworkTool shareTool] getCurrentTimes];
    //昨天的截止时间
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *yearsterCurrentT = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    NSString *yearStr = [[HRNetworkTool shareTool] nsdateConversionNSString:yearsterCurrentT];
    NSString *yearDay = [yearStr substringWithRange:NSMakeRange(0, 10)];
    NSString *currentDay = [currentTime substringWithRange:NSMakeRange(0, 10)];
    NSString *createDay = [createTime substringWithRange:NSMakeRange(0, 10)];
    
    //显示发布时间
    NSInteger minute = [[HRNetworkTool shareTool] getMinuteQuestionTimePlus:createTime withCloseTime:currentTime];
    
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

- (NSInteger)showRecruitTimeWithCloseTime:(NSString *)closeTime {
    //显示发布时间
    NSString *currentTime = [self getCurrentTimes];
    NSInteger minute = [[HRNetworkTool shareTool] getMinuteQuestionTimePlus:currentTime withCloseTime:closeTime];
    return minute;
}

- (NSString *)getShowTimeDetail:(NSString *)timeStr{
    NSString *currentTime = [[HRNetworkTool shareTool] getCurrentTimes];
    
    //昨天的截止时间
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *yearsterCurrentT = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    NSString *yearStr = [[HRNetworkTool shareTool] nsdateConversionNSString:yearsterCurrentT];
    NSString *yearDay = [yearStr substringWithRange:NSMakeRange(0, 10)];
    NSString *currentDay = [currentTime substringWithRange:NSMakeRange(0, 10)];
    NSString *createDay = [timeStr substringWithRange:NSMakeRange(0, 10)];
    
    //显示发布时间
    NSInteger minute = [[HRNetworkTool shareTool] getMinuteQuestionTimePlus:timeStr withCloseTime:currentTime];
    
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
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:font];
    CGSize postJobSize = [title boundingRectWithSize:CGSizeMake(limitWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil].size;
    
    return postJobSize.height + 20;
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


#pragma mark - ---提示label
//提示框
-(void)showTipView:(NSString *)message{
    
    [self performSelectorOnMainThread:@selector(show:) withObject:message waitUntilDone:YES];
}

- (void)show:(NSString*)message{
    
    if (message && message.length > 0) {
        self.tipView.message = message;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(showTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tipView = nil;
    });
}


-(void)showTipView:(NSString*)message time:(int)time{
    if (message && message.length > 0) {
        self.tipView.time = time;
        self.tipView.message =message;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(showTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tipView = nil;
    });
}

-(CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize {
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(kWIDTH, 20) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil];

    return rect.size.width;
}

@end
