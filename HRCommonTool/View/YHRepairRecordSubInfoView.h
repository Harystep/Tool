//
//  YHRepairRecordSubInfoView.h
//  HRCommonTool
//
//  Created by pxsl on 2019/10/9.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHRepairRecordSubInfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *hurtNameTitleL;

@property (weak, nonatomic) IBOutlet UILabel *hurtNameL;

@property (weak, nonatomic) IBOutlet UILabel *hurtPalceTitleL;
@property (weak, nonatomic) IBOutlet UILabel *hurtPalceL;

@property (weak, nonatomic) IBOutlet UILabel *hurtNumTitleL;
@property (weak, nonatomic) IBOutlet UILabel *hurtNumL;

@property (weak, nonatomic) IBOutlet UILabel *totleCompanyTitleL;
@property (weak, nonatomic) IBOutlet UILabel *totleCompanyL;

@property (weak, nonatomic) IBOutlet UILabel *reprotTimeTitelL;
@property (weak, nonatomic) IBOutlet UILabel *reprotTimeL;

@end

NS_ASSUME_NONNULL_END
