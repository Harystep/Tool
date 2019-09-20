//
//  HCProfitChartLineView.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/17.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCProfitChartLineView.h"

@interface HCProfitChartLineView (){
    CGFloat         _totalWidth;
    CGFloat         _totalHeight;
    CAShapeLayer    *_AxiasLineLayer;
    CAShapeLayer    *_lineLayer;
}
@property(nonatomic)UIScrollView        *scrollView;
@property(nonatomic)UIView              *contentView;
@property(nonatomic)NSMutableArray      *barsStartPointsArr;
@property(nonatomic)NSMutableArray      *barsEndPointsArr;
@property(nonatomic)NSMutableArray      *linePointPathArr;
@property(nonatomic)NSMutableArray      *linePointLayerArr;
@property(nonatomic)UILabel             *unitLab;
@end
@implementation HCProfitChartLineView
-(instancetype)initWithChartType:(SSWChartsType)type{
    self = [super initWithChartType:type];
    if (self) {
        [self setUp];
        
    }
    return self;
}

-(void)setUp{
    self.xValuesArr = [@[] mutableCopy];
    self.yValuesArr = [@[] mutableCopy];
    self.barsStartPointsArr  = [@[] mutableCopy];
    self.barsEndPointsArr = [@[] mutableCopy];
    self.linePointPathArr = [@[] mutableCopy];
    self.linePointLayerArr = [@[] mutableCopy];
    self.barWidth = 20;
    self.gapWidth = 30;
    self.yScaleValue = 50;
    self.yAxisCount = 10;
    self.showEachYValus=YES;
    self.lineColor = HCColorHex(@"#FE8402");
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.unitLab];
    [self addTap];
    [self.contentView addSubview:self.bubbleLab];
}
-(void)addTap{
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.contentView addGestureRecognizer:tap];
}
-(void)tap:(UITapGestureRecognizer *)tap{
    CGPoint  point = [tap locationInView:self.contentView];
    for (UIBezierPath *path in self.linePointPathArr) {
        if ([path containsPoint:point]) {
            NSInteger  index = [self.linePointPathArr indexOfObject:path];
//            CGPoint  endPoint = [self.barsEndPointsArr[index] CGPointValue];
            if (self.delegate && [self.delegate respondsToSelector:@selector(SSWChartView:didSelectIndex:)]) {
                [self.delegate SSWChartView:self didSelectIndex:index];
            }
        }
    }
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
-(UILabel *)unitLab{
    if (!_unitLab) {
        _unitLab = [[UILabel alloc]init];
        _unitLab.font = kFontSize(10);
        _unitLab.textColor = kColorHex(@"#999999");
    }
    return _unitLab;
}
-(void)layoutSubviews{
    self.scrollView.frame = self.bounds;
    self.unitLab.frame = CGRectMake(5, -15, 100, 20);
    _totalWidth= (self.gapWidth+(self.barWidth+self.gapWidth)*self.xValuesArr.count)>(kScreenWidth-2*kHRMarginX)?(self.gapWidth+(self.barWidth+self.gapWidth)*self.xValuesArr.count):(kScreenWidth-2*kHRMarginX);
    _totalHeight=self.scrollView.bounds.size.height-30-15;
    self.scrollView.contentSize = CGSizeMake(30+_totalWidth, 0);
    self.contentView.frame = CGRectMake(30,15, _totalWidth,_totalHeight);
    [self drawLineChart];
}
//开始绘制图表
-(void)drawLineChart{
    [self clear];
    [self drawAxis];
    [self addYAxisLabs];
    [self addXAxisLabs];
    [self drawRangeOfHorizontal];
    [self calculationTheLinePoints];
    if (self.barsStartPointsArr.count == 0 || self.barsEndPointsArr.count == 0) {
    }else{
        [self addLine];
        [self addLinePoints];
        [self showBarChartYValus];
    }
}
//触发界面布局之前清除掉之前的绘制
-(void)clear{
    [self.barsStartPointsArr removeAllObjects];
    [self.barsEndPointsArr removeAllObjects];
    for (CAShapeLayer *layer in self.linePointLayerArr) {
        [layer removeFromSuperlayer];
    }
    [self.linePointLayerArr removeAllObjects];
    [_AxiasLineLayer removeFromSuperlayer];
    [_lineLayer removeFromSuperlayer];
    _AxiasLineLayer=nil;
    _lineLayer=nil;
    for (UIView *view in self.contentView.subviews) {
        if([view isEqual:self.unitLab])continue;
        [view removeFromSuperview];
    }
    
}
//画坐标轴
-(void)drawAxis{
    UIBezierPath   *path = [UIBezierPath bezierPath];
    //先画整体的线
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, _totalHeight)];
    [path addLineToPoint:CGPointMake(_totalWidth, _totalHeight)];
    //画x轴的刻度
    for (int i = 0; i<self.xValuesArr.count; i++) {
        CGPoint  startPoint = CGPointMake(i*(self.barWidth+self.gapWidth)+self.gapWidth+self.barWidth/2, _totalHeight);
        [self.barsStartPointsArr addObject:[NSValue valueWithCGPoint:startPoint]];
        //        [path moveToPoint:startPoint];
        //        [path addLineToPoint:CGPointMake(i*(self.barWidth+self.gapWidth)+self.gapWidth+self.barWidth/2, _totalHeight-5)];
    }
    
    CAShapeLayer   *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [UIColor colorWithHexString:@"#EFEFEF"].CGColor;
    lineLayer.lineWidth = 0.5;
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.contentView.layer addSublayer:lineLayer];
    _AxiasLineLayer = lineLayer;
}

