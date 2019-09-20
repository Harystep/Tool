//
//  HCConcernPartnerModel.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCConcernPartnerModel.h"

@implementation HCConcernPartnerModel

+ (instancetype)concernPartnerInfoWithDic:(NSDictionary *)dict{
    return [[self alloc] initWithDic:dict];
}

- (instancetype)initWithDic:(NSDictionary *)dict{
    if (self = [super init]) {
        self.logo = dict[@"logo"];
        self.name = dict[@"name"];
        self.created_at = dict[@"created_at"];
        self.bind_num = [dict[@"bind_num"] integerValue];
        self.user_store = [dict[@"user_store"] integerValue];
        self.partnerId = dict[@"target_id"];
    }
    return self;
}

@end
