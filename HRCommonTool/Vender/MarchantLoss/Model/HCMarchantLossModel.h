/**
 "store_id": "2018120816590924627",
 "store_name": "胡品测试企业门店",
 "people_phone": "18571831373",
 "store_address": "群光",
 "last_pay_time": ""
 */

#import <Foundation/Foundation.h>

@interface HCMarchantLossModel : NSObject

@property (copy, nonatomic) NSString *store_id;

@property (copy, nonatomic) NSString *store_name;

@property (copy, nonatomic) NSString *people_phone;

@property (copy, nonatomic) NSString *store_address;

@property (copy, nonatomic) NSString *last_pay_time;

+ (instancetype)marchantLossInfoWithDic:(NSDictionary *)dict;

- (instancetype)initWithDic:(NSDictionary *)dict;


@end


