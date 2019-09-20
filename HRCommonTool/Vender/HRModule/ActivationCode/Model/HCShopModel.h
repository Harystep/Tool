//
//  HCShopModel.h
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCShopModel : NSObject

@property (copy, nonatomic) NSString *store_id;

@property (copy, nonatomic) NSString *store_name;

+ (instancetype)shopInfoWithDic:(NSDictionary *)dict;

- (instancetype)initWithDic:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
