//
//  HCNetworkTool.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCNetworkTool.h"

static HCNetworkTool *requestTool;

@interface HCNetworkTool()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation HCNetworkTool

+ (instancetype)shareTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTool == nil) {
            requestTool = [[HCNetworkTool alloc] init];
        }
    });
    return requestTool;
}

- (AFHTTPSessionManager *)setConfigureNetworkInfo {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager.requestSerializer setTimeoutInterval:15.0];
    
    return manager;
}

//正常的POST请求
- (void)requestPostWithUrlStr:(NSString *)urlStr requestDict:(id)dict isLoad:(BOOL)flag completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock{
    
    self.manager = [self setConfigureNetworkInfo];
    
    if (flag) {
        [[HRProgressView shareProressView] show];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@?system=ios&channel=appstore&sysver=%@&appver=%@&mrf=%@&res=%@&did=%@",urlStr,[WorkToolClass GetDefaultphoneVersion],Version_Num,[WorkToolClass GetDefaultphonePlatform],[WorkToolClass GetphoneWidthHei],[WorkToolClass GetiphoneDeviceUUIDStr]];
    [self.manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[HRProgressView shareProressView] dismiss];
        finishBlock([self handleDate:responseObject], task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[HRProgressView shareProressView] dismiss];
        failBlock(error, task);
        [[MBProgressController sharedInstance] showTipsOnlyText:@"请检查您的网络设置" AndDelay:2.5];
    }];
}


- (void)requestGetWithUrlStr:(NSString *)urlStr requestDict:(id)dict isLoad:(BOOL)flag completeBlock:(RequestFinishedBlock)finishBlock failBlock:(RequestFailedBlock)failBlock {
    
    self.manager = [self setConfigureNetworkInfo];
    
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if (flag) {
        [[HRProgressView shareProressView] show];
    }
    NSString *url = [NSString stringWithFormat:@"%@?system=ios&channel=appstore&sysver=%@&appver=%@&mrf=%@&res=%@&did=%@",urlStr,[WorkToolClass GetDefaultphoneVersion],Version_Num,[WorkToolClass GetDefaultphonePlatform],[WorkToolClass GetphoneWidthHei],[WorkToolClass GetiphoneDeviceUUIDStr]];
    [self.manager GET:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[HRProgressView shareProressView] dismiss];
        finishBlock([self handleDate:responseObject], task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[HRProgressView shareProressView] dismiss];
        failBlock(error, task);
        [[MBProgressController sharedInstance] showTipsOnlyText:@"请检查您的网络设置" AndDelay:2.5];
    }];
    
}

- (id)handleDate:(id)responseObject{
    if ([[HRNetworkTool shareTool] isCheckData:responseObject]) {
        if ([responseObject[@"status"] integerValue] == 1) {
            return responseObject;
        } else if ([responseObject[@"status"] integerValue] == 0) {
            return responseObject;
        }
        else {
            return nil;
        }
    } else {
        [[MBProgressController sharedInstance] showTipsOnlyText:@"服务器发生异常,请稍后··" AndDelay:2.5];
        return nil;
    }
}

@end
