//
//  YHMySimpleCell.m
//  HRCommonTool
//
//  Created by pxsl on 2019/12/11.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "YHMySimpleCell.h"
#import "YHMySimpleModel.h"

@interface YHMySimpleCell ()

@property (strong, nonatomic) UIImageView *iconIv;

@property (strong, nonatomic) UILabel *titleL;

@property (strong, nonatomic) UIImageView *arrowIv;

@end

@implementation YHMySimpleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)mySimpleTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    YHMySimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHMySimpleCell" forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
        self.backgroundColor = kColorHex(@"#ffffff");
    }
    return self;
}

- (void)createSubViews {
    self.iconIv = [self createImageViewOnTargetView:self.contentView withFrame:CGRectMake(kHRMarginX, 10, 30, 30)];
    self.iconIv.backgroundColor = kColorHex(@"#f6f6f6");
    [self.iconIv setCornerRadius:self.iconIv.height / 2.0];
    self.titleL = [self createLabelOnTargetView:self.contentView withFrame:CGRectMake(CGRectGetMaxX(self.iconIv.frame) + 10, 10, 200, 30)];
    [self.titleL setLabelTextColor:kColorHex(@"#333333") text:@"" withFont:kMarcoWidth(16.0)];
    self.arrowIv = [self createImageViewOnTargetView:self.contentView withFrame:CGRectMake(kScreenWidth - kHRMarginX - 9, (50 - 16) / 2.0, 8, 12)];
    self.arrowIv.contentMode = UIViewContentModeCenter;
    self.arrowIv.alpha = 0.7;
    
    UIView *sepView = [self createViewOnTargetView:self.contentView withFrame:CGRectMake(kHRMarginX, 49, kScreenWidth - 2 * kHRMarginX, 1)];
    sepView.backgroundColor = kColorHex(@"#f6f6f6");
}

- (void)setDataModel:(YHMySimpleModel *)dataModel {
    _dataModel = dataModel;
    self.iconIv.image = kImageName(dataModel.iconStr);
    self.titleL.text = dataModel.title;
    if (dataModel.isArrow) {
        self.arrowIv.hidden = NO;
        self.arrowIv.image = kImageName(@"icon_moreArrow");
    } else {
        self.arrowIv.hidden = YES;
    }
}

@end
