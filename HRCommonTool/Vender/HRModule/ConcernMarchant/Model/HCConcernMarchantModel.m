//
//  HCConcernMarchantModel.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCConcernMarchantModel.h"

@implementation HCConcernMarchantModel

+ (instancetype)concernMarchantInfoWithDic:(NSDictionary *)dict{
    return [[self alloc] initWithDic:dict];
}

- (instancetype)initWithDic:(NSDictionary *)dict{
    if (self = [super init]) {
        self.store_logo = dict[@"store_logo"];
        self.store_name = dict[@"store_name"];
        self.store_short_name = dict[@"store_short_name"];
        self.created_at = dict[@"created_at"];
        self.order_amount = [dict[@"order_amount"] doubleValue];
        self.order_num = [dict[@"order_num"] integerValue];
        self.marchantId = dict[@"target_id"];
    }
    return self;
}

@end
