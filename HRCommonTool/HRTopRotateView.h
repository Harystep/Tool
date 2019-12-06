//
//  HCTopRotateView.h
//  HczyJtb
//
//  Created by pxsl on 2019/11/25.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HRTopRotateViewDelegate <NSObject>

- (void)selectTopRotateViewItem:(NSInteger)index;

@end

@interface HRTopRotateView : UIView

@property (strong, nonatomic) NSArray *funcArr;

@property (strong, nonatomic) NSArray *bannerArr;

@property (weak, nonatomic) id<HRTopRotateViewDelegate> delegate;

+ (instancetype)topRotateTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end


