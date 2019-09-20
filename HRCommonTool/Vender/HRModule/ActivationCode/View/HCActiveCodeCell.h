//
//  HCActiveCodeCell.h
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCActiveCodeModel;

@protocol HCActiveCodeCellDelegate <NSObject>

- (void)copyNumOperateWithData:(NSString *)codeStr;

@end

@interface HCActiveCodeCell : UITableViewCell

@property (strong, nonatomic) HCActiveCodeModel *dataModel;

@property (weak, nonatomic) id<HCActiveCodeCellDelegate> delegate;

+ (instancetype)activeCodeTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end


