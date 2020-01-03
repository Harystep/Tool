//
//  SSWPieChartView.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/2.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

#import "HBPieChartView.h"
@interface HBPieChartView ()
@property(nonatomic,strong)NSMutableArray   *shapLayersArr;//扇形layer数组
@property(nonatomic,strong)NSMutableArray   *pathsArr;//扇形路径数组
@property(nonatomic)CAShapeLayer            *maskLayer;//遮盖动画layer
@property(nonatomic)NSMutableArray          *halfAngleArr;//扇形中心角度数组
@property(nonatomic)NSMutableArray          *titleLabArr;//提示标题数组
@property(nonatomic)NSMutableArray          *polyLineLayerArr;//折线layer数组
@end
@implementation HBPieChartView
-(instancetype)initWithChartType:(SSWChartsType)type{
    self = [super initWithChartType:type];
    if (self) {
//        [self start];
        [self layoutSubviews];
    }
    return self;
}

- (void)start {
    [self clearSelf];
    [self setUp];
}

-(void)setRadius:(CGFloat)radius{
    _radius = radius;
}
-(void)setUp {
    self.radius = 60;
  
    if (self.chartType!= SSWChartsTypePie) {
        return;
    }
    self.shapLayersArr = [@[] mutableCopy];
    self.pathsArr = [@[] mutableCopy];
    self.halfAngleArr = [@[] mutableCopy];
    self.titleLabArr = [@[] mutableCopy];
    self.polyLineLayerArr = [@[] mutableCopy];
    [self addTap];
    [self layoutSubviews];
}
-(void)addTap{
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}
-(void)tap:(UITapGestureRecognizer *)tap{
    CGPoint  point = [tap locationInView:self];
    for (UIBezierPath  *path in self.pathsArr) {
        if ([path containsPoint:point]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(SSWChartView:didSelectIndex:)]) {
                [self.delegate SSWChartView:self didSelectIndex:[self.pathsArr indexOfObject:path]];
            }
        }
        
    }
}
-(void)setPathForShapLayer{
    for (int i = 0 ; i<self.percentageArr.count; i++) {
        CAShapeLayer  *layer =self.shapLayersArr[i];
        UIBezierPath  *path = self.pathsArr[i];
        layer.path = path.CGPath;
    }
}
-(void)addShapLayers{
    for (int i = 0 ; i<self.percentageArr.count; i++) {
        CAShapeLayer   *layer = [CAShapeLayer layer];
        layer.strokeColor = [UIColor clearColor].CGColor;
        layer.fillColor = [self.colorsArr[i] CGColor];
        layer.lineWidth=1;
        layer.lineJoin  = kCALineCapRound;
        layer.lineCap = kCALineJoinRound;
        [self.layer addSublayer:layer];
        [self.shapLayersArr addObject:layer];
    }
}
-(void)addPaths{
    CGPoint   centerPoint =CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    CGFloat   radius = self.radius;
    float  lastSumPercentage=0;
    float  lastPercentage=0;
    float  totalSumPercentage=0;
    for (int i = 0 ; i<self.percentageArr.count; i++) {
        float percentage = [self.percentageArr[i] floatValue];
        totalSumPercentage = totalSumPercentage+percentage;
        UIBezierPath  *path = [UIBezierPath bezierPath];
        [path moveToPoint:centerPoint];
        if (i==0) {
            lastPercentage=0;
            [path addArcWithCenter:centerPoint radius:radius startAngle:M_PI*2*lastSumPercentage endAngle:M_PI*2*percentage clockwise:YES];
            [self.halfAngleArr addObject:[NSNumber numberWithFloat:M_PI*2*percentage/2.0]];
        }
        else{
            lastPercentage = [self.percentageArr[i-1] floatValue];
            lastSumPercentage = lastSumPercentage + lastPercentage;
            [path addArcWithCenter:centerPoint  radius:radius startAngle:M_PI*2*lastSumPercentage endAngle:M_PI*2*totalSumPercentage clockwise:YES];
            [self.halfAngleArr addObject:[NSNumber numberWithFloat:lastSumPercentage*M_PI*2+(M_PI*2*percentage)/2]];
        }
        [path closePath];
        [self.pathsArr addObject:path];
        
    }
}
//布局
-(void)layoutSubviews{
    [super layoutSubviews];
    [self addShapLayers];
    [self addPaths];
    [self setPathForShapLayer];
    NSLog(@"percentageArr-->%@", self.percentageArr);
    NSLog(@"colorsArr-->%@ titleLabArr:%@ shapLayersArr:%@ polyLineLayerArr:%@", self.colorsArr,self.titlesArr,self.shapLayersArr,self.polyLineLayerArr);
//    [self locationTheNoticeLab];
    
    if (!self.layer.mask) {
        self.layer.mask = self.maskLayer;
        [self.maskLayer addAnimation:[self addAnimation] forKey:nil];////
    }
}

-(void)clearSelf{
    for (CAShapeLayer *layer in self.shapLayersArr) {
        [layer removeFromSuperlayer];
    }
    for (CAShapeLayer *layer in self.polyLineLayerArr) {
        [layer removeFromSuperlayer];
    }
    for (UILabel *lab in self.titleLabArr) {
        [lab removeFromSuperview];
    }
    [self.shapLayersArr removeAllObjects];
    [self.polyLineLayerArr removeAllObjects];
    [self.titleLabArr removeAllObjects];
}
//动画
-(CABasicAnimation *)addAnimation{
    CABasicAnimation  *anmiation = [CABasicAnimation  animationWithKeyPath:@"strokeEnd"];
    anmiation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmiation.duration = 1;
    anmiation.fromValue=@(0);
    anmiation.toValue = @(1);
    return anmiation;
}
-(CAShapeLayer *)maskLayer{
    //lineWidth属性要设置为半径的二倍否则会出现空心圆
  CGPoint   centerPoint =CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.lineWidth = self.bounds.size.width;
        _maskLayer.strokeColor = [UIColor orangeColor].CGColor;
        _maskLayer.lineCap = kCALineCapButt;
        UIBezierPath  *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:self.bounds.size.width/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        _maskLayer.path = path.CGPath;
    }
    return _maskLayer;
}
@end
