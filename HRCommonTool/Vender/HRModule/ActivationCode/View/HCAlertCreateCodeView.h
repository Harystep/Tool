//
//  HCAlertCreateCodeView.h
//  HczyJtb
//
//  Created by pxsl on 2019/9/9.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCAlertCreateCodeViewDelegate <NSObject>
/** 确定生成激活码操作 */
- (void)sureCreateActiveCodeOperate;

@end

@interface HCAlertCreateCodeView : UIView

@property (copy, nonatomic) NSString *codeStr;

@property (weak, nonatomic) id<HCAlertCreateCodeViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end


