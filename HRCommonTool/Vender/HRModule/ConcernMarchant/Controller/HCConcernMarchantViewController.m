//
//  HCConcernMarchantViewController.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCConcernMarchantViewController.h"
#import "HCConcernMarchantCell.h"
#import "HCConcernMarchantModel.h"
#import "HCMerchantInfoViewController.h"

static NSString *cellID = @"HCConcernMarchantCell";

@interface HCConcernMarchantViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tbView;

@property (strong, nonatomic) NSMutableArray *dataArr;

/** 标记是否有更多数据 */
@property (assign, nonatomic) BOOL hasMoreDataFlag;

@property (assign, nonatomic) BOOL signNewRefreshFlag;

@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) UIView *noDataView;

@end

@implementation HCConcernMarchantViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getConcernMarchantList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)];
    tbView.delegate = self;
    tbView.dataSource = self;
    self.tbView = tbView;
    tbView.backgroundColor = [UIColor whiteColor];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tbView];
    [tbView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    
    [self getConcernMarchantList];
    __weak typeof(self) weakSelf = self;
    tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getConcernMarchantList];
    }];
    tbView.mj_header.automaticallyChangeAlpha = YES;
    
    [tbView.mj_header beginRefreshing];
    
    self.noDataView = [self createNoneDataViewOnView:self.view];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCConcernMarchantCell *cell = [HCConcernMarchantCell concernMarchantTableView:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataModel = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HCConcernMarchantModel *model = self.dataArr[indexPath.row];
    HCMerchantInfoViewController *merchant = [[HCMerchantInfoViewController alloc] init];
    merchant.store_id = [NSString stringWithFormat:@"%@",model.marchantId];
    [self.navigationController pushViewController:merchant animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170.f;
}

#pragma mark -- 获取关注商户列表
- (void)getConcernMarchantList {
    NSString *url = [NSString stringWithFormat:@"%@%@", kHRHOST, kGetConcernTypeURL];
    NSDictionary *dic = @{@"token":addTokenDefault,
                          @"type":@(2)
                          };
    [[HCNetworkTool shareTool] requestGetWithUrlStr:url requestDict:dic isLoad:NO completeBlock:^(id finishResult, NSURLSessionDataTask *requestTask) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tbView.mj_header endRefreshing];
        });
        NSDictionary *dataDic = finishResult[@"data"];
        if ([[HRNetworkTool shareTool] isCheckData:dataDic]) {
            NSInteger pre_page = [finishResult[@"per_page"] integerValue];
            NSArray *dataArr = dataDic[@"data"];
            if ([[HRNetworkTool shareTool] isCheckData:dataArr]) {
                [self.dataArr removeAllObjects];
                for (NSDictionary *dic in dataArr) {
                    HCConcernMarchantModel *model = [HCConcernMarchantModel concernMarchantInfoWithDic:dic];
                    [self.dataArr addObject:model];
                }
                if (dataArr.count == pre_page) {
                    self.hasMoreDataFlag = YES;
                }else{
                    self.hasMoreDataFlag = NO;
                }
                if (dataArr.count == 0) {
                    self.noDataView.hidden = NO;
                }else{
                    self.noDataView.hidden = YES;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tbView reloadData];
                });
            }else{
                [[MBProgressController sharedInstance] showTipsOnlyText:@"服务器发生异常,请稍后··" AndDelay:1.0];
            }
        }else{
            [[MBProgressController sharedInstance] showTipsOnlyText:@"服务器发生异常,请稍后··" AndDelay:1.0];
        }
    } failBlock:^(id failResult, NSURLSessionDataTask *requestTask) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tbView.mj_header endRefreshing];
        });        
    }];
}

- (void)getMoreConcernList{
    if (self.hasMoreDataFlag) {
        self.signNewRefreshFlag = YES;
        self.currentPage ++;
        
    } else {
        self.signNewRefreshFlag = NO;
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tbView.mj_footer endRefreshingWithNoMoreData];
        });
    }
}

@end
