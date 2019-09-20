//
//  HCSimpleSearchView.h
//  HczyJtb
//
//  Created by pxsl on 2019/9/9.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HCSimpleSearchViewDelegate <NSObject>

/**
 编辑开始
 */
- (void) textFieldDidStartEditing;

/**
 确定搜索
 @param value 搜索关键字
 */
- (void) textFieldSearchValue:(NSString *)value;


@end


@interface HCSimpleSearchView : UIView


@property (strong, nonatomic) UIView *contentView;
/**
 文本输入框
 */
@property (strong, nonatomic) UITextField *textField;

/**
 是否设置圆角
 */
@property (assign, nonatomic) BOOL filletFlag;
/**
 设置角度
 */
@property (assign, nonatomic) CGFloat contentRadius;
/**
 默认搜索提示文字
 */
@property (copy, nonatomic) NSString *placeStr;

@property (weak, nonatomic) id<HCSimpleSearchViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withCancelType:(NSInteger)type;

- (void) setContentViewBorderWidth:(CGFloat)width withBorderColor:(UIColor *)color withRadius:(CGFloat)radius;

- (void)searchTextInitType;

@end

