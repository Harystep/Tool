//
//  HCActiveCodeCell.m
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCActiveCodeCell.h"
#import "HCActiveCodeModel.h"

@interface HCActiveCodeCell ()

@property (strong, nonatomic) UILabel *shopNameL;

@end

@implementation HCActiveCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)activeCodeTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    HCActiveCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HCActiveCodeCell" forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建子控件
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    UILabel *titleL = [self createLabelOnTargetView:self.contentView withFrame:CGRectMake(kHRMarginX, 0, kScreenWidth - 80, 48)];
    self.shopNameL = titleL;
    titleL.textColor = kColorHex(@"#4A4A4A");
    titleL.font = kFontSize(15);

    UIButton *copyBtn = [self createButtonOnTargetView:self.contentView withFrame:CGRectMake(kScreenWidth-40-kHRMarginX, 0, 40, 48)];
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    copyBtn.titleLabel.font = kFontSize(kMarcoWidth(15));
    [copyBtn setTitleColor:kColorHex(@"#F8692D") forState:UIControlStateNormal];
    copyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [copyBtn addTarget:self action:@selector(copyNumOperate) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *sepView = [self createViewOnTargetView:self.contentView withFrame:CGRectMake(kHRMarginX, 48, kScreenWidth - 2*kHRMarginX, 1)];
    sepView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setDataModel:(HCActiveCodeModel *)dataModel {
    _dataModel = dataModel;
    self.shopNameL.text = dataModel.secret_key;
}

- (void)copyNumOperate {
    if ([self.delegate respondsToSelector:@selector(copyNumOperateWithData:)]) {
        [self.delegate copyNumOperateWithData:self.dataModel.secret_key];
    }
}

@end
