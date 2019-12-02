

#import "HRSimpleTypeView.h"

@interface HRSimpleTypeView ()

@property (strong, nonatomic) UILabel *targetL;

@property (strong, nonatomic) UITextField *targetF;

@property (strong, nonatomic) UILabel *subLabelTitleL;

@property (strong, nonatomic) UILabel *subFieldTitleL;

@end

@implementation HRSimpleTypeView

- (instancetype)initWithFrame:(CGRect)frame withStyle:(HRSimpleViewType)type {
    if ( self = [super initWithFrame:frame]) {
        [self createSubViewWithType:type];
    }
    return self;
}
#pragma mark -- 创建子控件
- (void)createSubViewWithType:(HRSimpleViewType)type {
    switch (type) {
        case HRSimpleViewTypeText:
            [self createViewTypeWithText];
            break;
        case HRSimpleViewTypeField:
            [self createViewTypeWithField];
            break;
        case HRSimpleViewTypeTextAndArrow:
            [self createViewTypeWithTextAndArrow];
            break;
            
        default:
            break;
    }
}
#pragma mark -- 文本显示框
- (void)createViewTypeWithText {
    [self createSubViewsOnTargetView:self withTitle:@"" isArrow:NO withPlaceholder:@""];
}
#pragma mark -- 文本输入框
- (void)createViewTypeWithField {
    [self createSubViewsOnTargetView:self withTitle:@"" withPlaceholder:@""];
}
#pragma mark -- 文本选择框
- (void)createViewTypeWithTextAndArrow {
    [self createSubViewsOnTargetView:self withTitle:@"" isArrow:YES withPlaceholder:@""];
}
#pragma mark -- 创建视图+文本框
- (void)createSubViewsOnTargetView:(UIView *)targetView withTitle:(NSString *)title withPlaceholder:(NSString *)placeholder {
    UIView *sepView = [self createViewOnTargetView:targetView withFrame:CGRectMake(kHRMarginX, targetView.height - 1,targetView.width - 2 * kHRMarginX, 1)];
    sepView.backgroundColor = kViewSepColor;
    
    UILabel *titleL = [self createLabelOnTargetView:targetView withFrame:CGRectMake(kHRMarginX, 0, 110, targetView.height - 1)];
    self.subLabelTitleL = titleL;
    [titleL setLabelTextColor:kColorHex(@"#333333") text:title withFont:15];
    
    UITextField *inputF = [self createTextFieldOnTargetView:targetView withFrame:CGRectMake(CGRectGetMaxX(titleL.frame), 0, targetView.width - CGRectGetMaxX(titleL.frame) - kHRMarginX, targetView.height - 1) withPlaceholder:placeholder];
    inputF.font = kFontSize(14);
    inputF.textColor = kColorHex(@"#4C4C4C");
    inputF.textAlignment = NSTextAlignmentRight;
    inputF.keyboardType = UIKeyboardTypeNumberPad;
    self.targetF = inputF;
    
}
#pragma mark -- 创建视图+显示框
- (void)createSubViewsOnTargetView:(UIView *)targetView withTitle:(NSString *)title isArrow:(BOOL)arrowFlag withPlaceholder:(NSString *)placeholder {
    UIView *sepView = [self createViewOnTargetView:targetView withFrame:CGRectMake(kHRMarginX, targetView.height - 1,targetView.width - 2 * kHRMarginX, 1)];
    sepView.backgroundColor = kViewSepColor;
    
    UILabel *titleL = [self createLabelOnTargetView:targetView withFrame:CGRectMake(kHRMarginX, 0, 110, targetView.height - 1)];
    self.subFieldTitleL = titleL;
    [titleL setLabelTextColor:kColorHex(@"#333333") text:title withFont:15];
    
    UIImageView *arrowIv = [[UIImageView alloc] initWithImage:kImageName(@"icon-v5_moreArrow")];
    [targetView addSubview:arrowIv];
    if (arrowFlag == YES) {
        arrowIv.frame = CGRectMake(targetView.width - kHRMarginX - arrowIv.width, (targetView.height - arrowIv.height) / 2.0, arrowIv.width, arrowIv.height);
        arrowIv.hidden = NO;
    } else {
        arrowIv.hidden = YES;
        arrowIv.frame = CGRectMake(targetView.width - kHRMarginX - arrowIv.width, (targetView.height - arrowIv.height) / 2.0, 0.01, arrowIv.height);
    }
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectChangeTypeOperate:)];
    UILabel *selectL = [self createLabelOnTargetView:targetView withFrame:CGRectMake(CGRectGetMaxX(titleL.frame), 0, targetView.width - CGRectGetMaxX(titleL.frame) - 8 - kHRMarginX - arrowIv.width, targetView.height - 1)];
    [selectL setLabelTextColor:kColorHex(@"#666666") text:placeholder withFont:13];
    selectL.textAlignment = NSTextAlignmentRight;
    selectL.numberOfLines = 0;
    self.targetL = selectL;
    selectL.lineBreakMode = NSLineBreakByCharWrapping;
    if (arrowIv) {
        [self addGestureRecognizer:tapGes];        
    } else {
        
    }
}

- (void)setTargetTag:(NSInteger)targetTag {
    _targetTag = targetTag;
    self.tag = targetTag;
}

- (void)setSubTitleStr:(NSString *)subTitleStr {
    _subTitleStr = subTitleStr;
    if (self.targetF != nil) {
        self.subFieldTitleL.text = subTitleStr;
    } else {
        self.subLabelTitleL.text = subTitleStr;
    }
}

- (void)setAlertPlaceholder:(NSString *)alertPlaceholder {
    _alertPlaceholder = alertPlaceholder;
    if (self.targetF != nil) {
        self.targetF.placeholder = alertPlaceholder;
    } else {
        self.targetL.text = alertPlaceholder;
    }
}

#pragma mark -- 点击选择手势
- (void)selectChangeTypeOperate:(UITapGestureRecognizer *)tap {
    
    
}

@end
