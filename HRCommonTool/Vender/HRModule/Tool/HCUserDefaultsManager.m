//
//  HCUserDefaultsManager.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCUserDefaultsManager.h"

static HCUserDefaultsManager *userManager;

@implementation HCUserDefaultsManager

+ (instancetype)shareUserManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (userManager == nil) {
            userManager = [[HCUserDefaultsManager alloc] init];
        }
    });
    return userManager;
}

- (NSString *)userObjWithKey:(NSString *)key{
    if (key != nil) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    } else{
        return nil;
    }
}
- (BOOL)userBoolWithKey:(NSString *)key {
    if (key != nil) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:key];
    } else{
        return NO;
    }
}
- (void)setUserValue:(NSString *)value withKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
}
- (void)setUserBool:(BOOL)value withKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

- (void)setUserDictValue:(NSDictionary *)dict with:(NSString *)key {
    NSDictionary *dic = [[HRNetworkTool shareTool] convertSafeDictWithDic:dict];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:key];
}

- (NSDictionary *)userDictObjWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)setUserInputDictValue:(NSDictionary *)dataDic{
   
     NSString *todayNum = [NSString stringWithFormat:@"%tu", [dataDic[@"today_order_num"] integerValue]];
     NSString *todayMoney = [[HRNetworkTool shareTool] ruleMoneyType:dataDic[@"total_profit"]];
     NSString *yestodayNum = [NSString stringWithFormat:@"%tu", [dataDic[@"yesterday_order_num"] integerValue]];
     NSString *yestodayMoney = [[HRNetworkTool shareTool] ruleMoneyType:dataDic[@"yesterday_order_money"]];
     NSString *monthNum = [NSString stringWithFormat:@"%tu", [dataDic[@"month_order_num"] integerValue]];
     NSString *monthMoney = [[HRNetworkTool shareTool] ruleMoneyType:dataDic[@"month_order_money"]];
     NSString *yearNum = [NSString stringWithFormat:@"%tu", [dataDic[@"year_order_num"] integerValue]];
     NSString *yearMoney = [[HRNetworkTool shareTool] ruleMoneyType:dataDic[@"year_order_money"]];
     NSString *profitMoney = [NSString stringWithFormat:@"¥%@", [[HRNetworkTool shareTool] ruleMoneyType: dataDic[@"total_profit"]]];
     NSString *businessProfit = [[HRNetworkTool shareTool] ruleMoneyType:dataDic[@"merchant_profit"]] ;
     NSString *partnerProfit = [[HRNetworkTool shareTool] ruleMoneyType:dataDic[@"user_profit"]];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setObject:todayNum forKey:@"today_order_num"];
    [dictM setObject:todayMoney forKey:@"total_profit"];
    [dictM setObject:yestodayNum forKey:@"yesterday_order_num"];
    [dictM setObject:yestodayMoney forKey:@"yesterday_order_money"];
    [dictM setObject:monthNum forKey:@"month_order_num"];
    [dictM setObject:monthMoney forKey:@"month_order_money"];
    [dictM setObject:yearNum forKey:@"year_order_num"];
    [dictM setObject:yearMoney forKey:@"year_order_money"];
    [dictM setObject:profitMoney forKey:@"total_profit"];
    [dictM setObject:businessProfit forKey:@"merchant_profit"];
    [dictM setObject:partnerProfit forKey:@"user_profit"];
    NSDictionary *inunitDic = dataDic[@"inunit"];
    NSMutableDictionary *inputM = [NSMutableDictionary dictionary];
    if ([[HRNetworkTool shareTool] isCheckData:inunitDic]) {
        NSDictionary *allDic = inunitDic[@"all"];
        NSDictionary *failDic = inunitDic[@"fail"];
        NSDictionary *processDic = inunitDic[@"auditing"];
        NSDictionary *passDic = inunitDic[@"pass"];
        if ([[HRNetworkTool shareTool] isCheckData:allDic]) {
            [inputM setObject:[[HRNetworkTool shareTool] convertSafeDictWithDic:allDic] forKey:@"all"];
        }
        if ([[HRNetworkTool shareTool] isCheckData:failDic]) {
            [inputM setObject:[[HRNetworkTool shareTool] convertSafeDictWithDic:failDic] forKey:@"fail"];
        }
        if ([[HRNetworkTool shareTool] isCheckData:processDic]) {
            [inputM setObject:[[HRNetworkTool shareTool] convertSafeDictWithDic:processDic] forKey:@"auditing"];
        }
        if ([[HRNetworkTool shareTool] isCheckData:passDic]) {
            [inputM setObject:[[HRNetworkTool shareTool] convertSafeDictWithDic:passDic] forKey:@"pass"];
        }
        [dictM setObject:inputM forKey:@"inunit"];
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:dictM forKey:[kUserInputKey stringByAppendingString:[DefaultStandard objectForKey:kUserPhoneKey]]];
}

- (NSDictionary *)userInputDictObj;{
    return [[NSUserDefaults standardUserDefaults] objectForKey:[kUserInputKey stringByAppendingString:[DefaultStandard objectForKey:kUserPhoneKey]]];
}

- (void)setPartnerDictValue:(NSDictionary *)dict{
    NSDictionary *dic = [[HRNetworkTool shareTool] convertSafeDictWithDic:dict];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:[kUserPartnerKey stringByAppendingString:[DefaultStandard objectForKey:kUserPhoneKey]]];
}

- (NSDictionary *)userPartnerDictObj{
    return [[NSUserDefaults standardUserDefaults] objectForKey:[kUserPartnerKey stringByAppendingString:[DefaultStandard objectForKey:kUserPhoneKey]]];
}


@end
