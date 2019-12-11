//
//  YHMySimpleModel.m
//  HRCommonTool
//
//  Created by pxsl on 2019/12/11.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "YHMySimpleModel.h"

@implementation YHMySimpleModel

+ (instancetype)simpleInfoWithDic:(NSDictionary *)dict{
    return [[self alloc] initWithDic:dict];
}

- (instancetype)initWithDic:(NSDictionary *)dict{
    if (self = [super init]) {
        self.isArrow = [dict[@"isArrow"] integerValue];
        self.title = dict[@"title"];
        self.iconStr = dict[@"iconStr"];
    }
    return self;
}

@end
