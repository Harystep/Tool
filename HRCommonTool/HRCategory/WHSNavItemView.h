//
//  WHSNavItemView.h
//  WHSProject
//
//  Created by 八点半 on 2019/2/15.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHSNavItemView : UIView

+ (WHSNavItemView *)shareManager;

- (UIBarButtonItem *)setLeftBtWithImage:(UIImage *)image aciton:(void(^)(UIButton* button))action;

@end

NS_ASSUME_NONNULL_END
