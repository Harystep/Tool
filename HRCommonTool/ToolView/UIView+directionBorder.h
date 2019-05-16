//
//  UIView+directionBorder.h
//  HRSegmentView
//
//  Created by 八点半 on 2019/4/23.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (directionBorder)

- (void)setDirectionBorderWithTop:(BOOL)hasTopBorder left:(BOOL)hasLeftBorder bottom:(BOOL)hasBottomBorder right:(BOOL)hasRightBorder borderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth withBottomWidth:(CGFloat)bottomWidth withBottomShowFlag:(BOOL)flag;

@end


