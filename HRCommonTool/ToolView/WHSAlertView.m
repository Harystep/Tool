//
//  WHSAlertView.m
//  WHSProject
//
//  Created by 八点半 on 2019/2/25.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "WHSAlertView.h"

@interface WHSAlertView ()

@property (nonatomic, strong) UILabel *titleL;

@end

@implementation WHSAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setCornerRadius:5];
        [self setUI];
    }
    return self;
}
//设置UI
- (void)setUI {
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.frame = CGRectMake(0, 0, self.width, 60);
    titleL.textColor = kTitleContentColor;
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.text = @"安全设置更改后";
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.lineBreakMode = NSLineBreakByCharWrapping;
    titleL.numberOfLines = 0;
    self.titleL = titleL;
    [self addSubview:titleL];
    
    UIView *sepView = [[UIView alloc] init];
    sepView.frame = CGRectMake(0, CGRectGetMaxY(titleL.frame), self.width, 1);
    sepView.backgroundColor = kSeperoterViewColor;
    [self addSubview:sepView];
    CGFloat btnW = self.width / 2;
    for (int i = 0; i < 2; i ++) {
        UIButton *opBtn = [[UIButton alloc] init];
        opBtn.tag = i;
        opBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        if (i == 0) {
            [opBtn setTitle:@"取消" forState:UIControlStateNormal];
            [opBtn setTitleColor:kSubTitleContentColor forState:UIControlStateNormal];
        } else {
            [opBtn setTitle:@"确定" forState:UIControlStateNormal];
            [opBtn setTitleColor:kButtonBgColor forState:UIControlStateNormal];
        }
        opBtn.frame = CGRectMake(i * (btnW + 1), CGRectGetMaxY(sepView.frame), btnW, 45);
        [opBtn addTarget:self action:@selector(opBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:opBtn];
    }
    
    UIView *lineSep = [[UIView alloc] init];
    lineSep.frame = CGRectMake(btnW, CGRectGetMaxY(sepView.frame), 1, 45);
    lineSep.backgroundColor = kViewSeparatorBgColor;
    [self addSubview:lineSep];
}

- (void)setTitle:(NSString *)title {
    self.titleL.text = title;
}

- (void)opBtnDidClick:(UIButton *)sender {
    [self operateBtnClick:sender.tag withBtn:sender];
}

- (void)operateBtnClick:(NSInteger)type withBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(operateAlertBtn:withButton:)]) {
        [self.delegate operateAlertBtn:type withButton:btn];
    }
}
@end
