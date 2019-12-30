//
//  HCNetworkError.h
//  HczyJtb
//
//  Created by lighthouse on 2019/9/10.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFNetworkReachabilityManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HCNetworkError : NSObject

/**
 *  获取当前的网络状态 该变量有四个type
 AFNetworkReachabilityStatusUnknown: // 未知网络
 AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
 AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
 AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
 */

//@property(nonatomic, assign)AFNetworkReachabilityStatus currentNetStatus;

/**
 *  类单例函数
 *
 *  @return 单例实例对象
 */
+ (HCNetworkError *)sharedNetworkError;

/**
 *  获取当前网络的状态，主要是看是否有网络。
 *
 *  @return 返回值 YES 说明当前网络可用， NO 说明当前网络不可用
 */
//- (BOOL)netWorkingStatus;

/**
 *  启动网络状态监测的接口函数
 */
//- (void)startMonitoring;

/**
 根据错误码获取错误提示文本

 @param errorCode 错误编码
 @return 错误编码提示文本
 */
+ (NSString *)errorWithCode:(NSInteger)errorCode;


@end

NS_ASSUME_NONNULL_END
