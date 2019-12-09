//
//  HRFunctionItemView.m
//  HRCommonTool
//
//  Created by pxsl on 2019/12/6.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "HRFunctionItemView.h"
#import "HREmergencySimpleView.h"
#import "HRSecuritySimpleView.h"

@interface HRFunctionItemView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation HRFunctionItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initScrollViewBase];
    }
    return self;
}

#pragma mark - ScrollView基本设置
-(void)initScrollViewBase {
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.delegate = self;
    
    [self addSubview:self.scrollView];
}

#pragma mark - 重写外部数据接口Set
-(void)setImgArr:(NSMutableArray *)imgArr {
    _imgArr = imgArr;
    //获取数据后去设置轮播显示内容
    [self loadImageView];
    
    [self loadPageControl];
    
    [self openTimer];
}

#pragma mark - 加载控件
-(void) loadImageView {
    
    self.scrollView.contentSize = CGSizeMake(self.width*self.imgArr.count, self.height);
    
    for (int i=0; i<self.imgArr.count; i++) {
        //这里使用btn来显示，也可以用imgView，视情况而定
        if (i == 0) {
            HREmergencySimpleView *emergency = [[HREmergencySimpleView alloc] initWithFrame:CGRectMake(self.width*i, 0, self.width, self.height)];
            [self.scrollView addSubview:emergency];
        } else {
            HRSecuritySimpleView *security = [[HRSecuritySimpleView alloc] initWithFrame:CGRectMake(self.width*i, 0, self.width, self.height)];
            [self.scrollView addSubview:security];
        }
    }
    
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

-(void) loadPageControl {
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.height-24, self.width, 24)];
    self.pageControl.numberOfPages = self.imgArr.count;//真实数量，减去首尾两张
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    [self addSubview:self.pageControl];
}

#pragma mark - 开关定时器
-(void) openTimer {
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(automaticRolling) userInfo:nil repeats:YES];
}

-(void) stopTimer {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - 点击跳转事件
-(void) chickToWeb {
    //TODO:点击事件
    NSLog(@"跳转！");
}

#pragma mark - 定时器自动滚动事件
-(void) automaticRolling {
    //下一个偏移量 = 当前偏移量 + 一个宽度
    CGFloat contentOffsetX = self.scrollView.contentOffset.x + self.width;
    [self.scrollView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate 代理
-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentoffsetX = self.scrollView.contentOffset.x;//当前x偏移量
    
    CGFloat max = self.width * (self.imgArr.count-1);//最大偏移量，假设有五张图，那么最大偏移量就是五张图的X坐标
    
    //向左滚动，偏移量为0时，重新设置偏移量为倒数第二张
    if (contentoffsetX <= 0) {
        CGFloat willOffsetX = self.width * (self.imgArr.count-2);
        [self.scrollView setContentOffset:CGPointMake(willOffsetX, 0) animated:NO];
    }
    //向右滚动，偏移量为最大时，重新设置偏移量为顺数第二张
    else if (contentoffsetX >= max) {
        [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    }
    
    //根据偏移量设置当前页数
    self.pageControl.currentPage = self.scrollView.contentOffset.x/self.width;
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //开始拖动停止定时器
    [self stopTimer];
}

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //停止拖动 先关闭定时器再开启定时器
    [self stopTimer];
    [self openTimer];
}

-(void)dealloc {
    
    [self stopTimer];
}

@end
