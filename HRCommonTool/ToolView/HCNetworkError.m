//
//  HCNetworkError.m
//  HczyJtb
//
//  Created by lighthouse on 2019/9/10.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCNetworkError.h"

/**
 *  错误类型
 */
typedef NS_ENUM(NSInteger, HCNetworkErrorType){
    HCNetworkErrorDefault   = 0,
    HCNetworkErrorNoServer  = -1003,
    HCNetworkErrorTimeOut   = -1001,
    HCNetworkErrorNoNetwork = -1009
};

@implementation HCNetworkError

+ (HCNetworkError *)sharedNetworkError{
    static HCNetworkError *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!instance) {
            instance = [[self alloc] init];
        }
    });
    
    return instance;
}
/*
#pragma makr - 开始监听网络连接
- (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        self.currentNetStatus = status;
    }];
    
    [mgr startMonitoring];
}

- (BOOL)netWorkingStatus{
    BOOL    status;
    switch (self.currentNetStatus) {
        case AFNetworkReachabilityStatusUnknown: // 未知网络
            NSLog(@"未知网络");
            status = NO;
            break;
        case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            status = NO;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            NSLog(@"手机自带网络");
            status = YES;
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
            NSLog(@"WIFI");
            status = YES;
            break;
    }
    return status;
}
*/

+ (NSString *)errorWithCode:(NSInteger)errorCode
{
    NSString *err = nil;
    if (errorCode) {
        switch (errorCode) {
            case HCNetworkErrorDefault:
                return @"数据返回失败，请重试";
                break;
            case HCNetworkErrorTimeOut:
                return @"联网超时，请检查您的网络";
                break;
            case HCNetworkErrorNoServer:
                return @"网络不给力，请检查网络连接";
                break;
            case HCNetworkErrorNoNetwork:
                return @"网络不给力，请检查网络连接";
                break;
                
            default:
                return @"数据返回失败，请重试";
                break;
        }
    }
    
    return err;
}


@end
