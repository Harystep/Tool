//
//  HCConcernMarchantCell.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCConcernMarchantModel;



@interface HCConcernMarchantCell : UITableViewCell

@property (strong, nonatomic) HCConcernMarchantModel *dataModel;

+ (instancetype)concernMarchantTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


@end


