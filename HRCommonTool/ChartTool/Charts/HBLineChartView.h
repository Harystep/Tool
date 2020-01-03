//
//  SSWLineChartView.h
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/3.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "HBCharts.h"

@interface HBLineChartView : HBCharts
@property(nonatomic)NSMutableArray      *xValuesArr;//x轴的值数组
@property(nonatomic)NSMutableArray      *yValuesArr;//y轴的值数组
@property (nonatomic, strong) NSMutableArray *yAxisScaleValueAraay; // Y轴刻度值
@property(nonatomic,assign)CGFloat      barWidth;//x轴刻度占据的宽度
@property(nonatomic,assign)CGFloat      gapWidth;//间隔宽度
@property(nonatomic,assign)CGFloat      yScaleValue;//y轴的刻度值
@property(nonatomic,assign)int          yAxisCount;//y轴刻度的个数
@property(nonatomic,copy)NSString       *unit;//单位
@property(nonatomic)UIColor             *lineColor;//设置线的颜色
@property (nonatomic, copy) NSString    *xValueUnit;
@property (nonatomic, copy) NSString    *xUnit;
@property (nonatomic, assign) BOOL      isDisplayFront;

- (void)start;

@end
