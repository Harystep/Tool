//
//  HCShopSelectDownView.m
//  HczyJtb
//
//  Created by pxsl on 2019/9/11.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import "HCShopSelectDownView.h"
#import "HCShopCell.h"
#import "HCShopModel.h"


static NSString *cellID = @"HCShopCell";

@interface HCShopSelectDownView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tbView;

@property (assign, nonatomic) NSInteger currentPage;

/** 标注加载更多数据 */
@property (assign, nonatomic) BOOL loadMoreDataFlag;
/** 标记正在刷新 */
@property (assign, nonatomic) BOOL isNewRefreshFlag;

@property (copy, nonatomic) NSString *storeID;

@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation HCShopSelectDownView

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (instancetype)initWithFrame:(CGRect)frame withStoreID:(NSString *)storeID{
    if (self = [super initWithFrame:frame]) {
        self.storeID = storeID;
        [self createSubView];
    }
    return self;
}
#pragma mark -- 创建子控件
- (void)createSubView {
    UITableView *tbView = [self createTableViewOnTargetView:self withFrame:CGRectMake(0, 0, self.width, self.height)];
    self.tbView = tbView;
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbView registerClass:[HCShopCell class] forCellReuseIdentifier:cellID];
    
    [self getBaseOperateInfo];
    
    __weakSelf(weakSelf);
    self.tbView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getMoreDataOperateInfo];
    }];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCShopCell *cell = [HCShopCell shopTableView:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.downFlag = YES;
    cell.dataModel = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HCShopModel *model = self.dataArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(shopDownViewSelectIndexPath:)]) {
        [self.delegate shopDownViewSelectIndexPath:model];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.f;
}

#pragma mark -- 获取门店信息
- (void)getBaseOperateInfo {
    self.loadMoreDataFlag = NO;
    self.currentPage = 1;
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
    NSDictionary *parmars = @{@"store_id":[[HRNetworkTool shareTool] stringUserfulContent:self.storeID],
                              @"token":[[HRNetworkTool shareTool] stringUserfulContent:addTokenDefault],
                              @"page":@(self.currentPage),
                              @"getField":@"1",
                              @"includingMain":@"1",
                              @"search":@""
                              };
    __weakSelf(weakSelf);
    [HRCommonRequest requestShopListInfoWithURL:url parmars:parmars success:^(id  _Nonnull response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView.mj_footer endRefreshing];
            weakSelf.isNewRefreshFlag = NO;
        });
        NSArray *dataArr = response;
        if (dataArr.count > 0) {
            if (weakSelf.loadMoreDataFlag) {
            } else {
                [weakSelf.dataArr removeAllObjects];
            }
            for (NSDictionary *dic in dataArr) {
                HCShopModel *model = [HCShopModel shopInfoWithDic:dic];
                [weakSelf.dataArr addObject:model];
            }
        } else {
            if (weakSelf.loadMoreDataFlag) {
            } else {
                [weakSelf.dataArr removeAllObjects];
                
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView reloadData];
        });
    } failure:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView.mj_footer endRefreshing];
            weakSelf.isNewRefreshFlag = NO;
        });
    }];
}

@end
