//
//  HCConcernPartnerCell.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCConcernPartnerModel;

NS_ASSUME_NONNULL_BEGIN

@interface HCConcernPartnerCell : UITableViewCell

@property (strong, nonatomic) HCConcernPartnerModel *dataModel;

+ (instancetype)concernPartnerTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
