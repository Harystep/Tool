/*
 "id": 32,
 "store_id": "2018102410423064627",
 "secret_key":"12313213"
*/


#import <Foundation/Foundation.h>


@interface HCActiveCodeModel : NSObject

@property (copy, nonatomic) NSString *secret_key;

@property (copy, nonatomic) NSString *store_id;

+ (instancetype)activeCodeInfoWithDic:(NSDictionary *)dict;

- (instancetype)initWithDic:(NSDictionary *)dict;

@end


