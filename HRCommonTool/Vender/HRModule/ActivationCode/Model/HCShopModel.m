//
//  HCShopModel.m
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCShopModel.h"

@implementation HCShopModel

+ (instancetype)shopInfoWithDic:(NSDictionary *)dict{
    return [[self alloc] initWithDic:dict];
}

- (instancetype)initWithDic:(NSDictionary *)dict{
    if (self = [super init]) {
        self.store_id = dict[@"store_id"];
        self.store_name = dict[@"store_name"];
    }
    return self;
}

@end
