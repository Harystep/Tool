//
//  HCConcernMarchantCell.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCConcernMarchantCell.h"
#import "HCConcernMarchantModel.h"

@interface HCConcernMarchantCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconIv;
@property (weak, nonatomic) IBOutlet UILabel *busiNameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIImageView *iconRoowIv;

@property (weak, nonatomic) IBOutlet UILabel *transNumL;
@property (weak, nonatomic) IBOutlet UILabel *transMoneyL;

@end

@implementation HCConcernMarchantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.iconIv setCornerRadius:5];
    [self.busiNameL setFontBold:16];
}

+ (instancetype)concernMarchantTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    HCConcernMarchantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HCConcernMarchantCell" forIndexPath:indexPath];
    return cell;
}

- (void)setDataModel:(HCConcernMarchantModel *)dataModel {
    _dataModel = dataModel;
    [self.iconIv sd_setImageWithURL:[NSURL URLWithString:[[HRNetworkTool shareTool] conversionStringWithContent:dataModel.store_logo]] placeholderImage:kImageName(@"icon-v5_marchant_defaultIv")];
    self.busiNameL.text = dataModel.store_short_name;
    self.timeL.text = [NSString stringWithFormat:@"关注时间 %@", dataModel.created_at];
    self.transNumL.text = [NSString stringWithFormat:@"%ld", dataModel.order_num];
    self.transMoneyL.text = [NSString stringWithFormat:@"%.2f", dataModel.order_amount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
