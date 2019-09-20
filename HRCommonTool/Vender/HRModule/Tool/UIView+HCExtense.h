//
//  UIView+HCExtense.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (HCExtense)



- (UIButton *)createButtonOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;


- (UILabel *)createLabelOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;


- (UIView *)createViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;


- (UIImageView *)createImageViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;


- (UIScrollView *)createScrollViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;

- (UITableView *)createTableViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;
- (UITableView *)createTableViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect withStyle:(UITableViewStyle)style;
- (UITextField *)createTextFieldOnTargetView:(UIView *)targetView withFrame:(CGRect)rect withPlaceholder:(NSString *)placeholder ;

- (UIView *)createNoneDataViewOnView:(UIView *)targetView;

@end