-(void)drawRangeOfHorizontal{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //画y轴刻度
    for (int i = 0; i<self.yAxisCount; i++) {
        [path moveToPoint:CGPointMake(0, i*(_totalHeight/self.yAxisCount))];
        [path addLineToPoint:CGPointMake(_totalWidth, i*(_totalHeight/self.yAxisCount))];
    }
    
    CAShapeLayer   *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [UIColor colorWithHexString:@"#EFEFEF"].CGColor;
    lineLayer.lineWidth = 0.25;
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.contentView.layer addSublayer:lineLayer];
    _lineLayer = lineLayer;
}

//给y轴添加刻度显示
-(void)addYAxisLabs{
    for (int i =self.yAxisCount ; i>0; i--) {
        double   yAxis = self.yScaleValue*i;
        UILabel  *lab = [[UILabel alloc]init];
        NSString *content = [NSString stringWithFormat:@"%@", @(yAxis)];
        NSArray *arr = [content componentsSeparatedByString:@"."];
        lab.frame = CGRectMake(-2, (self.yAxisCount-i)*(_totalHeight/self.yAxisCount)-10, -50, 20);
        if (arr.count>1) {
            lab.text = [NSString stringWithFormat:@"%.2f", yAxis];
        }else{
            lab.text = [NSString stringWithFormat:@"%@", content];
        }
        lab.font = [UIFont systemFontOfSize:10];
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
        NSString *content = [NSString stringWithFormat:@"%ld",[self.xValuesArr[i] integerValue]];
        lab.text = [NSString stringWithFormat:@"%@%@", content, [[HRNetworkTool shareTool] stringUserfulContent:self.status]];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textColor = kColorHex(@"#999999");
        lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lab];
    }
}
//计算折线的点坐标
-(void)calculationTheLinePoints{
    for (int i = 0 ; i<self.yValuesArr.count; i++) {
//        CGFloat   Y = [(NSString *)self.yValuesArr[i] floatValue];
        NSString *content = [self showYValusWithCompanyType:self.companyType withNum:self.yValuesArr[i]];
        CGFloat   Y = [content doubleValue];
        CGFloat   barHeight = (Y/(self.yAxisCount*self.yScaleValue))*_totalHeight;
        CGPoint   startPoint = [self.barsStartPointsArr[i] CGPointValue];
        CGPoint   endPoint = CGPointMake(startPoint.x, startPoint.y-barHeight);
        [self.barsEndPointsArr addObject:[NSValue valueWithCGPoint:endPoint]];
    }
}
//添加折线的点
-(void)addLinePoints{
    for (int i = 0 ; i<self.xValuesArr.count; i++) {
        CGPoint   point = [self.barsEndPointsArr[i] CGPointValue];
        UIBezierPath   *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:point radius:3 startAngle:0 endAngle:M_PI*2 clockwise:YES];
//                [path closePath];
        [self.linePointPathArr addObject:path];
        
        CAShapeLayer  *layer = [CAShapeLayer layer];
        layer.strokeColor = self.lineColor.CGColor;
        layer.fillColor = self.backgroundColor.CGColor;
        layer.lineWidth=2;
        layer.path = path.CGPath;
        [layer addAnimation:[self animationWithDuration:0.1*i] forKey:nil];
        [self.contentView.layer addSublayer:layer];
        [self.linePointLayerArr addObject:layer];
    }
}
//添加折线
-(void)addLine{
    UIBezierPath  *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:[self.barsEndPointsArr[0] CGPointValue]];
    for (int i = 1; i<self.barsEndPointsArr.count; i++) {
        [linePath addLineToPoint:[self.barsEndPointsArr[i] CGPointValue]];
    }
    
    CAShapeLayer  *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = self.lineColor.CGColor;
    lineLayer.lineWidth = 2;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.path = linePath.CGPath;
    [lineLayer addAnimation:[self animationWithDuration:0.1*self.barsEndPointsArr.count] forKey:nil];
    [self.contentView.layer addSublayer:lineLayer];
    _lineLayer = lineLayer;
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
//显示每个线形图的值
-(void)showBarChartYValus{
    if(!self.showEachYValus)return;
    for (int i = 0; i<self.xValuesArr.count; i++) {
        CGPoint  point = [self.barsEndPointsArr[i] CGPointValue];
        UILabel  *lab = [[UILabel alloc]init];
        lab.textColor = HCColorHex(@"#333333");
        lab.font = [UIFont systemFontOfSize:9];
        lab.text = [self showYValusWithCompanyType:self.companyType withNum:self.yValuesArr[i]];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.bounds = CGRectMake(0, 0, self.barWidth+self.gapWidth, 20);
        lab.center = CGPointMake(point.x, point.y-10);
        [self.contentView addSubview:lab];
//        lab.transform = CGAffineTransformMakeRotation(-M_PI/5);
        
    }
}

