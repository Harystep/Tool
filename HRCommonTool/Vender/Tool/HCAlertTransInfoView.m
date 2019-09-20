


#import "HCAlertTransInfoView.h"

@interface HCAlertTransInfoView ()

@property (strong, nonatomic) UILabel *detailTwoL;

@end

@implementation HCAlertTransInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColorHex(@"#ffffff");
        [self createSubViews];
    }
    return self;
}
#pragma mark -- 添加子控件
- (void)createSubViews {
    
    CGFloat marginX = kMarcoWidth(40.0);
    
    UILabel *titleL = [self createLabelOnTargetView:self withFrame:CGRectMake(kHRMarginX, kHRMarginX, 100, 20)];
    [titleL setLabelTextColor:kColorHex(@"#FF6B21") text:@"名词说明" withFont:16];
    [titleL setFontBold:16];
    
//    UILabel *oneL = [self createLabelOnTargetView:self withFrame:CGRectMake(kHRMarginX, CGRectGetMaxY(titleL.frame)+15, 60, 16)];
//    [oneL setLabelTextColor:kColorHex(@"#333333") text:@"交易额：" withFont:14];
    
    NSString *oneContent = @"交易额：直属商户实际交易金额，计算规则为:收款金额 — 退款金额";
    CGFloat height = [[HRNetworkTool shareTool] compareContentHeight:oneContent withFont:14 widthLimited:kScreenWidth-marginX*2-kHRMarginX*2];
    UILabel *oneDetailL = [self createLabelOnTargetView:self withFrame:CGRectMake(kHRMarginX, CGRectGetMaxY(titleL.frame)+10, kScreenWidth-marginX*2-kHRMarginX*2, height)];;
    oneDetailL.numberOfLines = 0;
    oneDetailL.lineBreakMode = NSLineBreakByCharWrapping;
    [oneDetailL setLabelTextColor:kColorHex(@"#383838") text:oneContent withFont:14];
    
    
//    UILabel *twoL = [self createLabelOnTargetView:self withFrame:CGRectMake(kHRMarginX, CGRectGetMaxY(oneDetailL.frame)+10, 75, 16)];
//    [twoL setLabelTextColor:kColorHex(@"#333333") text:@"交易笔数：" withFont:14];
    
    NSString *twoContent = @"交易笔数：直属商户收款笔数，包含退款交易";
    CGFloat heightTwo = [[HRNetworkTool shareTool] compareContentHeight:twoContent withFont:14 widthLimited:kScreenWidth-marginX*2-kHRMarginX*2];
    
    UILabel *twoDetailL = [self createLabelOnTargetView:self withFrame:CGRectMake(kHRMarginX, CGRectGetMaxY(oneDetailL.frame)+10, kScreenWidth-marginX*2-kHRMarginX*2, heightTwo)];;
    self.detailTwoL = twoDetailL;
    [twoDetailL setLabelTextColor:kColorHex(@"#383838") text:twoContent withFont:14];
    twoDetailL.numberOfLines = 0;
    twoDetailL.lineBreakMode = NSLineBreakByCharWrapping;
    
//    [self layoutSubviews];
    
}

- (void)layoutSubviews {    
    self.frame = CGRectMake(kMarcoWidth(40), (kScreenHeight - CGRectGetMaxY(self.detailTwoL.frame)+10)/2, kScreenWidth-kMarcoWidth(40)*2, CGRectGetMaxY(self.detailTwoL.frame)+16);
}

@end
