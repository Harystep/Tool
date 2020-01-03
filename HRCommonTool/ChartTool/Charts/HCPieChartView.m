//
//  HCPieChartView.m
//  HczyJtb
//
//  Created by lighthouse on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCPieChartView.h"
#import "HBPieChartView.h"
#import "HCMerchantInfoModel.h"

@interface HCPieChartView ()

@property (nonatomic, strong) HBPieChartView *pieView;

@end

@implementation HCPieChartView

- (void)start {
    [self.pieView start];
}

- (void)setup:(id<TemplateRenderProtocol>)model {
    
    HCMerchantBillsModel *billsModel = (HCMerchantBillsModel *)model;

    _pieView.colorsArr = @[HCColorHex(@"#F49064"),HCColorHex(@"#B6DD78"),HCColorHex(@"#54C2E8"),HCColorHex(@"#229AF4")];//颜色数组

    if ([billsModel.showType isEqualToString:@"1"]) {
        _pieView.percentageArr = nil;
        _pieView.percentageArr = [NSArray arrayWithArray:billsModel.piePriceAccountedrray];
    } else if ([billsModel.showType isEqualToString:@"2"]){
        _pieView.percentageArr = nil;
        _pieView.percentageArr = [NSArray arrayWithArray:billsModel.pieNumberAccountedrray];
    }
    
    [self.pieView start];
}

- (void)setupSubviews {
    [self addSubview:self.pieView];
}

- (void)setupSubviewsMasonry {
    [self.pieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (HBPieChartView *)pieView {
    if (!_pieView) {
        _pieView = [[HBPieChartView alloc]initWithChartType:SSWChartsTypePie];
        _pieView.radius = 60;
    }
    
    return _pieView;
}

- (NSArray *)colorArray {
    if (!_colorArray) {
        _colorArray = @[];
    }
    return _colorArray;
}

@end
