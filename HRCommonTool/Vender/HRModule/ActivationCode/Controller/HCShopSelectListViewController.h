//
//  HCShopSelectListViewController.h
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCShopModel;

@protocol HCShopSelectListViewControllerDelegate <NSObject>

- (void)sureSelectShopModel:(HCShopModel *_Nonnull)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HCShopSelectListViewController : HRBaseViewController

@property (copy, nonatomic) NSString *store_id;

@property (weak, nonatomic) id<HCShopSelectListViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
