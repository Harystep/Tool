//
//  UIView+directionBorder.m
//  HRSegmentView
//
//  Created by 八点半 on 2019/4/23.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "UIView+directionBorder.h"

@implementation UIView (directionBorder)

- (void)setDirectionBorderWithTop:(BOOL)hasTopBorder left:(BOOL)hasLeftBorder bottom:(BOOL)hasBottomBorder right:(BOOL)hasRightBorder borderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth withBottomWidth:(CGFloat)bottomWidth withBottomShowFlag:(BOOL)flag{
    
    float height = self.frame.size.height;
    
    float width = self.frame.size.width;
    
    CALayer *topBorder = [CALayer layer];
    
    topBorder.frame = CGRectMake(0, 0, width, borderWidth);
    
    topBorder.backgroundColor = borderColor.CGColor;
    
    CALayer *leftBorder = [CALayer layer];
    
    leftBorder.frame = CGRectMake(0, 0, 1, height);
    
    leftBorder.backgroundColor = borderColor.CGColor;
    
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake((width - bottomWidth)/2, height, bottomWidth, borderWidth);
    if (flag) {
        
        bottomBorder.backgroundColor = borderColor.CGColor;
    } else {
        bottomBorder.backgroundColor = kKlineBgViewColor.CGColor;
    }
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake(width, 0, borderWidth, height);
    
    rightBorder.backgroundColor = borderColor.CGColor;
    
    
    if (hasTopBorder) {
        [self.layer addSublayer:topBorder];
    }
    if (hasLeftBorder) {
        [self.layer addSublayer:leftBorder];
    }
    if (hasBottomBorder) {
        [self.layer addSublayer:bottomBorder];
    }
    if (hasRightBorder) {
        [self.layer addSublayer:rightBorder];
    }
    
}

@end
