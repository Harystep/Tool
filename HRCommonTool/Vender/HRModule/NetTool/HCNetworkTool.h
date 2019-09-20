//
//  HCNetworkTool.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestFinishedBlock)(id finishResult, NSURLSessionDataTask *requestTask);
typedef void(^RequestFailedBlock)(id failResult, NSURLSessionDataTask *requestTask);


@interface HCNetworkTool : NSObject

+ (instancetype)shareTool;

- (void)requestGetWithUrlStr:(NSString *)urlStr requestDict:(id)dict isLoad:(BOOL)flag completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock;

/**
 *   普通POST请求
 *
 *  @param urlStr      请求地址
 *  @param dict        请求参数
 *  @param finishBlock 成功回调
 *  @param failBlock   失败回调
 */
- (void)requestPostWithUrlStr:(NSString *)urlStr requestDict:(id)dict isLoad:(BOOL)flag completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock;

@end


