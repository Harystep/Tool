//
//  HCShopSelectDownView.h
//  HczyJtb
//
//  Created by pxsl on 2019/9/11.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCShopModel;

@protocol HCShopSelectDownViewDelegate <NSObject>

- (void)shopDownViewSelectIndexPath:(HCShopModel *)model;

@end

@interface HCShopSelectDownView : UIView

@property (weak, nonatomic) id<HCShopSelectDownViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withStoreID:(NSString *)storeID;

@end


