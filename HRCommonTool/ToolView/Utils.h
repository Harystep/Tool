//
//  Utils.h
//  BJLunTan
//
//  Created by Mac on 15/8/3.
//  Copyright (c) 2015年 Mac Os. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utils : NSObject

///判断字符串是否为空
+ (BOOL)isEmptyString:(NSString *)sourceStr;

///校验手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//获取uuid
+(NSString *)getUUid;

//校验邮箱
+ (BOOL) validateEmail:(NSString *)email;

//获取IP
+ (NSString *)getIPAddress;

///判断设备
+ (NSString*)phoneSize;

//拨打电话
+(void)callWithMobile:(NSString *)mobile;

//URL正则判断
+(BOOL)isURL:(NSString *)url_str;

//判断是够包含某个字符串
+(BOOL)isSubString:(NSString*)string withContainStr:(NSString*)str;
+(void)stopTimer;
+(void)countDownBySeconds:(int)seconds callback:(void(^)(BOOL isTimeout,NSInteger leftSeconds))callback;
//判断是够包含表情
+(BOOL)isContainsEmoji:(NSString *)string;


@end
