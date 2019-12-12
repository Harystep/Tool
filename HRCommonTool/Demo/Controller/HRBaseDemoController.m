//
//  HRTestDemo1.m
//  HRCommonTool
//
//  Created by pxsl on 2019/12/9.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "HRBaseDemoController.h"
#import "HRBaseDataModel.h"
#import "HRBaseSimpleCell.h"

@interface HRBaseDemoController ()

@property (strong, nonatomic) HRBaseDataModel *dataModel;

@end

@implementation HRBaseDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setSubViews];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArr[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HRBaseSimpleCell *cell = [HRBaseSimpleCell baseSimpleTableView:tableView indexPath:indexPath];
    cell.dataModel = self.dataArr[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = kColorHex(@"#f6f6f6");
    return view;
}

- (void)setSubViews {
    self.backBtn.hidden = NO;
    self.tableStyle = UITableViewStyleGrouped;
    self.tbView.frame = CGRectMake(0, kHRStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - kHRStatusBarAndNavigationBarHeight);
    [self.tbView registerTableViewIndentifiers:@[@"HRBaseSimpleCell"]];
    self.tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.header = YES;
    self.footer = YES;
    
    [self.tbView.mj_header beginRefreshing];
}

- (void)getBaseOperateInfo {
    __weakSelf(weakSelf);
    //发起网络请求
    [self.dataModel requestDate:@{} withResultData:^(NSInteger status, id  _Nullable subValue) {
        NSLog(@"%@", subValue);
        [weakSelf.tbView.mj_header endRefreshing];
        [weakSelf.dataArr removeAllObjects];
        [weakSelf.dataArr addObject:subValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView reloadData];
        });
        
    }];
}

- (void)getMoreDataOperateInfo {
    __weakSelf(weakSelf);
    [self.dataModel requestMoreDate:@{} withResultData:^(NSInteger status, id  _Nullable subValue) {
        NSLog(@"%@", subValue);
        [weakSelf.tbView.mj_footer endRefreshing];
        [weakSelf.dataArr addObject:subValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView reloadData];
        });
        
    }];
}

- (HRBaseDataModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[HRBaseDataModel alloc] init];
    }
    return _dataModel;
}

@end

