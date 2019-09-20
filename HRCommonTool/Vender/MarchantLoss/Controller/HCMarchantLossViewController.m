//
//  HCMarchantLossViewController.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HCMarchantLossViewController.h"
#import "HCMarchantOneLossViewController.h"
#import "HCMarchantTwoLossViewController.h"
#import "HCMarchantThreeLossViewController.h"
#import "HCMarchantMoreLossViewController.h"

@interface HCMarchantLossViewController ()

@end

@implementation HCMarchantLossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildContentVc];
}
- (void)addChildContentVc{
    HCMarchantOneLossViewController *oneVc = [[HCMarchantOneLossViewController alloc] init];
    oneVc.title = @"1天无交易";
    HCMarchantTwoLossViewController *twoVc = [[HCMarchantTwoLossViewController alloc] init];
    twoVc.title = @"2天无交易";
    HCMarchantThreeLossViewController *threeVc = [[HCMarchantThreeLossViewController alloc] init];
    threeVc.title = @"3天无交易";
    HCMarchantMoreLossViewController *fourVc = [[HCMarchantMoreLossViewController alloc] init];
    fourVc.title = @"超3天无交易";
    [self.childVCArray addObjectsFromArray:@[oneVc, twoVc,threeVc, fourVc]];
}
@end
