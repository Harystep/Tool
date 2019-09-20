//
//  HRCommonRequest.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCRequest.h"



@interface HRCommonRequest : HCRequest

/**
 请求门店列表信息
 
 @param url 请求URL
 @param parmars 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestShopListInfoWithURL:(NSString *)url parmars:(NSDictionary *)parmars success:(HCRequestSuccess)success failure:(HCRequestFailure)failure;
/**
 生成门店激活码
 
 @param url 请求URL
 @param parmars 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestCreateShopActiveCodeWithURL:(NSString *)url parmars:(NSDictionary *)parmars success:(HCRequestSuccess)success failure:(HCRequestFailure)failure;

/**
 获取门店激活码列表
 
 @param url 请求URL
 @param parmars 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requesShopActiveCodeListWithURL:(NSString *)url parmars:(NSDictionary *)parmars success:(HCRequestSuccess)success failure:(HCRequestFailure)failure;

@end


