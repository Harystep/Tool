//
//  HCShopSelectListViewController.m
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCShopSelectListViewController.h"
#import "HCShopModel.h"
#import "HCShopCell.h"
#import "HCSimpleSearchView.h"

static NSString *cellID = @"HCShopCell";

@interface HCShopSelectListViewController () <HCSimpleSearchViewDelegate, HCShopCellDelegate>

@property (strong, nonatomic) HCSimpleSearchView *searchView;

@property (assign, nonatomic) NSInteger currentPage;
/** 搜索关键字 */
@property (copy, nonatomic) NSString *searchKey;
/** 标注加载更多数据 */
@property (assign, nonatomic) BOOL loadMoreDataFlag;
/** 标记正在刷新 */
@property (assign, nonatomic) BOOL isNewRefreshFlag;
/** 被选中的model */
@property (strong, nonatomic) HCShopModel *selectModel;

@property (strong, nonatomic) UIButton *maskBtn;

@end

@implementation HCShopSelectListViewController

- (UIButton *)maskBtn {
    if (_maskBtn == nil) {
        _maskBtn = [[UIButton alloc] init];
        _maskBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _maskBtn.backgroundColor = [UIColor blackColor];
        _maskBtn.alpha = 0.02;
        [_maskBtn addTarget:self action:@selector(maskBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskBtn;
}

- (HCSimpleSearchView *)searchView {
    if (_searchView == nil) {
        _searchView = [[HCSimpleSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) withCancelType:0];
        _searchView.delegate = self;
        _searchView.textField.font = kFontSize(15);
        _searchView.placeStr = @"搜索门店名称";
    }
    return _searchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backBtn.hidden = NO;
    [self.view addSubview:self.searchView];    
    self.tbView.frame = CGRectMake(0, self.searchView.height, kScreenWidth, kScreenHeight - kHRTabbarSafeBottomHeight - kTopHeight - self.searchView.height - 76);
    [self.tbView registerClass:[HCShopCell class] forCellReuseIdentifier:cellID];
    self.currentPage = 1;
    
    self.header = YES;
    self.footer = YES;
    
    [self.tbView.mj_header beginRefreshing];
    
    UIButton *sureBtn = [self createButtonOnTargetView:self.view withFrame:CGRectMake(kHRMarginX, CGRectGetMaxY(self.tbView.frame) + kHRMarginX, kScreenWidth - 2 * kHRMarginX, 46)];
    [sureBtn addTarget:self action:@selector(sureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setButtonTextColor:kColorHex(@"#ffffff") text:@"确定" withFont:16];
    [sureBtn setCornerRadius:5];
    sureBtn.backgroundColor = kColorHex(@"#F8692D");
    
}
#pragma mark -- UITableViewDelegate 代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCShopCell *cell = [HCShopCell shopTableView:tableView indexPath:indexPath];
    cell.storeID = self.selectModel.store_id;
    cell.dataModel = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    self.selectModel = self.dataArr[indexPath.row];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tbView reloadData];
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.f;
}

#pragma mark -- 获取门店信息
- (void)getBaseOperateInfo {
    self.loadMoreDataFlag = NO;
    self.currentPage = 1;
    self.searchKey = @"";
    self.searchView.textField.text = @"";
    [self getShopListInfo];
}
#pragma mark -- 加载更多数据
- (void)getMoreDataOperateInfo {
    self.loadMoreDataFlag = YES;
    self.currentPage ++;
    self.isNewRefreshFlag = YES;
    [self getShopListInfo];
}

- (void)getShopListInfo {
    NSString *url = kGetShopListInfo;
    NSDictionary *parmars = @{@"store_id":[[HRNetworkTool shareTool] stringUserfulContent:self.store_id],
                              @"token":[[HRNetworkTool shareTool] stringUserfulContent:addTokenDefault],
                              @"page":@(self.currentPage),
                              @"getField":@"1",
                              @"includingMain":@"1",
                              @"search":[[HRNetworkTool shareTool] stringUserfulContent:self.searchKey]
                              };
    __weakSelf(weakSelf);
    HCLog(@"%@", parmars);
    [HRCommonRequest requestShopListInfoWithURL:url parmars:parmars success:^(id  _Nonnull response) {
        HCLog(@"%@", response);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView.mj_footer endRefreshing];
            [weakSelf.tbView.mj_header endRefreshing];
            weakSelf.isNewRefreshFlag = NO;
        });
        NSArray *dataArr = response;
        if (dataArr.count > 0) {
            if (weakSelf.loadMoreDataFlag) {
            } else {
                [weakSelf.dataArr removeAllObjects];
            }
            weakSelf.noHaveView.hidden = YES;
            for (NSDictionary *dic in dataArr) {
                HCShopModel *model = [HCShopModel shopInfoWithDic:dic];
                [weakSelf.dataArr addObject:model];
            }
        } else {
            if (weakSelf.loadMoreDataFlag) {
            } else {
                [weakSelf.dataArr removeAllObjects];
                weakSelf.noHaveView.hidden = NO;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView reloadData];
        });
    } failure:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView.mj_footer endRefreshing];
            [weakSelf.tbView.mj_header endRefreshing];
            weakSelf.isNewRefreshFlag = NO;
        });
    }];
}
#pragma mark -- HCSimpleSearchViewDelegate
/** 搜索 */
- (void)textFieldSearchValue:(NSString *)value {
    self.loadMoreDataFlag = NO;
    self.searchKey = value;
    self.maskBtn.hidden = YES;
    [self getShopListInfo];
}
/** 开始编辑 */
- (void)textFieldDidStartEditing {
    [self.view addSubview:self.maskBtn];
    self.maskBtn.hidden = NO;
    
}

- (void)maskBtnDidClick {
    self.maskBtn.hidden = YES;
    [self.searchView.contentView endEditing:YES];
    if (self.searchView.textField.text.length == 0) {
        [self.searchView searchTextInitType];
    }
    if (self.searchView.textField.text.length == 0) {
        self.searchKey = @"";
        [self getShopListInfo];
    }
}

#pragma mark -- HCShopCellDelegate
- (void)shopCellSelectData:(HCShopModel *)model{
    self.selectModel = model;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tbView reloadData];
    });
}
#pragma mark -- 确定选择
- (void)sureBtnDidClick {
    if (self.selectModel == nil) {
        [[MBProgressController sharedInstance] showTipsOnlyText:@"请选择门店" AndDelay:1.5];
    } else {
        if([self.delegate respondsToSelector:@selector(sureSelectShopModel:)]) {
            [self.delegate sureSelectShopModel:self.selectModel];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
