//
//  HCActiveCodeViewController.m
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCActiveCodeViewController.h"
#import "HCActiveCodeListViewController.h"
#import "HCShopSelectListViewController.h"
#import "HCAlertCreateCodeView.h"
#import "HCActiveCodeListViewController.h"
#import "HCShopModel.h"

@interface HCActiveCodeViewController () <HCAlertCreateCodeViewDelegate, HCShopSelectListViewControllerDelegate>

@property (strong, nonatomic) UIButton *maskBtn;

@property (strong, nonatomic) HCAlertCreateCodeView *codeView;

@property (strong, nonatomic) UILabel *shopNameL;
/** 选择生成门店信息 */
@property (strong, nonatomic) HCShopModel *selectModel;

@end

@implementation HCActiveCodeViewController

- (HCAlertCreateCodeView *)codeView {
    if (_codeView == nil) {
        _codeView = [[HCAlertCreateCodeView alloc] initWithFrame:CGRectMake(20, (kScreenHeight - 200) / 2, kScreenWidth - 20 * 2, 200)];
        _codeView.delegate = self;
    }
    return _codeView;
}

- (UIButton *)maskBtn {
    if (_maskBtn == nil) {
        _maskBtn = [[UIButton alloc] init];
        _maskBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _maskBtn.backgroundColor = [UIColor blackColor];
        _maskBtn.alpha = 0.2;
    }
    return _maskBtn;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setItemAttributes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建item
    [self setRightItemView];
    //创建选择门店视图
    [self createSelectShopView];
}
#pragma mark -- 创建选择门店视图
- (void)createSelectShopView {
    UIView *contentView = [self createViewOnTargetView:self.view withFrame:CGRectMake(0, 10, kScreenWidth, 60)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectShopOperate)];
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView addGestureRecognizer:tap];
    
    UILabel *shopNameL = [self createLabelOnTargetView:contentView withFrame:CGRectMake(kHRMarginX, 0, kScreenWidth-kHRMarginX-2*kHRMarginX, contentView.height-1)];
    shopNameL.font = kFontSize(16);
    shopNameL.text = @"请选择门店";
    self.shopNameL = shopNameL;
    shopNameL.textColor = kColorHex(@"#333333");
    
    UIImageView *arrowIv = [self createImageViewOnTargetView:contentView withFrame:CGRectMake(kScreenWidth - 2*kHRMarginX, (contentView.height - 16)/2, 16, 16)];
    arrowIv.image = [UIImage imageNamed:@"向右拷贝"];
    arrowIv.contentMode = UIViewContentModeCenter;
    
    UIView *sepView = [self createViewOnTargetView:contentView withFrame:CGRectMake(0, CGRectGetMaxY(shopNameL.frame), kScreenWidth, 1)];
    sepView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton *sureBtn = [self createButtonOnTargetView:self.view withFrame:CGRectMake(kHRMarginX, CGRectGetMaxY(contentView.frame)+105, kScreenWidth-2*kHRMarginX, 40)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.backgroundColor = kColorHex(@"#F8692D");
    [sureBtn addTarget:self action:@selector(sureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setCornerRadius:5];
    
}

#pragma mark -- 确定生成激活码
- (void)sureBtnDidClick {    
    
    NSString *url = kCreateActiveCode;
    if (self.selectModel != nil) {
        NSDictionary *dict = @{@"store_id":self.selectModel.store_id};
        __weakSelf(weakSelf);
        [HRCommonRequest requestCreateShopActiveCodeWithURL:url parmars:dict success:^(id  _Nonnull response) {
            NSString *secret_key = response[@"secret_key"];
            if ([[HRNetworkTool shareTool] isCheckData:secret_key]) {
                if (secret_key.length > 0) {
                    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"生成激活码" message:[NSString stringWithFormat:@"%@%@\n%@", @"已生成激活码: ", secret_key, @"可在列表中查看"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sureAc = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        HCActiveCodeListViewController *listVc = [[HCActiveCodeListViewController alloc] init];
                        listVc.store_id = weakSelf.selectModel.store_id;
                        listVc.store_name = weakSelf.selectModel.store_name;
                        [weakSelf.navigationController pushViewController:listVc animated:YES];
                    }];
                    [alertVc addAction:sureAc];
                    [weakSelf presentViewController:alertVc animated:YES completion:nil];

                }
            }
        } failure:^(NSError * _Nonnull error) {
            
        }];
    } else {
        [[MBProgressController sharedInstance] showTipsOnlyText:@"请先选择门店信息" AndDelay:1.5];
    }
    
    
}

#pragma mark -- HCAlertCreateCodeViewDelegate
- (void)sureCreateActiveCodeOperate {
    self.maskBtn.hidden = YES;
    self.codeView.hidden = YES;
    
    HCActiveCodeListViewController *listVc = [[HCActiveCodeListViewController alloc] init];
    [self.navigationController pushViewController:listVc animated:YES];
}

#pragma mark -- 选择门店操作
- (void)selectShopOperate {
    HCShopSelectListViewController *shopVc = [[HCShopSelectListViewController alloc] init];
    shopVc.store_id = self.store_id;
    shopVc.title = @"选择门店";
    shopVc.delegate = self;
    [self.navigationController pushViewController:shopVc animated:YES];
}

#pragma mark -- HCShopSelectListViewControllerDelegate
- (void)sureSelectShopModel:(HCShopModel *)model {
    self.shopNameL.text = model.store_name;
    self.selectModel = model;
}

#pragma mark -- 激活码列表
- (void)activeCodeListDidClick {
    HCActiveCodeListViewController *listVc = [[HCActiveCodeListViewController alloc] init];
    listVc.store_id = self.store_id;
    listVc.store_name = self.store_name;
    [self.navigationController pushViewController:listVc animated:YES];
}

- (void)setRightItemView {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"列表" style:UIBarButtonItemStylePlain target:self action:@selector(activeCodeListDidClick)];
    [self.navigationItem.rightBarButtonItem setTintColor:kColorHex(@"#FF0B0B")];
}

- (void)setItemAttributes {
    UIFont *font = kFontSize(15);
    NSDictionary *dic = @{NSFontAttributeName:font,
                          };
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dic forState:UIControlStateNormal];
}



@end
