//
//  YHRepairRecordSubInfoView.m
//  HRCommonTool
//
//  Created by pxsl on 2019/10/9.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "YHRepairRecordSubInfoView.h"

@implementation YHRepairRecordSubInfoView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.hurtNameTitleL.text = @"病害名称:";
    self.hurtPalceTitleL.text = @"病害位置:";
    self.hurtNumTitleL.text = @"病害数量:";
    self.totleCompanyTitleL.text = @"计量单位:";
    self.reprotTimeTitelL.text = @"上报时间:";
}

@end