- (NSString *)showYValusWithCompanyType:(kCompanyType)type withNum:(NSString *)numStr {
    NSString *content;
    switch (type) {
        case kCompanyTypeYuan:
            content = [NSString stringWithFormat:@"%@", numStr];
            break;
        case kCompanyTypeWanYuan:
            content = [NSString stringWithFormat:@"%.2f", [numStr doubleValue]/10000.0];
            break;
        case kCompanyTypeBaiWan:
            content = [NSString stringWithFormat:@"%.2f", [numStr doubleValue]/1000000.0];
            break;
        case kCompanyTypeYiYuan:
            content = [NSString stringWithFormat:@"%.4f", [numStr doubleValue]/100000000.0];
            break;
            
        default:
            break;
    }
    return content;
}

- (void)setYScaleValue:(CGFloat)yScaleValue {
    CGFloat content;
    switch (self.companyType) {
        case kCompanyTypeYuan:
            content = yScaleValue;
            break;
        case kCompanyTypeWanYuan:
            content = yScaleValue/10000.0;
            break;
        case kCompanyTypeBaiWan:
            content = yScaleValue/1000000.0;
            break;
        case kCompanyTypeYiYuan:
            content = yScaleValue/100000000.0;
            break;
        default:
            break;
    }
    _yScaleValue = content;
}

- (void)setCompanyType:(kCompanyType)companyType {
    _companyType = companyType;
    self.unitLab.text = [NSString stringWithFormat:@"(单位/%@)",[self setValueFromType:self.companyType]];
}

- (NSString *)setValueFromType:(kCompanyType)type {
    NSString *content;
    switch (type) {
        case kCompanyTypeYuan:
            content = @"元";
            break;
        case kCompanyTypeWanYuan:
            content = @"万元";
            break;
        case kCompanyTypeBaiWan:
            content = @"百万";
            break;
        case kCompanyTypeYiYuan:
            content = @"亿";
            break;
            
        default:
            break;
    }
    return content;
}

@end
