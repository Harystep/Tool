/**
 "store_id": "2018120816590924627",
 "store_name": "胡品测试企业门店",
 "people_phone": "18571831373",
 "store_address": "群光",
 "last_pay_time": ""
 */

#import "HCMarchantLossModel.h"

@implementation HCMarchantLossModel

+ (instancetype)marchantLossInfoWithDic:(NSDictionary *)dict{
    return [[self alloc] initWithDic:dict];
}

- (instancetype)initWithDic:(NSDictionary *)dict{
    if (self = [super init]) {
        self.store_id = dict[@"store_id"];
        self.store_name = dict[@"store_name"];
        self.people_phone = dict[@"people_phone"];
        self.store_address = dict[@"store_address"];
        self.last_pay_time = dict[@"last_pay_time"];
    }
    return self;
}

@end
