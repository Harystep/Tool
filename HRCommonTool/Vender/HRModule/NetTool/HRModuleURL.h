//
//  HRModuleURL.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/10.
//  Copyright © 2019 apple. All rights reserved.
//

#ifndef HRModuleURL_h
#define HRModuleURL_h

#define kHRHOST [[NSUserDefaults standardUserDefaults] objectForKey:@"SetdeveloperOrTest"]

#define kHCErrorMsg @"数据返回失败，请重试"

#define kMinDateTypeKey @"2016-01-01 00:00:00"

//获取关注商户/合伙人列表
#define kGetConcernTypeURL @"focus/getData"
//商户收益
#define kGetBusinessProfitURL @"partner/storeProfitList"
//合伙人收益
#define kGetPartnerProfitURL @"partner/userProfitList"
//商户预警列表
#define kGetBusinessWarningURL @"storeWarning/warningList"
//获取用户信息
#define kGetUserInfo @"user/me"
//获取合伙人统计信息
#define kGetPartnerCollectInfo @"dashboard/getParents"
//获取进件/收益/交易信息
#define kGetHomeMostInfo @"dashboard/userHomeCount"
//合伙人收益总览-提现余额收益总额
#define kGetProfitTotalInfo @"partner/totalProfit"
//合伙人收益 列表及曲线图数据（筛选）
#define kGetProfitScreenInfo @"partner/profitList"

//待处理合伙人列表
#define kGetProcessPartnerList @"partner/juniorList"
//获取门店信息
#define kGetShopListInfo @"agent/storeList"
//获取店铺激活码列表 store_id
#define kGetShopActiveCodeList @"storeActiveCode/codeList"
//生成激活码 store_id
#define kCreateActiveCode @"storeActiveCode/generate"


#endif /* HRModuleURL_h */
