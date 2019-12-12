//
//  YHMyViewController.m
//  HRCommonTool
//
//  Created by pxsl on 2019/12/11.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "YHMyViewController.h"
#import "YHMySimpleCell.h"
#import "YHMySimpleModel.h"

@interface YHMyViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation YHMyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UITableView *tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbView registerClass:[YHMySimpleCell class] forCellReuseIdentifier:@"YHMySimpleCell"];
    tbView.backgroundColor = kColorHex(@"#f6f6f6");
    [self.view addSubview:tbView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *secArr = self.dataArr[section];
    return secArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell----->");
    YHMySimpleCell *cell = [YHMySimpleCell mySimpleTableView:tableView indexPath:indexPath];
    NSArray *secArr = self.dataArr[indexPath.section];
    cell.dataModel = secArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [HCRouter router:@"simpleDemo" viewController:self animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"height----->");
    return 50.f;
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

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        NSArray *sec1Arr = @[@{@"title":@"123", @"iconStr":@"", @"isArrow":@"1"},
                             @{@"title":@"456", @"iconStr":@"", @"isArrow":@"1"},
                             ];
        NSArray *sec2Arr = @[@{@"title":@"789", @"iconStr":@"", @"isArrow":@"1"},
                             @{@"title":@"555", @"iconStr":@"", @"isArrow":@"1"},
                             @{@"title":@"666", @"iconStr":@"", @"isArrow":@"1"}
                             ];
        NSArray *sec3Arr = @[@{@"title":@"777", @"iconStr":@"", @"isArrow":@"1"},
                             ];
        
        [_dataArr addObject:[self dataModelArrWithArray:sec1Arr]];
        [_dataArr addObject:[self dataModelArrWithArray:sec2Arr]];
        [_dataArr addObject:[self dataModelArrWithArray:sec3Arr]];
    }
    return _dataArr;
}

- (NSMutableArray *)dataModelArrWithArray:(NSArray *)dataArr {
    NSMutableArray *targetArr = [NSMutableArray array];
    for (NSDictionary *dic in dataArr) {
        YHMySimpleModel *model = [YHMySimpleModel simpleInfoWithDic:dic];
        [targetArr addObject:model];
    }
    return targetArr;
}

@end
