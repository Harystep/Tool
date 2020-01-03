//
//  SSWBarChartView.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/3.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "HBBarChartView.h"

#define kChatYWidth 45

@interface HBBarChartView (){
     CGFloat   _totalWidth;
     CGFloat   _totalHeight;
    CAShapeLayer  *_lineLayer;//刻度layer;
    CAShapeLayer  *_lineXLayer;//刻度layer;
}
@property(nonatomic)UIScrollView        *scrollView;
@property(nonatomic)UIView              *contentView;
@property(nonatomic)NSMutableArray      *barsStartPointsArr;
@property(nonatomic)NSMutableArray      *barsEndPointsArr;
@property(nonatomic)NSMutableArray      *barsLayersArr;
@property(nonatomic)UILabel             *unitLab;
@end
@implementation HBBarChartView
-(instancetype)initWithChartType:(SSWChartsType)type{
    self = [super initWithChartType:type];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void) start {
    [self clear];
    [self setUp];
}

-(void)setUp{
    [self.contentView addSubview:self.bubbleLab];
    self.xValuesArr = [@[] mutableCopy];
    self.yValuesArr = [@[] mutableCopy];
    self.barsStartPointsArr  = [@[] mutableCopy];
    self.barsEndPointsArr = [@[] mutableCopy];
    self.barsLayersArr = [@[] mutableCopy];
    self.barWidth = 20;
    self.gapWidth = 20;
    self.yScaleValue = 50;
    self.yAxisCount = 10;
    self.showEachYValus=YES;
    self.xValueUnit = @"";
    self.xUnit = @"";
    self.isDisplayFront = NO;
    self.barCorlor = [UIColor colorWithRed:246 green:179 blue:127 alpha:1];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.unitLab];
    
    [self addTap];
}
-(void)setUnit:(NSString *)unit{
    _unit=unit;
    self.unitLab.text = [NSString stringWithFormat:@"单位:%@",unit];
    self.unitLab.hidden = YES;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.clipsToBounds=YES;
    }
    return _scrollView;
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
//        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}
-(void)addTap{
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.contentView addGestureRecognizer:tap];
}
-(void)tap:(UITapGestureRecognizer *)tap{
    CGPoint  point = [tap locationInView:self.contentView];
    for (int i = 0; i<self.barsStartPointsArr.count; i++) {
        CGPoint  startPoint = [self.barsStartPointsArr[i] CGPointValue];
        CGPoint  endPoint = [self.barsEndPointsArr[i] CGPointValue];
        if (point.x>=startPoint.x-self.barWidth/2&&point.x<=startPoint.x+self.barWidth/2&&point.y>=endPoint.y&&point.y<=startPoint.y) {
             NSLog(@"点击了第%d个柱形图",i);
//            self.bubbleLab.hidden=NO;
//            self.bubbleLab.text = self.yValuesArr[i];
//            self.bubbleLab.center = CGPointMake(endPoint.x, endPoint.y-10);
//            CAShapeLayer  *selctedLayer = self.barsLayersArr[i];
            if (self.delegate && [self.delegate respondsToSelector:@selector(SSWChartView:didSelectIndex:)]) {
                [self.delegate SSWChartView:self didSelectIndex:i];
            }
        }
    }
}
-(UILabel *)unitLab{
    if (!_unitLab) {
        _unitLab = [[UILabel alloc]init];
        _unitLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    }
    return _unitLab;
}
-(void)layoutSubviews{
//    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.unitLab.frame = CGRectMake(5, -10, 60, 20);
    _totalWidth = (self.gapWidth+(self.barWidth+self.gapWidth)*self.xValuesArr.count)-15;
//    _totalWidth= self.gapWidth+(self.barWidth+self.gapWidth)*self.xValuesArr.count;
    _totalHeight=self.scrollView.bounds.size.height-30-18;
    self.scrollView.contentSize = CGSizeMake(kChatYWidth+_totalWidth, 100);
    self.contentView.frame = CGRectMake(kChatYWidth,30, _totalWidth,_totalHeight);
//    self.contentView.backgroundColor = [UIColor orangeColor];
//    self.scrollView.backgroundColor = [UIColor yellowColor];
//    self.backgroundColor = [UIColor purpleColor];
    [self drawBarsChart];
}
-(void)drawBarsChart{
    [self clear];
    [self drawAxis];
    [self drawRangeOfHorizontal];
    [self addYAxisLabs];
    [self addBars];
    [self addXAxisLabs];
    [self showBarChartYValus];
}
//当触发界面重新布局的时候先移除之前的绘制
-(void)clear{
    [self.barsStartPointsArr removeAllObjects];
    [self.barsEndPointsArr removeAllObjects];
    for (CAShapeLayer *layer in self.barsLayersArr) {
        [layer removeFromSuperlayer];
    }
     [self.barsLayersArr removeAllObjects];
    [_lineLayer removeFromSuperlayer];
    _lineLayer=nil;
    [_lineXLayer removeFromSuperlayer];
    _lineXLayer = nil;
    for (UIView *view in self.contentView.subviews) {
        if([view isEqual:self.unitLab])continue;
        [view removeFromSuperview];
       
    }
}
//画坐标轴
-(void)drawAxis{
    UIBezierPath   *path = [UIBezierPath bezierPath];
    //先画整体的线
    [path moveToPoint:CGPointMake(0, -10)];
    [path addLineToPoint:CGPointMake(0, _totalHeight)];
    [path addLineToPoint:CGPointMake(_totalWidth, _totalHeight)];
    //画x轴的刻度
    for (int i = 0; i<self.xValuesArr.count; i++) {
        CGPoint  startPoint = CGPointMake(i*(self.barWidth+self.gapWidth)+self.gapWidth+self.barWidth/2, _totalHeight);
        [self.barsStartPointsArr addObject:[NSValue valueWithCGPoint:startPoint]];
        [path moveToPoint:startPoint];
//        [path addLineToPoint:CGPointMake(i*(self.barWidth+self.gapWidth)+self.gapWidth+self.barWidth/2, _totalHeight-5)];
    }
//
    CAShapeLayer   *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = HCColorHex(@"#999999").CGColor;
    lineLayer.lineWidth = 0.5;
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.contentView.layer addSublayer:lineLayer];
    _lineLayer = lineLayer;
}

