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

@property (strong, nonatomic) UIView *headView;

@property (strong, nonatomic) UILabel *titleL;

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
    
    UITableView *tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kScreenHeight - 200) style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbView registerClass:[YHMySimpleCell class] forCellReuseIdentifier:@"YHMySimpleCell"];
    tbView.backgroundColor = kColorHex(@"#f6f6f6");
    [self.view addSubview:tbView];

    tbView.estimatedRowHeight = 0.0;
    tbView.estimatedSectionFooterHeight = 0.0;
    tbView.estimatedSectionHeaderHeight = 0.0;
    
    
    if (@available(iOS 11.0, *)) {
        tbView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    return 30.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    titleL.backgroundColor = kColorHex(@"#f6f6f6");
    titleL.text = [NSString stringWithFormat:@"title--->%tu", section];
    return titleL;
    
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
        NSArray *sec4Arr = @[@{@"title":@"789", @"iconStr":@"", @"isArrow":@"1"},
                             @{@"title":@"555", @"iconStr":@"", @"isArrow":@"1"},
                             @{@"title":@"666", @"iconStr":@"", @"isArrow":@"1"},
                             @{@"title":@"111", @"iconStr":@"", @"isArrow":@"1"},
                             @{@"title":@"222", @"iconStr":@"", @"isArrow":@"1"},
                             @{@"title":@"333", @"iconStr":@"", @"isArrow":@"1"}
                             ];
        NSArray *sec5Arr = @[@{@"title":@"777", @"iconStr":@"", @"isArrow":@"1"},
                             ];
        
        [_dataArr addObject:[self dataModelArrWithArray:sec1Arr]];
        [_dataArr addObject:[self dataModelArrWithArray:sec2Arr]];
        [_dataArr addObject:[self dataModelArrWithArray:sec3Arr]];
        [_dataArr addObject:[self dataModelArrWithArray:sec4Arr]];
        [_dataArr addObject:[self dataModelArrWithArray:sec4Arr]];
        [_dataArr addObject:[self dataModelArrWithArray:sec4Arr]];
        [_dataArr addObject:[self dataModelArrWithArray:sec5Arr]];
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
