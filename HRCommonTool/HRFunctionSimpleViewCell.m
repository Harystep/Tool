//
//  HRFunctionSimpleView.m
//  HRCommonTool
//
//  Created by pxsl on 2019/12/6.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "HRFunctionSimpleViewCell.h"

@interface HRFunctionSimpleViewCell ()

@property (strong, nonatomic) UIImageView *itemIv;

@property (strong, nonatomic) UILabel *titleL;

@end

@implementation HRFunctionSimpleViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    CGFloat width = (kWIDTH - 2 * kHRMarginX) / 4.0;
    UIImageView *itemIv = [self createImageViewOnTargetView:self.contentView withFrame:CGRectMake((width - 20)/2.0, 10, 20, 30)];
    itemIv.backgroundColor = kColorHex(@"#666666");
    self.itemIv = itemIv;
    
    UILabel *titleL = [self createLabelOnTargetView:self.contentView withFrame:CGRectMake(0, CGRectGetMaxY(itemIv.frame) + 15, width, 20)];
    self.titleL = titleL;
    titleL.textAlignment = NSTextAlignmentCenter;
    [titleL setLabelTextColor:kColorHex(@"#333333") text:@"" withFont:13];
    
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    self.itemIv.image = kImageName(dataDic[@"image"]);
    self.titleL.text = dataDic[@"title"];
}

@end
