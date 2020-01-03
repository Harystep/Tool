//
//  SSWCharts.h
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/2.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SSWChartsType){
    SSWChartsTypePie,
    SSWChartsTypeLine,
    SSWChartsTypeBar
};

typedef NS_ENUM(NSInteger, HBChartsNumericalTransformationType) {
    
    HBChartsNumericalTransformationDefaultType      = 0,    // 按个计算
    HBChartsNumericalTransformationWanYuanType      = 1,    // 以万计算
    HBChartsNumericalTransformationYiYuanType       = 2,    // 以亿计算
};



@protocol SSWChartsDelegate;
@interface HBCharts : UIView
-(instancetype)initWithChartType:(SSWChartsType)type;
@property(nonatomic,assign)SSWChartsType        chartType;
@property(nonatomic,strong)NSArray              *percentageArr;//百分比数组 对应piechart
@property(nonatomic)NSArray                     *colorsArr;//颜色组数 对应piechart
@property(nonatomic)NSArray                     *titlesArr;//标题数组 对应piechart

@property(nonatomic)UILabel                     *bubbleLab;//点击时提示泡泡
@property(nonatomic,assign)BOOL                 showEachYValus;//是否显示每个Y值

// 向上取整 生成Y坐标值
- (NSInteger)generateMaxInterValue:(float)maxValue;

- (CGFloat)generateMaxInArray:(NSArray *)array;

- (NSString *)generateRealValueWithValue:(CGFloat)value length:(NSInteger)length;


@property(nonatomic,assign)id<SSWChartsDelegate>delegate;
-(CABasicAnimation *)animationWithDuration:(CFTimeInterval)duration;
@end
@protocol SSWChartsDelegate<NSObject>
//
@optional
-(void)SSWChartView:(HBCharts *)chartView didSelectIndex:(NSInteger)index;
//
-(void)SSWChartView:(HBCharts *)chartView didSelectMutipleBarChartIndex:(NSArray *)index;
@end
