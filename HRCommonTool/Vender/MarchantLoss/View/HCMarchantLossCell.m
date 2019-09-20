//
//  HCMarchantLossCell.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCMarchantLossCell.h"
#import "HCMarchantLossModel.h"

@interface HCMarchantLossCell ()
/**商店名称*/
@property (weak, nonatomic) IBOutlet UILabel *shopNameL;
/**时间*/
@property (weak, nonatomic) IBOutlet UILabel *timeL;
/**商店地址*/
@property (weak, nonatomic) IBOutlet UILabel *addressL;


@property (weak, nonatomic) IBOutlet UIImageView *addrIv;

@end

@implementation HCMarchantLossCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.shopNameL setFontBold:16];
}

+(instancetype)marchantLossTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    HCMarchantLossCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HCMarchantLossCell" forIndexPath:indexPath];
    return cell;
}

- (void)setDataModel:(HCMarchantLossModel *)dataModel {
    _dataModel = dataModel;
    self.shopNameL.text = [[HRNetworkTool shareTool] conversionStringWithContent:dataModel.store_name];
    self.timeL.text = [[HRNetworkTool shareTool] conversionStringWithContent:dataModel.last_pay_time];
    self.addressL.text = [[HRNetworkTool shareTool] conversionStringWithContent:dataModel.store_address];
    self.phoneL.text = [[HRNetworkTool shareTool] conversionStringWithContent:dataModel.people_phone];
//    self.phoneL.text = @"18800000000";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
