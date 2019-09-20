//
//  HCUserDefaultsManager.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCUserDefaultsManager : NSObject

+ (instancetype)shareUserManager;

- (NSString *)userObjWithKey:(NSString *)key;
- (BOOL)userBoolWithKey:(NSString *)key;
- (void)setUserValue:(NSString *)value withKey:(NSString *)key;
- (void)setUserBool:(BOOL)value withKey:(NSString *)key;
- (void)setUserDictValue:(NSDictionary *)dict with:(NSString *)key;
- (NSDictionary *)userDictObjWithKey:(NSString *)key;

- (void)setUserArrayValue:(NSArray *)array with:(NSString *)key;
- (NSDictionary *)userArrayObjWithKey:(NSString *)key;
//保存首页商户进件/交易详情/收益
- (void)setUserInputDictValue:(NSDictionary *)dataDic;
- (NSDictionary *)userInputDictObj;

//合伙人统计
- (void)setPartnerDictValue:(NSDictionary *)dict;
- (NSDictionary *)userPartnerDictObj;

@end

NS_ASSUME_NONNULL_END
