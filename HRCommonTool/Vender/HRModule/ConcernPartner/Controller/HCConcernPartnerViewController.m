//
//  HCConcernPartnerViewController.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCConcernPartnerViewController.h"
#import "HCConcernPartnerCell.h"
#import "HCConcernPartnerModel.h"
#import "agentSubInformation.h"

static NSString *cellID = @"HCConcernPartnerCell";

@interface HCConcernPartnerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tbView;

@property (strong, nonatomic) NSMutableArray *dataArr;

@property (strong, nonatomic) UIView *noDataView;

@end

@implementation HCConcernPartnerViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    
    __weak typeof(self) weakSelf = self;
    tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getConcernPartnerList];
    }];
    tbView.mj_header.automaticallyChangeAlpha = YES;
    [tbView.mj_header beginRefreshing];
    
    self.noDataView = [self createNoneDataViewOnView:self.view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCConcernPartnerCell *cell = [HCConcernPartnerCell concernPartnerTableView:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataModel = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HCConcernPartnerModel *model = self.dataArr[indexPath.row];
    agentSubInformation * detailVc = [[agentSubInformation alloc]init];
    detailVc.partnerID = [NSString stringWithFormat:@"%@", model.partnerId];
    __weakSelf(weakSelf);
    [detailVc setBlockOperate:^(BOOL flag) {
        [weakSelf getConcernPartnerList];
    }];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170.f;
}

#pragma mark -- 获取关注合伙人列表
- (void)getConcernPartnerList {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kHRHOST, kGetConcernTypeURL];
    NSDictionary *dic = @{@"token":addTokenDefault,
                          @"type":@(1)
                          };
    [[HCNetworkTool shareTool] requestGetWithUrlStr:url requestDict:dic isLoad:NO completeBlock:^(id finishResult, NSURLSessionDataTask *requestTask) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tbView.mj_header endRefreshing];
        });
        NSDictionary *dataDic = finishResult[@"data"];
        if ([[HRNetworkTool shareTool] isCheckData:dataDic]) {
            NSArray *dataArr = dataDic[@"data"];
            if ([[HRNetworkTool shareTool] isCheckData:dataArr]) {
                [self.dataArr removeAllObjects];
                for (NSDictionary *dic in dataArr) {
                    HCConcernPartnerModel *model = [HCConcernPartnerModel concernPartnerInfoWithDic:dic];
                    [self.dataArr addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tbView reloadData];
                });
                if (dataArr.count == 0) {
                    self.noDataView.hidden = NO;
                }else{
                    self.noDataView.hidden = YES;
                }
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
@end
