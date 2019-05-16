//
//  WHSNavItemView.m
//  WHSProject
//
//  Created by 八点半 on 2019/2/15.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "WHSNavItemView.h"

@implementation WHSNavItemView

+ (WHSNavItemView *)shareManager{
    
    static WHSNavItemView *navManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        navManager = [[WHSNavItemView alloc] init];
    });
    return navManager;
}

- (UIBarButtonItem*)setLeftBtWithImage:(UIImage*)image aciton:(void(^)(UIButton* button))action{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 30, 30);
    if (kWIDTH > 325 && kWIDTH < 376) {
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -4, 0, 0)];
    } else if (kWIDTH > 376) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    } else {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 0)];
    }
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addActionWith:^(UIButton *button) {
        if (action) {
            action(button);
        }
    }];
    return buttonItem;
}

@end
