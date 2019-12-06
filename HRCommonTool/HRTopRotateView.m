//
//  HCTopRotateView.m
//  HczyJtb
//
//  Created by pxsl on 2019/11/25.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HRTopRotateView.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

@interface HRTopRotateView () <NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

@property (nonatomic, strong) NewPagedFlowView *pageFlowView;

@property (strong, nonatomic) UIImageView *bgContentIv;

@end

@implementation HRTopRotateView

//+ (instancetype)topRotateTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
//    HRTopRotateView *cell = [tableView dequeueReusableCellWithIdentifier:@"HCTopRotateView" forIndexPath:indexPath];
//    return cell;
//}
//
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:@"HCTopRotateView"]) {
//        [self createSubViews];
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}


- (void)createSubViews {
    
    [self addSubview:self.bgContentIv];
    [self addSubview:self.pageFlowView];
    
}

- (void)setFuncArr:(NSArray *)funcArr {
    _funcArr = funcArr;
    
}

- (void)setBannerArr:(NSArray *)bannerArr {
    _bannerArr = bannerArr;
    if (bannerArr.count == 1) {
        self.pageFlowView.pageControl.hidden = YES;
    } else {
        self.pageFlowView.pageControl.hidden = NO;
    }
    [self.pageFlowView reloadData];
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(kWIDTH, kMarcoWidth(190.5));
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    if ([self.delegate respondsToSelector:@selector(selectTopRotateViewItem:)]) {
        [self.delegate selectTopRotateViewItem:subIndex];
    }
    
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    //    NSLog(@"ViewController 滚动到了第%tu页",pageNumber);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.bannerArr.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
    }
    //在这里下载网络图片
    bannerView.mainImageView.image = kImageName(self.bannerArr[index]);
    return bannerView;
}

- (NewPagedFlowView *)pageFlowView {
    if (_pageFlowView == nil) {
        NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kMarcoWidth(190.5))];
        pageFlowView.delegate = self;
        pageFlowView.dataSource = self;
        pageFlowView.minimumPageAlpha = 0.1;
        pageFlowView.isCarousel = YES;
        pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        pageFlowView.isOpenAutoScroll = YES;
        //初始化pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 20, kWIDTH, 8)];
        pageFlowView.pageControl = pageControl;
        [pageControl setValue:[UIImage imageNamed:@"banner_point_sel"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"banner_point_def"] forKeyPath:@"_pageImage"];
        [pageFlowView addSubview:pageControl];        
        _pageFlowView = pageFlowView;
    }
    return _pageFlowView;
}

- (UIImageView *)bgContentIv {
    if (!_bgContentIv) {
        _bgContentIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, self.height)];
        _bgContentIv.image = kImageName(@"top_bg");        
    }
    return _bgContentIv;
}

@end
