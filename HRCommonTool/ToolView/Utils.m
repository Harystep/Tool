//
//  Utils.m
//  BJLunTan
//
//  Created by Mac on 15/8/3.
//  Copyright (c) 2015年 Mac Os. All rights reserved.
//

#import "Utils.h"
#include <net/if.h>
#include <net/if_dl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "sys/utsname.h"
dispatch_queue_t queue ;
dispatch_source_t _timer;


@implementation Utils

+ (NSString *)screenHeight
{
    int height = [[UIScreen mainScreen] currentMode].size.height;
    return [NSString stringWithFormat:@"%d", height];
}

+ (NSString *)screenWidth
{
    int width = [[UIScreen mainScreen] currentMode].size.width;
    return [NSString stringWithFormat:@"%d", width];
}

+ (NSString *)movQuality
{
//    if (iPhone5)
//    {
//        return @"H";
//    }
    
    return @"N";
}


// 判断状态栏偏移
+ (float)upHeightOffset
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        return 20.0f;
    }
    
    return 0.0f;
}
+ (UIColor *)colorFromColorString:(NSString *)colorString {
    NSScanner *scanner = [[NSScanner alloc] initWithString:colorString];
    unsigned color = 0;
    [scanner scanHexInt:&color];
    
    //    unsigned a = (color >> 24) & 0x000000FF;
    unsigned r = (color >> 16) & 0x000000FF;
    unsigned g = (color >> 8) & 0x000000FF;
    unsigned b = color & 0x000000FF;
    //    NSLog(@"rf is %f gf is %f bf is %f",r,g,b);
    
    CGFloat rf = (CGFloat)r / 255.f;
    CGFloat gf = (CGFloat)g / 255.f;
    CGFloat bf = (CGFloat)b / 255.f;
    //    CGFloat af = (CGFloat)a / 255.f;
    
    //    NSLog(@"rf is %f gf is %f bf is %f",rf,gf,bf);
    
    return [UIColor colorWithRed:rf green:gf blue:bf alpha:1.0f];
}

+ (NSString *)int10ToString16 :(NSInteger) random {
    
    NSString *jinzhi16char = @"0123456789abcdef";
    NSInteger int10 = random;
    NSString *jinzhi16 = @"";
    int j = 0;
    while(int10 != 0)
    {
        j = int10 % 16;
        //        NSLog(@"%i", j);
        //        NSLog(@"%@", [jinzhi16char substringWithRange:NSMakeRange(j,1)]);
        jinzhi16 = [NSString stringWithFormat:@"%@%@",[jinzhi16char substringWithRange:NSMakeRange(j,1)], jinzhi16];
        int10 = int10 / 16;
    }
    jinzhi16 = [NSString stringWithFormat:@"%@%@",@"0x", jinzhi16];
    
    //    NSLog(@"%@", jinzhi16);
    
    return jinzhi16;
}


//字符串为空检查
+ (BOOL)isEmptyString:(NSString *)sourceStr {
    if ((NSNull *)sourceStr == [NSNull null]) {
        return YES;
    }
    if ([sourceStr isEqualToString:@"null"]) {
        return YES;
    }
    if ([sourceStr isEqualToString:@""]) {
        return YES;
    }
    
    if ([sourceStr isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if (sourceStr == nil) {
        return YES;
    }
    if (sourceStr == NULL) {
        return YES;
    }
    if (sourceStr.length == 0) {
        return YES;
    }
    
    NSString *str = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (str.length == 0) {
        return YES;
    }
    return NO;
}

// 校验手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|7[0]|8[0235-9])\\d{8}$";//@"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(NSString *)getUUid
{
     __autoreleasing NSString * uuid = nil;
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef str_ref = CFUUIDCreateString(NULL, uuid_ref);
    uuid = [NSString stringWithString:(NSString *)CFBridgingRelease(str_ref)];
    //        CFRelease(str_ref);
    CFRelease(uuid_ref);
    return uuid;
}

+ (BOOL) validateEmail:(NSString *)email
{
  //  ^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$
    NSString *emailRegex = @"^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
   // NSString *emailRegex = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}


//+(BOOL)validateURL:(NSString *)url{
//    
//    NSString *urlRegex = @"(https?|ftp|mms):\/\/([A-z0-9]+[_\-]?[A-z0-9]+\.)*[A-z0-9]+\-?[A-z0-9]+\.[A-z]{2,}(\/.*)*\/?";
//    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
//    return [urlTest evaluateWithObject:url];
//}

//获得iOS的ip地址。
+ (NSString *)getIPAddress
{
    __autoreleasing NSString *address = @"";

        struct ifaddrs *interfaces = NULL;
        struct ifaddrs *temp_addr = NULL;
        int success = 0;
        // retrieve the current interfaces - returns 0 on success
        success = getifaddrs(&interfaces);
        if (success == 0)
        {
            // Loop through linked list of interfaces
            temp_addr = interfaces;
            while(temp_addr != NULL)
            {
                if(temp_addr->ifa_addr->sa_family == AF_INET)
                {
                    // Check if interface is en0 which is the wifi connection on the iPhone
                    if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                    {
                        // Get NSString from C String
                        address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    }
                }
                temp_addr = temp_addr->ifa_next;
            }
        }
        // Free memory
        freeifaddrs(interfaces);

    
    return address;
}


//拨打电话
+(void)callWithMobile:(NSString *)mobile{
    
//    if([self isMobileNumber:mobile]){
//        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",mobile];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//
//    }else{
//        
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    }
}

+ (NSString *)phoneSize{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
 
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone4s";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone6p";

    if ([deviceString isEqualToString:@"i386"])         return @"模拟器";//模拟器
    if ([deviceString isEqualToString:@"x86_64"])       return @"模拟器";//模拟器
    
    return deviceString;
}

+(void)countDownBySeconds:(int)seconds callback:(void(^)(BOOL isTimeout,NSInteger leftSeconds))callback {
    
    __block int timeout=seconds; //倒计时时间
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(YES,timeout);
                
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(NO,timeout);
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}
+(void)stopTimer{
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
+(BOOL)isURL:(NSString *)url_str
{
    NSString *url_pre = @"(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", url_pre];
    return [regex evaluateWithObject:url_str];
}

+(BOOL)isSubString:(NSString*)string withContainStr:(NSString*)str{
    BOOL isSub=NO;
    NSRange range = [string rangeOfString:str];
    if (range.length>0) {
        isSub=YES;
    }
    return isSub;
}
+(BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


@end
