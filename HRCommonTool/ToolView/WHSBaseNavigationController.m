//
//  DBBaseNavigationController.m
//  GMMC
//
//  Created by 段博 on 2017/11/16.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "WHSBaseNavigationController.h"

@interface WHSBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation WHSBaseNavigationController


+(void)initialize{
    //或者使用如下方法,全局设置
    //注意，一般全局设置不会再子控制器中使用，一般会自定义一个NavigationController
//    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"nav_bg_color"]
//                                      forBarMetrics:UIBarMetricsDefault];
//
//    // 设置状态栏样式,如果需要通过Application去设置样式的话，
//    // 需要在info.plist文件中增加一配置“view Controller-base status bar appreance”
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//
//    //设置导航条的字体和颜色
//    NSDictionary *titleAttr = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:19]};
//    [[UINavigationBar appearance] setTitleTextAttributes:titleAttr];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    __weak typeof(self)weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
}
/** 导航栏滑动返回手势失效解决方法 */
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    //只有一个控制器的时候禁止手势，防止卡死现象
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.childViewControllers.count > 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    return YES;
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    //只有一个控制器的时候禁止手势，防止卡死现象
    if (self.childViewControllers.count == 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
