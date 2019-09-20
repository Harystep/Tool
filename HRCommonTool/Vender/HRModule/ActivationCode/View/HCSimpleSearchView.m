//
//  HCSimpleSearchView.m
//  HczyJtb
//
//  Created by pxsl on 2019/9/9.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCSimpleSearchView.h"

@interface HCSimpleSearchView () <UITextFieldDelegate>

/**
 标记是否有取消按钮
 */
@property (assign, nonatomic) BOOL cancelFlag;
/**
 取消按钮
 */
@property (strong, nonatomic) UIButton *cancelBtn;
/**
 搜索图标
 */
@property (strong, nonatomic) UIImageView *searchIv;


@end

@implementation HCSimpleSearchView

- (instancetype)initWithFrame:(CGRect)frame withCancelType:(NSInteger)type {
    if (self = [super initWithFrame:frame]) {
        _cancelFlag = type;
        [self createSubViews];
    }
    return self;
}

#pragma mark -- 创建子控件
- (void)createSubViews {
    UIView *contentView;
    if (self.cancelFlag) {
        contentView = [self createViewOnTargetView:self withFrame:CGRectMake(kHRMarginX, (self.height - 30)/2, self.width - 2 * kHRMarginX - 40, 30)];
        contentView.backgroundColor = kColorHex(@"#F6F6F6");
        [contentView setViewBorderWidthWithColor:1.0 withColor:[UIColor groupTableViewBackgroundColor] withCornerRadius:contentView.height/2.0];
        
        UIButton *cancelBtn = [self createButtonOnTargetView:self withFrame:CGRectMake(CGRectGetMaxX(contentView.frame)+8, 0, 40, self.height)];
        self.cancelBtn = cancelBtn;
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = kFontSize(15);
        [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        contentView = [self createViewOnTargetView:self withFrame:CGRectMake(kHRMarginX, (self.height - 30)/2, self.width - 2 * kHRMarginX, 30)];
        [contentView setViewBorderWidthWithColor:1.0 withColor:[UIColor groupTableViewBackgroundColor] withCornerRadius:contentView.height/2.0];
    }
    self.contentView = contentView;
    [contentView addSubview:self.searchIv];
//    self.searchIv.frame = CGRectMake(kHRMarginX, (contentView.height - self.searchIv.height)/2, self.searchIv.width, self.searchIv.height);
    
    [contentView addSubview:self.textField];
//    self.textField.frame = CGRectMake(CGRectGetMaxX(self.searchIv.frame) + 8, 0, (contentView.width - CGRectGetMaxX(self.searchIv.frame) - kHRMarginX), contentView.height);
    
    UIView *sepView = [self createViewOnTargetView:contentView withFrame:CGRectMake(0, contentView.height - 1, kScreenWidth, 1)];
    sepView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}
#pragma mark -- 文本框初始化位置
- (void)searchTextInitType {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize size = [self.placeStr boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    CGFloat width = size.width + 4;
    self.searchIv.frame = CGRectMake((self.contentView.width - width - 8 - self.searchIv.width)/2, (self.contentView.height - self.searchIv.height)/2, self.searchIv.width, self.searchIv.height);
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.searchIv.frame) + 8, 0, (self.contentView.width - CGRectGetMaxX(self.searchIv.frame) - kHRMarginX), self.contentView.height);
}

#pragma mark -- 文本开始编辑的变化
- (void)searchStartTextType {
    self.searchIv.frame = CGRectMake(kHRMarginX, (self.contentView.height - self.searchIv.height)/2, self.searchIv.width, self.searchIv.height);
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.searchIv.frame) + 8, 0, (self.contentView.width - CGRectGetMaxX(self.searchIv.frame) - kHRMarginX), self.contentView.height);
    
}

#pragma mark -- 取消
- (void)cancelBtnDidClick {
    
    [self.contentView endEditing:YES];
    
}

#pragma mark -- UITextFieldDelegate 代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self searchStartTextType];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidStartEditing)]) {
        [self.delegate textFieldDidStartEditing];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldSearchValue:)]) {
        [self.delegate textFieldSearchValue:textField.text];
    }
    [self cancelBtnDidClick];
    return YES;
}

- (void)setPlaceStr:(NSString *)placeStr {
    _placeStr = placeStr;
    self.textField.placeholder = placeStr;
    
    [self searchTextInitType];
}

- (void)setFilletFlag:(BOOL)filletFlag {
    _filletFlag = filletFlag;
    [self.contentView setCornerRadius:self.contentView.height/2.0];
}

- (void)setContentRadius:(CGFloat)contentRadius {
    _contentRadius = contentRadius;
    [self.contentView setCornerRadius:contentRadius];
}


- (void)setContentViewBorderWidth:(CGFloat)width withBorderColor:(UIColor *)color withRadius:(CGFloat)radius{
    [self.contentView setViewBorderWidthWithColor:width withColor:color withCornerRadius:radius];
    
}

- (UIImageView *)searchIv {
    if (_searchIv == nil) {
        _searchIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_v3_search"]];
        _searchIv.contentMode = UIViewContentModeCenter;
    }
    return _searchIv;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _textField.inputAccessoryView = toolBar;
        
    }
    return _textField;
}

   
@end
