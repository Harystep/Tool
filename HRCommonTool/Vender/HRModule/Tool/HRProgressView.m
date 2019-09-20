//
//  HRProgressView.m
//  WHSProject
//
//  Created by 八点半 on 2019/2/21.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "HRProgressView.h"
#import "UIView+Radius.h"

#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define kWidthView 50
#define kHeightView 50

@interface HRProgressView ()

@property (nonatomic, strong) UIWindow *keyWindow;

@property (nonatomic, strong) UIButton *maskBtn;
/** 底层图片 */
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, assign) CGFloat maskAlpha;

@property (nonatomic, assign) CGFloat maskRadius;

@property (nonatomic, strong) UIColor *maskColor;

@property (nonatomic, strong) UIColor *activityColor;

@end

static HRProgressView *progressTool;

@implementation HRProgressView

+ (instancetype)shareProressView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (progressTool == nil) {
            progressTool = [[HRProgressView alloc] init];
        }
    });
    return progressTool;
}

- (UIActivityIndicatorView *)activityView {
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityView.hidden = YES;
    }
    return _activityView;
}

- (UIView *)maskView {
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake((kWIDTH - kWidthView)/2, (kHEIGHT - kHeightView)/2, kWidthView, kHeightView)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.2;
        [_maskView setCornerRadius:5];
        _maskView.hidden = YES;
    }
    return _maskView;
}

- (UIButton *)maskBtn {
    if (_maskBtn == nil) {
        _maskBtn = [[UIButton alloc] init];
        _maskBtn.backgroundColor = [UIColor blackColor];
        _maskBtn.alpha = 0.2;
        _maskBtn.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
        _maskBtn.hidden = YES;
    }
    return _maskBtn;
}

- (UIWindow *)keyWindow {
    if (_keyWindow == nil) {
        _keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _keyWindow;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setDefaultConfigure];
    }
    return self;
}

- (void)setMaskBtnColor:(UIColor *)color {
    self.maskBtn.backgroundColor = color;
}

- (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.keyWindow addSubview:self.maskBtn];
        self.maskBtn.hidden = NO;
        [self.keyWindow addSubview:self.maskView];
        self.maskView.hidden = NO;
        //设置类型
        [self.maskView addSubview:self.activityView];
        [self setMaskViewType];
        self.activityView.frame = CGRectMake((self.maskView.width - 30)/2, (self.maskView.height - 30)/2, 30, 30);
        [self.activityView startAnimating];
    });
}

- (void)setMaskViewType {
    self.maskView.backgroundColor = self.maskColor;
    self.maskView.alpha = self.maskAlpha;
    [self.maskView setCornerRadius:self.maskRadius];
//    [self.activityView setColor:self.activityColor];
    self.activityView.color = self.activityColor;
}

- (void)setProgressViewBgColor:(UIColor *)color alpha:(CGFloat)alpha withRadius:(CGFloat)radius withActivityViewColor:(nonnull UIColor *)activeColor{
    self.maskRadius = radius > 0.0 ? radius:self.maskRadius;
    self.maskAlpha = alpha > 0.0 ? alpha:self.maskAlpha;
    self.maskColor = (color == nil ? self.maskColor:color);
    self.activityColor = (activeColor == nil ? self.activityColor:activeColor);
}

- (void)dismiss {
    self.maskBtn.hidden = YES;
    [self.activityView stopAnimating];
    self.maskView.hidden = YES;
}
- (void)setDefaultConfigure {
    self.maskColor = [UIColor blackColor];
    self.maskAlpha = 0.2;
    self.maskRadius = 5;
    self.activityColor = [UIColor whiteColor];
}
@end
