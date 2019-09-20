//
//  HCProfitChartLineView.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBCharts.h"


@interface HCProfitChartLineView : HBCharts

@property(nonatomic)NSMutableArray      *xValuesArr;//x轴的值数组
@property(nonatomic)NSMutableArray      *yValuesArr;//y轴的值数组
@property(nonatomic,assign)CGFloat      barWidth;//x轴刻度占据的宽度
@property(nonatomic,assign)CGFloat      gapWidth;//间隔宽度
@property(nonatomic,assign)CGFloat      yScaleValue;//y轴的刻度值
@property(nonatomic,assign)int          yAxisCount;//y轴刻度的个数
//@property(nonatomic,copy)NSString       *unit;//单位
@property(nonatomic)UIColor             *lineColor;//设置线的颜色
@property (copy, nonatomic) NSString *status;//年 月 日

@property (assign, nonatomic) kCompanyType companyType;

@end


