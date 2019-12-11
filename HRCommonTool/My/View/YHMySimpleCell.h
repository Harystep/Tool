//
//  YHMySimpleCell.h
//  HRCommonTool
//
//  Created by pxsl on 2019/12/11.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHMySimpleModel;

@interface YHMySimpleCell : UITableViewCell

@property (strong, nonatomic) YHMySimpleModel *dataModel;

+ (instancetype)mySimpleTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end


