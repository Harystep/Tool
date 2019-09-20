//
//  HCActiveCodeListViewController.m
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCActiveCodeListViewController.h"
#import "HCActiveCodeCell.h"
#import "HCActiveCodeModel.h"
#import "HCShopSelectDownView.h"
#import "HCShopModel.h"

static NSString *cellID = @"HCActiveCodeCell";

@interface HCActiveCodeListViewController () <HCActiveCodeCellDelegate, HCShopSelectDownViewDelegate>

@property (strong, nonatomic) UIView *topView;
/** 标记是否点击筛选标题按钮 */
@property (assign, nonatomic) BOOL shopListFlag;

@property (strong, nonatomic) UIButton *maskBtn;

@property (strong, nonatomic) UIView *topTitleView;

/** 标题 */
@property (strong, nonatomic) UILabel *titleL;

@property (strong, nonatomic) UIImageView *arrowIv;

@property (strong, nonatomic) HCShopSelectDownView *shopSelectDownView;

@end

@implementation HCActiveCodeListViewController

- (HCShopSelectDownView *)shopSelectDownView {
    if (_shopSelectDownView == nil) {
        _shopSelectDownView = [[HCShopSelectDownView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height/2) withStoreID:self.store_id];
        _shopSelectDownView.hidden = YES;
        _shopSelectDownView.delegate = self;
    }
    return _shopSelectDownView;
}

- (UIButton *)maskBtn {
    if (_maskBtn == nil) {
        _maskBtn = [[UIButton alloc] init];
        _maskBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _maskBtn.backgroundColor = [UIColor blackColor];
        [_maskBtn addTarget:self action:@selector(maskBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        _maskBtn.alpha = 0.1;
        _maskBtn.hidden = YES;
    }
    return _maskBtn;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setSubTitleView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTopView];
    
    self.backBtn.hidden = NO;
    self.tbView.frame = CGRectMake(0, self.topView.height, kScreenWidth, kScreenHeight - self.topView.height - kHRTabbarSafeBottomHeight - kTopHeight);
    [self.tbView registerClass:[HCActiveCodeCell class] forCellReuseIdentifier:cellID];
    self.noHaveView = [self createNoneDataViewOnTargetView:self.view withImage:kImageName(@"icon_v6_active_noneData") withContent:@"该门店还没有已生成的激活码"];
    
    [self getActiveCodeList];
}

#pragma mark -- UITableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCActiveCodeCell *cell = [HCActiveCodeCell activeCodeTableView:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.dataModel = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.f;
}

#pragma mark -- HCActiveCodeCellDelegate
- (void)copyNumOperateWithData:(NSString *)codeStr {
    if (codeStr != nil) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = codeStr;
        [[MBProgressController sharedInstance] showTipsOnlyText:@"复制成功" AndDelay:1.5];
    }
}

#pragma mark -- 获取门店激活码信息
- (void)getActiveCodeList {
    NSString *url = kGetShopActiveCodeList;
    NSDictionary *dict = @{@"store_id":self.store_id};
    __weakSelf(weakSelf);
    [HRCommonRequest requesShopActiveCodeListWithURL:url parmars:dict success:^(id  _Nonnull response) {
        NSArray *dataArr = response;
        [weakSelf.dataArr removeAllObjects];
        if (dataArr.count > 0) {
            weakSelf.noHaveView.hidden = YES;
            for (NSDictionary *dic in dataArr) {
                HCActiveCodeModel *model = [HCActiveCodeModel activeCodeInfoWithDic:dic];
                [weakSelf.dataArr addObject:model];
            }
        } else {
            weakSelf.noHaveView.hidden = NO;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView reloadData];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -- 创建顶部视图
- (void)createTopView {
    self.topView = [self createViewOnTargetView:self.view withFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    self.topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *titleL = [self createLabelOnTargetView:self.topView withFrame:CGRectMake(kHRMarginX, 0, 200, self.topView.height-1)];
    titleL.text = @"微收银激活码";
    titleL.font = kFontSize(kMarcoWidth(15));
    
    UILabel *desL = [self createLabelOnTargetView:self.topView withFrame:CGRectMake(kScreenWidth - kHRMarginX - 40, 0, 40, self.topView.height-1)];
    desL.text = @"操作";
    desL.textAlignment = NSTextAlignmentRight;
    desL.font = kFontSize(kMarcoWidth(15));
    
    UIView *sepView = [self createViewOnTargetView:self.topView withFrame:CGRectMake(kHRMarginX, desL.height, kScreenWidth - 2*kHRMarginX, 1)];
    sepView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}
#pragma mark -- 设置titleView
- (void)setSubTitleView {

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(80, 0, kScreenWidth - 100, 44)];
    self.topTitleView = titleView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTitleOperate)];
    [titleView addGestureRecognizer:tap];
    
    UILabel *titleL = [self createLabelOnTargetView:titleView withFrame:CGRectMake(0, 0, titleView.width, titleView.height)];
    self.titleL = titleL;
    UIImageView *imageIv = [[UIImageView alloc] initWithImage:kImageName(@"icon_v6_shopArrow_down")];
    self.arrowIv = imageIv;
    [titleView addSubview:imageIv];
    
    [self setSubTitleViewValue];
    
    self.navigationItem.titleView = titleView;
}

- (void)setSubTitleViewValue {
    [self.titleL setLabelTextColor:kColorHex(@"#000000") text:self.store_name withFont:17];
    CGSize size = [self.titleL sizeFromContentWithSize:CGSizeMake(MAXFLOAT, 20) content:self.store_name withFont:kFontSize(17)];
    if (size.width > self.topTitleView.width - 20) {
        self.titleL.frame = CGRectMake(0, 0, self.topTitleView.width - 20, self.topTitleView.height);
    } else {
        self.titleL.frame = CGRectMake((self.topTitleView.width - self.arrowIv.width - size.width - 5)/2, 0, size.width + 5, self.topTitleView.height);
    }
    self.arrowIv.frame = CGRectMake(CGRectGetMaxX(self.titleL.frame) + 2, (self.topTitleView.height - self.arrowIv.height)/2, self.arrowIv.width, self.arrowIv.height);
}

#pragma mark -- 选择店铺
- (void)selectTitleOperate {
    [self.view addSubview:self.maskBtn];
    [self.view addSubview:self.shopSelectDownView];
    [self changeViewType];
    self.arrowIv.transform = CGAffineTransformRotate(self.arrowIv.transform, -M_PI);
}

- (void)maskBtnDidClick {
    [self changeViewType];
    self.arrowIv.transform = CGAffineTransformIdentity;
}

#pragma mark -- HCShopSelectDownViewDelegate
- (void)shopDownViewSelectIndexPath:(HCShopModel *)model {
    [self maskBtnDidClick];
    self.store_name = model.store_name;
    self.store_id = model.store_id;
    [self setSubTitleViewValue];
    
    [self getActiveCodeList];
}

- (void)changeViewType {
    self.maskBtn.hidden = !self.maskBtn.hidden;
    self.shopSelectDownView.hidden = !self.shopSelectDownView.hidden;
}

@end
