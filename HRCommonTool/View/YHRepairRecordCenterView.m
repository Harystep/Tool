

#import "YHRepairRecordCenterView.h"

@implementation YHRepairRecordCenterView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconIv.image = [UIImage imageNamed:@"repair_record"];
    self.repairNumTitelL.text = @"巡查记录单号:";
    self.repairTypeTitleL.text = @"维修类型:";
    self.conpanyTitleL.text = @"填报单位:";
    self.chargePersonTitleL.text = @"负责人:";
    self.totalPersonTitelL.text = @"统计人:";
}


@end
