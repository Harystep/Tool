//
//  WHSAlertView.h
//  WHSProject
//
//  Created by 八点半 on 2019/2/25.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WHSAlertViewDelegate <NSObject>

- (void)operateAlertBtn:(NSInteger)type withButton:(UIButton *)button;

@end

@interface WHSAlertView : UIView

@property (nonatomic, weak) id<WHSAlertViewDelegate> delegate;

@property (nonatomic, copy) NSString *title;


- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
