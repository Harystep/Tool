//
//  HCConcernPartnerModel.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HCConcernPartnerModel : NSObject

@property (copy, nonatomic) NSString *partnerId;

@property (copy, nonatomic) NSString *created_at;

@property (assign, nonatomic) NSInteger bind_num;

@property (assign, nonatomic) NSInteger user_store;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *logo;

+ (instancetype)concernPartnerInfoWithDic:(NSDictionary *)dict;

- (instancetype)initWithDic:(NSDictionary *)dict;

@end


