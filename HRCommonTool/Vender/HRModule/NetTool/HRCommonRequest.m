 //
//  HRCommonRequest.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HRCommonRequest.h"

@implementation HRCommonRequest


+ (void)requestShopListInfoWithURL:(NSString *)url parmars:(NSDictionary *)parmars success:(HCRequestSuccess)success failure:(HCRequestFailure)failure {
    [self postOperateResponseDataToArrayWithURL:url parmars:parmars success:success failure:failure];
}

+ (void)requestCreateShopActiveCodeWithURL:(NSString *)url parmars:(NSDictionary *)parmars success:(HCRequestSuccess)success failure:(HCRequestFailure)failure {
    [self postOperateResponseDataToDictWithURL:url parmars:parmars success:success failure:failure];
}

+ (void)requesShopActiveCodeListWithURL:(NSString *)url parmars:(NSDictionary *)parmars success:(HCRequestSuccess)success failure:(HCRequestFailure)failure {

    [self getOperateResponseDataToArrayWithURL:url parmars:parmars success:success failure:failure];
}

/**
 Post请求数据处理

 @param url 请求URL
 @param parmars 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) postOperateResponseDataToArrayWithURL:(NSString *)url parmars:(NSDictionary *)parmars success:(HCRequestSuccess)success failure:(HCRequestFailure)failure {
    [self resetRequestSerializer:HCRequestSerializerTypeJSON];
    [self requestWithURL:url type:HCRequestTypePost parameters:parmars loading:NO success:^(id  _Nonnull response) {
        NSArray *dataArr = response[@"data"];
        if ([[HRNetworkTool shareTool] isCheckData:dataArr]) {
            if ([dataArr isKindOfClass:[NSArray class]]) {
                success(dataArr);
            } else {
                [[MBProgressController sharedInstance] showTipsOnlyText:kHCErrorMsg AndDelay:2.0];
            }
        } else {
            [[MBProgressController sharedInstance] showTipsOnlyText:kHCErrorMsg AndDelay:2.0];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

+ (void) postOperateResponseDataToDictWithURL:(NSString *)url parmars:(NSDictionary *)parmars success:(HCRequestSuccess)success failure:(HCRequestFailure)failure {
    [self resetRequestSerializer:HCRequestSerializerTypeJSON];
    [self requestWithURL:url type:HCRequestTypePost parameters:parmars loading:YES success:^(id  _Nonnull response) {
        NSDictionary *dataArr = response[@"data"];
        if ([[HRNetworkTool shareTool] isCheckData:dataArr]) {
            if ([dataArr isKindOfClass:[NSDictionary class]]) {
                success(dataArr);
            } else {
                [[MBProgressController sharedInstance] showTipsOnlyText:kHCErrorMsg AndDelay:2.0];
            }
        } else {
            [[MBProgressController sharedInstance] showTipsOnlyText:kHCErrorMsg AndDelay:2.0];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

+ (void) getOperateResponseDataToArrayWithURL:(NSString *)url parmars:(NSDictionary *)parmars success:(HCRequestSuccess)success failure:(HCRequestFailure)failure {
    [self requestWithURL:url type:HCRequestTypeGet parameters:parmars loading:NO success:^(id  _Nonnull response) {
        NSArray *dataArr = response[@"data"];
        if ([[HRNetworkTool shareTool] isCheckData:dataArr]) {
            if ([dataArr isKindOfClass:[NSArray class]]) {
                success(dataArr);
            } else {
                [[MBProgressController sharedInstance] showTipsOnlyText:kHCErrorMsg AndDelay:2.0];
            }
        } else {
            [[MBProgressController sharedInstance] showTipsOnlyText:kHCErrorMsg AndDelay:2.0];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

+ (void) getOperateResponseDataToDictWithURL:(NSString *)url parmars:(NSDictionary *)parmars success:(HCRequestSuccess)success failure:(HCRequestFailure)failure {
    [self requestWithURL:url type:HCRequestTypeGet parameters:parmars loading:NO success:^(id  _Nonnull response) {
        NSDictionary *dataArr = response[@"data"];
        if ([[HRNetworkTool shareTool] isCheckData:dataArr]) {
            if ([dataArr isKindOfClass:[NSDictionary class]]) {
                success(dataArr);
            } else {
                [[MBProgressController sharedInstance] showTipsOnlyText:kHCErrorMsg AndDelay:2.0];
            }
        } else {
            [[MBProgressController sharedInstance] showTipsOnlyText:kHCErrorMsg AndDelay:2.0];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