-(void)drawRangeOfHorizontal{
    UIBezierPath   *path = [UIBezierPath bezierPath];

    //画y轴刻度
    for (int i = 0; i < self.yAxisCount; i++) {
        [path moveToPoint:CGPointMake(0, i*(_totalHeight/self.yAxisCount))];
        [path addLineToPoint:CGPointMake(_totalWidth, i*(_totalHeight/self.yAxisCount))];
    }
 
    CAShapeLayer   *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = HCColorHex(@"#EEEEEE").CGColor;
    lineLayer.lineWidth = 0.25;
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.contentView.layer addSublayer:lineLayer];
    _lineXLayer = lineLayer;
}



//给y轴添加刻度显示
-(void)addYAxisLabs{
//    [self.yAxisScaleValueAraay insertObject:@(0) atIndex:0];
    for (int i = self.yAxisCount ; i >= 0; i--) {
        CGFloat   yAxis = self.yScaleValue*i;
        UILabel  *lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(-5, (self.yAxisCount-i)*(_totalHeight/self.yAxisCount)-10, -kChatYWidth, 20);
//        lab.text = [NSString stringWithFormat:@"%.f",yAxis];
        lab.text = [self generateRealValueWithValue:yAxis length:1];
//        lab.text = [self generateRealValueWithValue:[self.yAxisScaleValueAraay[i] integerValue] length:1];
        
//        lab.backgroundColor = [UIColor orangeColor];
        lab.font = [UIFont systemFontOfSize:9];
        lab.textColor = kColorHex(@"#999999");
        lab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:lab];
    }
}
//给x轴添加刻度显示
-(void)addXAxisLabs{
    for (int i = 0 ; i<self.xValuesArr.count; i++) {
        CGPoint   point = [self.barsStartPointsArr[i] CGPointValue];
        UILabel   *lab = [[UILabel alloc]init];
        lab.bounds = CGRectMake(0, 0, self.barWidth+self.gapWidth*4/5, 20);
        lab.center = CGPointMake(point.x, point.y+lab.bounds.size.height/2);
        lab.text = [NSString stringWithFormat:@"%@",self.xValuesArr[i]];
        lab.font = [UIFont systemFontOfSize:9];
        lab.textColor = kColorHex(@"#999999");
        lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lab];
    }
}
//添加柱形图
-(void)addBars{
    for (int i = 0 ; i<self.yValuesArr.count; i++) {
        CGFloat   Y = [(NSString *)self.yValuesArr[i] floatValue];
        CGFloat   barHeight = (Y/(self.yAxisCount*self.yScaleValue))*_totalHeight;
        CGPoint   startPoint = [self.barsStartPointsArr[i] CGPointValue];
        CGPoint   endPoint = CGPointMake(startPoint.x, startPoint.y-barHeight);
        [self.barsEndPointsArr addObject:[NSValue valueWithCGPoint:endPoint]];
        CAShapeLayer *barLayer = [CAShapeLayer layer];
        barLayer.strokeColor = [UIColor colorWithRed:246/255.0 green:179/255.0 blue:127/255.0 alpha:1].CGColor;
        barLayer.lineWidth = self.barWidth;
        [self.contentView.layer addSublayer:barLayer];
     
        UIBezierPath  *barPath = [UIBezierPath bezierPath];
        [barPath moveToPoint:startPoint];
        [barPath addLineToPoint:endPoint];
        [barPath closePath];
        barLayer.path=barPath.CGPath;
        [barLayer addAnimation:[self animationWithDuration:0.3*(i+1)] forKey:nil];
        [self.barsLayersArr addObject:barLayer];
    }
}
//显示每个柱形图的值
-(void)showBarChartYValus{
    if(!self.showEachYValus)return;
    for (int i = 0; i<self.xValuesArr.count; i++) {
        CGPoint  point = [self.barsEndPointsArr[i] CGPointValue];
        UILabel  *lab = [[UILabel alloc]init];
        lab.textColor = HCColorHex(@"#333333");;
        lab.font = [UIFont systemFontOfSize:9];
//        if (self.isDisplayFront) {
//            lab.text = [NSString stringWithFormat:@"%@%@",self.xValueUnit,self.yValuesArr[i]];
//        } else {
//            lab.text = [NSString stringWithFormat:@"%@%@",self.yValuesArr[i],self.xValueUnit];
//        }
        
        if (self.isDisplayFront) {
            lab.text = [NSString stringWithFormat:@"%@%@",self.xValueUnit,[self generateRealValueWithValue:[self.yValuesArr[i] floatValue] length:0]];
        } else {
            lab.text = [NSString stringWithFormat:@"%@%@",[self generateRealValueWithValue:[self.yValuesArr[i] floatValue] length:1],self.xValueUnit];
        }
        
        lab.textAlignment = NSTextAlignmentCenter;
        lab.bounds = CGRectMake(0, 0, self.barWidth+self.gapWidth*4/5, 20);
        lab.center = CGPointMake(point.x, point.y-15);
        lab.transform = CGAffineTransformMakeRotation(-M_PI/4);
        [self.contentView addSubview:lab];
    }
}


- (void)setTransform:(float) radians forLable:(UILabel *) label
{
    label.transform = CGAffineTransformMakeRotation(M_PI*radians);

}


- (NSMutableArray *)yAxisScaleValueAraay {
    if (!_yAxisScaleValueAraay) {
        _yAxisScaleValueAraay = [@[] mutableCopy];
    }
    
    return _yAxisScaleValueAraay;
}


@end
