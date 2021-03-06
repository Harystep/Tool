//
//  HRFunctionViewController.m
//  HRCommonTool
//
//  Created by pxsl on 2019/12/6.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "HRFunctionViewController.h"
#import "HRTopRotateView.h"
#import "HRFunctionItemView.h"

@interface HRFunctionViewController ()

@property (strong, nonatomic) UIScrollView *scView;

@property (strong, nonatomic) NSArray *bannarArr;

@property (strong, nonatomic) HRTopRotateView *topView;

@property (strong, nonatomic) UIView *functioneView;

@end

@implementation HRFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIScrollView *scView = [[UIScrollView alloc] init];
    self.scView = scView;
    scView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
    [self.view addSubview:scView];
    
    HRTopRotateView *topView = [[HRTopRotateView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 280)];
    [self.scView addSubview:topView];
    topView.bannerArr = self.bannarArr;
    
    HRFunctionItemView *function = [[HRFunctionItemView alloc] initWithFrame:CGRectMake(kHRMarginX, CGRectGetMaxY(topView.frame) - 45, kWIDTH - 2 * kHRMarginX, 300)];
    function.backgroundColor = [UIColor whiteColor];
    [function setCornerRadius:10];
    [self.scView addSubview:function];
    
    function.imgArr = [NSMutableArray arrayWithObjects:@"", @"", nil];
    
}


- (NSArray *)bannarArr {
    if (_bannarArr == nil) {
        _bannarArr = @[@"bannerbanner1", @"bannerbanner2", @"bannerbanner3", @"bannerbanner4", @"bannerbanner5"];
    }
    return _bannarArr;
}

@end
