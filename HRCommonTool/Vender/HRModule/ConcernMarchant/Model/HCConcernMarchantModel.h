/**
 "created_at" = "2019-08-09";
 id = 1;
 "order_amount" = 0;
 "order_num" = 0;
 "store_logo" = "https://isv.hczypay.com/upload/picture/2018/12/10/140841_103.jpg";
 "store_name" = "邳州市玫之源日用品经营部";
 "store_short_name" = "梅记煎饼";
 "target_id" = 2018071116581755765;
 type = 2;
 "updated_at" = "2019-08-09 15:15:57";
 "user_id" = 1;
 */

#import <Foundation/Foundation.h>

@interface HCConcernMarchantModel : NSObject

@property (copy, nonatomic) NSString *marchantId;

@property (copy, nonatomic) NSString *created_at;

@property (assign, nonatomic) NSInteger order_num;

@property (assign, nonatomic) double order_amount;

@property (copy, nonatomic) NSString *store_name;

@property (copy, nonatomic) NSString *store_short_name;

@property (copy, nonatomic) NSString *store_logo;

+ (instancetype)concernMarchantInfoWithDic:(NSDictionary *)dict;

- (instancetype)initWithDic:(NSDictionary *)dict;

@end


