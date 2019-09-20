//
//  HCShopCell.m
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCShopCell.h"
#import "HCShopModel.h"

static NSString *shopID = @"HCShopCell";

@interface HCShopCell ()

@property (strong, nonatomic) UILabel *shopNameL;

@property (strong, nonatomic) UIButton *iconBtn;

@end

@implementation HCShopCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

+ (instancetype)shopTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    HCShopCell *cell = [tableView dequeueReusableCellWithIdentifier:shopID forIndexPath:indexPath];
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
    
    UILabel *titleL = [self createLabelOnTargetView:self.contentView withFrame:CGRectMake(kHRMarginX, 0, kScreenWidth - 2 * kHRMarginX - 30, 48)];
    self.shopNameL = titleL;
    titleL.textColor = kColorHex(@"#333333");
    titleL.font = kFontSize(15);
    
    UIButton *selectBtn = [self createButtonOnTargetView:self.contentView withFrame:CGRectMake(kScreenWidth - 3 * kHRMarginX, (self.height - 30)/2, 30, 30)];
    self.iconBtn = selectBtn;
    [selectBtn setImage:[UIImage imageNamed:@"icon_v6_shop_nor"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"icon_v6_shop_sel"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectCellOperate:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *sepView = [self createViewOnTargetView:self.contentView withFrame:CGRectMake(kHRMarginX, 48, kScreenWidth - 2*kHRMarginX, 1)];
    sepView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setDataModel:(HCShopModel *)dataModel {
    _dataModel = dataModel;
    if (self.downFlag) {
        self.iconBtn.hidden = YES;
    }
    self.shopNameL.text = [[HRNetworkTool shareTool] stringUserfulContent:dataModel.store_name];
    if (self.storeID != nil) {
        if ([self.storeID isEqualToString:dataModel.store_id]) {
            self.iconBtn.selected = YES;
        } else {
            self.iconBtn.selected = NO;
        }
    } else {
        self.iconBtn.selected = NO;
    }
}
#pragma mark -- 选中数据
- (void)selectCellOperate:(UIButton *)sender {
    sender.selected = YES;
    if ([self.delegate respondsToSelector:@selector(shopCellSelectData:)]) {
        [self.delegate shopCellSelectData:self.dataModel];
    }
}

@end
