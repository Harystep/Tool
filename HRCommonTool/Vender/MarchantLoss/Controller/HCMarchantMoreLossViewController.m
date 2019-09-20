//
//  HCMarchantMoreLossViewController.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCMarchantMoreLossViewController.h"
#import "HCMarchantLossCell.h"
#import "HCMarchantLossModel.h"
#import "HCMerchantInfoViewController.h"

@interface HCMarchantMoreLossViewController ()<UITableViewDataSource, UITableViewDelegate>

//@property (strong, nonatomic) UITableView *tbView;
//
//@property (strong, nonatomic) NSMutableArray *dataArr;

@property (assign, nonatomic) NSInteger currentPage;
/** 标记是否有更多数据 */
@property (assign, nonatomic) BOOL hasMoreDataFlag;

@property (assign, nonatomic) BOOL signNewRefreshFlag;

@property (strong, nonatomic) UIView *noDataView;

@end

static NSString *cellID = @"HCMarchantLossCell";

@implementation HCMarchantMoreLossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tbView.frame = CGRectMake(0, 0, kWide_breadth, kHeight_breadth-kTopHeight-kHRTabbarSafeBottomHeight-70);
    [self.tbView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    self.noDataView = [self createNoneDataViewOnView:self.view];
    self.header = YES;
    self.footer = YES;
    
    [self.tbView.mj_header beginRefreshing];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCMarchantLossCell *cell = [HCMarchantLossCell marchantLossTableView:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataModel = self.dataArr[indexPath.row];
    [self addTapGesOnView:cell.phoneL];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 106.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HCMarchantLossModel *model = self.dataArr[indexPath.row];
    HCMerchantInfoViewController *merchant = [[HCMerchantInfoViewController alloc] init];
    merchant.store_id = [NSString stringWithFormat:@"%@",model.store_id];
    [self.navigationController pushViewController:merchant animated:YES];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.frame.size;
    if ((offset.y > 0) && (offset.y + size.height > scrollView.contentSize.height + 40)) {
        if (self.signNewRefreshFlag) return;
        [self getMoreDataOperateInfo];
    } else if (offset.y < -64) {
        
    }
}

-(void)addTapGesOnView:(UILabel *)label {
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhone:)];
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:tapGes];
}

- (void)clickPhone:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)tap.view;
    if (label.text.length>0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",label.text]]];
    }
}
#pragma mark -- 获取商户信息
- (void)getBaseOperateInfo {
    NSString *url = [NSString stringWithFormat:@"%@%@", kHRHOST, kGetBusinessWarningURL];
    self.currentPage = 1;
    NSDictionary *dict = @{@"token":[[HRNetworkTool shareTool] stringUserfulContent:addTokenDefault],
                           @"page":@(self.currentPage),
                           @"period":@(4)
                           };
    [[HCNetworkTool shareTool] requestGetWithUrlStr:url requestDict:dict isLoad:NO completeBlock:^(id finishResult, NSURLSessionDataTask *requestTask) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tbView.mj_header endRefreshing];
            [self.tbView.mj_footer resetNoMoreData];
        });
        if ([finishResult[@"status"] integerValue] == 1) {
            
            NSDictionary *dataDic = finishResult[@"data"];
            if ([[HRNetworkTool shareTool] isCheckData:dataDic]) {
                NSArray *dataArr = dataDic[@"data"];
                NSInteger pre_page = [dataDic[@"per_page"] integerValue];
                if ([[HRNetworkTool shareTool] isCheckData:dataArr]) {
                    [self.dataArr removeAllObjects];
                    if (dataArr.count>0) {
                        for (NSDictionary *dic in dataArr) {
                            HCMarchantLossModel *model = [HCMarchantLossModel marchantLossInfoWithDic:dic];
                            [self.dataArr addObject:model];
                        }
                        self.noDataView.hidden = YES;
                    }else{
                        self.noDataView.hidden = NO;
                    }
                    if (dataArr.count == pre_page) {
                        self.hasMoreDataFlag = YES;
                    }else{
                        self.hasMoreDataFlag = NO;
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
        }
    } failBlock:^(id failResult, NSURLSessionDataTask *requestTask) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tbView.mj_header endRefreshing];
        });
    }];
}

- (void)getMoreDataOperateInfo {
    if (self.hasMoreDataFlag) {
        self.signNewRefreshFlag = YES;
        self.currentPage ++;
        NSString *url = [NSString stringWithFormat:@"%@%@", kHRHOST, kGetBusinessWarningURL];
        NSDictionary *dict = @{@"token":[[HRNetworkTool shareTool] stringUserfulContent:addTokenDefault],
                               @"page":@(self.currentPage),
                               @"period":@(4)
                               };
        HCLog(@"%@", dict);
        [[HCNetworkTool shareTool] requestGetWithUrlStr:url requestDict:dict isLoad:NO completeBlock:^(id finishResult, NSURLSessionDataTask *requestTask) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tbView.mj_footer endRefreshing];
            });
            if ([finishResult[@"status"] integerValue] == 1) {
                
                NSDictionary *dataDic = finishResult[@"data"];
                if ([[HRNetworkTool shareTool] isCheckData:dataDic]) {
                    NSArray *dataArr = dataDic[@"data"];
                    NSInteger pre_page = [dataDic[@"per_page"] integerValue];
                    if ([[HRNetworkTool shareTool] isCheckData:dataArr]) {
                        if (dataArr.count>0) {
                            for (NSDictionary *dic in dataArr) {
                                HCMarchantLossModel *model = [HCMarchantLossModel marchantLossInfoWithDic:dic];
                                [self.dataArr addObject:model];
                            }
                        }
                        if (dataArr.count == pre_page) {
                            self.hasMoreDataFlag = YES;
                        }else{
                            self.hasMoreDataFlag = NO;
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tbView reloadData];
                        });
                    }else{
                        self.currentPage --;
                        [[MBProgressController sharedInstance] showTipsOnlyText:@"服务器发生异常,请稍后··" AndDelay:1.0];
                    }
                }else{
                    self.currentPage --;
                    [[MBProgressController sharedInstance] showTipsOnlyText:@"服务器发生异常,请稍后··" AndDelay:1.0];
                }
            } else{
                self.currentPage --;
            }
                
        } failBlock:^(id failResult, NSURLSessionDataTask *requestTask) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tbView.mj_footer endRefreshing];
            });
            self.currentPage --;
        }];
    } else {
        self.signNewRefreshFlag = NO;
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tbView.mj_footer endRefreshingWithNoMoreData];
        });
    }
}


@end
