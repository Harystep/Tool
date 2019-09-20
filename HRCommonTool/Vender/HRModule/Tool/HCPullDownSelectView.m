//
//  HCPullDownSelectView.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCPullDownSelectView.h"

@interface HCPullDownSelectView()

@property (strong, nonatomic) UIButton *contentBtn;

@property (strong, nonatomic) NSArray *timeTypeArr;

@end

@implementation HCPullDownSelectView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titleArr{
    
    if (self = [super initWithFrame:frame]) {
        self.timeTypeArr = titleArr;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    _contentBtn = [[UIButton alloc] init];
    [_contentBtn setBackgroundImage:kImageName(@"icon-v5_filter_boxAvater") forState:UIControlStateNormal];
    _contentBtn.frame = CGRectMake(0, 0, self.width, self.height);
    CGFloat marginY = 5;
    CGFloat btnH = (kMarcoHeight(133.0)-10)/3;
    for (int i = 0; i < 3; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, marginY+(btnH+0.5)*i, _contentBtn.width, btnH);
        [_contentBtn addSubview:btn];
        [btn setButtonTextColor:kColorHex(@"#FFFFFF") text:self.timeTypeArr[i] withFont:kMarcoWidth(14)];
        UIView *sepView = [[UIView alloc] init];
        [_contentBtn addSubview:sepView];
        sepView.frame = CGRectMake(12, CGRectGetMaxY(btn.frame), _contentBtn.width-12*2, 0.5);
        if (i == 2) {
            sepView.hidden = YES;
        }
        btn.tag = i;
        sepView.backgroundColor = kColorHex(@"#FFFFFF");
        [btn addTarget:self action:@selector(selectTimeTypeOperate:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:_contentBtn];
}

- (void)selectTimeTypeOperate:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectTypeBtnOperate:)]) {
        [self.delegate selectTypeBtnOperate:sender.tag];
    }
}

@end
