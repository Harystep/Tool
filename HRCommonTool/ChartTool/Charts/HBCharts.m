//
//  SSWCharts.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/2.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "HBCharts.h"

@implementation HBCharts
-(instancetype)initWithChartType:(SSWChartsType)type{
    self = [super init];
    if (self) {
        self.chartType = type;
    }
    return self;
}
-(UILabel *)bubbleLab{
    if (!_bubbleLab) {
        _bubbleLab = [[UILabel  alloc]init];
        _bubbleLab.bounds = CGRectMake(0, 0, 60, 20);
        _bubbleLab.textAlignment = NSTextAlignmentCenter;
        _bubbleLab.textColor = [UIColor whiteColor];
        _bubbleLab.hidden=YES;
        _bubbleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    }
    return _bubbleLab;
}
//添加动画
-(CABasicAnimation *)animationWithDuration:(CFTimeInterval)duration{
    CABasicAnimation  *anmiation = [CABasicAnimation  animationWithKeyPath:@"strokeEnd"];
    anmiation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmiation.duration =duration;
    anmiation.fromValue=@(0);
    anmiation.toValue = @(1);
    return anmiation;
}


- (NSInteger )generateMaxInterValue:(float)maxValue {
    if (maxValue<0) {
        maxValue = ABS(maxValue); //负数取绝对值
    }
    NSInteger maxInt = 0;
    NSString *maxValueStr = [NSString stringWithFormat:@"%f",maxValue]; //先转成字符串
    if ([maxValueStr containsString:@"."]) {
        NSArray *strArray = [maxValueStr componentsSeparatedByString:@"."];
        NSString *firstStr = [strArray firstObject];
        if (firstStr.length>1) { // 大于10的数值
            NSString *subStr = [maxValueStr substringWithRange:NSMakeRange(0, 2)];
            NSInteger subInt = subStr.intValue;
            maxInt = (subInt / 5 * 5 + 5) * pow(10, firstStr.length - 2);
        }else { //小于10的数值
            maxInt = (firstStr.integerValue / 5 * 5 + 5);
        }
    }
    return maxInt;
}


- (NSString *)generateRealValueWithValue:(CGFloat)value length:(NSInteger)length {
    NSString *realValue = @"";
    if (length == 1) {
        if (value >= 10000 && value < 100000000) {
            realValue = [NSString stringWithFormat:@"%.1f万",value / 10000.0f];
        } else if (value >= 100000000) {
            realValue = [NSString stringWithFormat:@"%.1f亿",value / 100000000.0f];
        } else {
            realValue = [NSString stringWithFormat:@"%.0f",value];
        }
    } else if (length == 2) {
        if (value >= 10000 && value < 100000000) {
            realValue = [NSString stringWithFormat:@"%.2f万",value / 10000.0f];
        } else if (value >= 100000000) {
            realValue = [NSString stringWithFormat:@"%.2f亿",value / 100000000.0f];
        } else {
            realValue = [NSString stringWithFormat:@"%.2f",value];
        }
    }
    
    
    return realValue;
}

@end
