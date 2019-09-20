//
//  HCConcernPartnerCell.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCConcernPartnerCell.h"
#import "HCConcernPartnerModel.h"

@interface HCConcernPartnerCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconIv;
@property (weak, nonatomic) IBOutlet UILabel *partnerNameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIImageView *iconRoowIv;

@property (weak, nonatomic) IBOutlet UILabel *businessTotalNumL;
@property (weak, nonatomic) IBOutlet UILabel *bindNumL;

@end

@implementation HCConcernPartnerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.iconIv setCornerRadius:30];
    [self.partnerNameL setFontBold:16];
}

+ (instancetype)concernPartnerTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    HCConcernPartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HCConcernPartnerCell" forIndexPath:indexPath];
    return cell;
}

- (void)setDataModel:(HCConcernPartnerModel *)dataModel {
    _dataModel = dataModel;
    [self.iconIv sd_setImageWithURL:[NSURL URLWithString:[[HRNetworkTool shareTool] conversionStringWithContent:dataModel.logo]] placeholderImage:kImageName(@"icon_logoJT")];
    self.partnerNameL.text = dataModel.name;
    self.timeL.text = [NSString stringWithFormat:@"关注时间 %@", dataModel.created_at];
    self.businessTotalNumL.text = [NSString stringWithFormat:@"%ld", dataModel.user_store];
    self.bindNumL.text = [NSString stringWithFormat:@"%ld", dataModel.bind_num];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
