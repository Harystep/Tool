//
//  HRProgressView.h
//  WHSProject
//
//  Created by 八点半 on 2019/2/21.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HRProgressView : UIView

+ (instancetype)shareProressView;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setMaskBtnColor:(UIColor *)color;
- (void)setProgressViewBgColor:(UIColor *)color alpha:(CGFloat)alpha withRadius:(CGFloat)radius withActivityViewColor:(UIColor *)activeColor;
- (void)show;
- (void)dismiss;
/** 待开发控制背景视图大小 */

@end


