//
//  HCActiveCodeModel.m
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCActiveCodeModel.h"

@implementation HCActiveCodeModel

+ (instancetype)activeCodeInfoWithDic:(NSDictionary *)dict{
    return [[self alloc] initWithDic:dict];
}

- (instancetype)initWithDic:(NSDictionary *)dict{
    if (self = [super init]) {
        self.secret_key = dict[@"secret_key"];
        self.store_id = dict[@"store_id"];
    }
    return self;
}

@end
