//
//  HCMarchantLossCell.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCMarchantLossModel;

NS_ASSUME_NONNULL_BEGIN

@interface HCMarchantLossCell : UITableViewCell

/**商店电话*/
@property (weak, nonatomic) IBOutlet UILabel *phoneL;

@property (strong, nonatomic) HCMarchantLossModel *dataModel;

+ (instancetype)marchantLossTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
