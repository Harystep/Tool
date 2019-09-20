//
//  HCAlertCreateCodeView.m
//  HczyJtb
//
//  Created by pxsl on 2019/9/9.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCAlertCreateCodeView.h"

@interface HCAlertCreateCodeView ()

@property (strong, nonatomic) UILabel *contentL;



@end

@implementation HCAlertCreateCodeView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createSubViews];
    }
    return self;
}
#pragma mark -- 添加子视图
- (void)createSubViews {
    
    UIView *contentView = [self createViewOnTargetView:self withFrame:CGRectMake(0, 0, self.width, self.height)];
    contentView.backgroundColor = kColorHex(@"#ffffff");
    [contentView setViewBorderWidthWithColor:0.5 withColor:[UIColor lightTextColor] withCornerRadius:2];
    
    UIView *topView = [self createViewOnTargetView:contentView withFrame:CGRectMake(0, 0, contentView.width, 50)];
    topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *titleL = [self createLabelOnTargetView:topView withFrame:CGRectMake(kHRMarginX, 0, 200, topView.height)];
    [titleL setLabelTextColor:kColorHex(@"#333333") text:@"生成激活码" withFont:16];
    
    UILabel *contentL = [self createLabelOnTargetView:contentView withFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 20, contentView.width, 20)];
    [contentL setLabelTextColor:kColorHex(@"#333333") text:@"已生成激活码:" withFont:15];
    self.contentL = contentL;
    contentL.textAlignment = NSTextAlignmentCenter;
    
    UILabel *subTitleL = [self createLabelOnTargetView:contentView withFrame:CGRectMake(0, CGRectGetMaxY(contentL.frame) + 10, contentView.width, 20)];
    subTitleL.textAlignment = NSTextAlignmentCenter;
    [subTitleL setLabelTextColor:kColorHex(@"#333333") text:@"可在列表中查看" withFont:15];
    
    UIButton *sureBtn = [self createButtonOnTargetView:contentView withFrame:CGRectMake(kHRMarginX, CGRectGetMaxY(subTitleL.frame) + 25, contentView.width - 2 * kHRMarginX, 30)];
    [sureBtn setButtonTextColor:kColorHex(@"#ffffff") text:@"我知道了" withFont:15];
    [sureBtn addTarget:self action:@selector(sureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setCornerRadius:3];
    sureBtn.backgroundColor = kColorHex(@"#FF6B21");
    
}

#pragma mark -- 点击确定生成激活码
- (void)sureBtnDidClick {
    if ([self.delegate respondsToSelector:@selector(sureCreateActiveCodeOperate)]) {
        [self.delegate sureCreateActiveCodeOperate];
    }
}

- (void)setCodeStr:(NSString *)codeStr {
    _codeStr = codeStr;
    self.contentL.text = [NSString stringWithFormat:@"已生成激活码: %@", self.codeStr];
}

@end
