//
//  HCShopCell.h
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCShopModel;

@protocol HCShopCellDelegate <NSObject>

- (void)shopCellSelectData:(HCShopModel *)model;

@end


@interface HCShopCell : UITableViewCell
/** 标记由激活码列表界面进入 */
@property (assign, nonatomic) BOOL downFlag;
/** 被选中的ID */
@property (copy, nonatomic) NSString *storeID;

@property (strong, nonatomic) HCShopModel *dataModel;

@property (weak, nonatomic) id<HCShopCellDelegate> delegate;

+ (instancetype)shopTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


@end

