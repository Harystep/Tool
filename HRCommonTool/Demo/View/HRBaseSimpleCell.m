//
//  HRBaseSimpleCell.m
//  HRCommonTool
//
//  Created by pxsl on 2019/12/12.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "HRBaseSimpleCell.h"
#import "HRBaseModel.h"

@interface HRBaseSimpleCell ()

@property (strong, nonatomic) UILabel *titleL;

@property (strong, nonatomic) UILabel *nameL;

@property (strong, nonatomic) UILabel *ageL;

@end

@implementation HRBaseSimpleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)baseSimpleTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    HRBaseSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HRBaseSimpleCell" forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    self.nameL = [self createLabelOnTargetView:self.contentView withFrame:CGRectMake(kHRMarginX, 10, 100, 15)];
    [self.nameL setLabelTextColor:kColorHex(@"#333333") text:@"" withFont:15];
    self.titleL = [self createLabelOnTargetView:self.contentView withFrame:CGRectMake(kHRMarginX, CGRectGetMaxY(self.nameL.frame) + 5, 100, 15)];
    [self.titleL setLabelTextColor:kColorHex(@"#666666") text:@"" withFont:15];
    self.ageL = [self createLabelOnTargetView:self.contentView withFrame:CGRectMake(kScreenWidth - 100 - kHRMarginX, 10, 100, 30)];
    [self.ageL setLabelTextColor:kColorHex(@"#FF7513") text:@"" withFont:15];
    self.ageL.textAlignment = NSTextAlignmentRight;
    
    UIView *sepV = [self createViewOnTargetView:self.contentView withFrame:CGRectMake(0, 49, kScreenWidth, 1)];
    sepV.backgroundColor = kColorHex(@"#f6f6f6");
}

- (void)setDataModel:(HRBaseModel *)dataModel {
    _dataModel = dataModel;
    self.titleL.text = dataModel.title;
    self.nameL.text = dataModel.title;
    self.ageL.text = [NSString stringWithFormat:@"%tu岁", dataModel.age];
}

@end
