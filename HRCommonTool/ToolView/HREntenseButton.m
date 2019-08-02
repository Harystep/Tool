//
//  HREntenseButton.m
//  XY_Shop
//
//  Created by pxsl on 2019/7/30.
//  Copyright © 2019 umxnt. All rights reserved.
//

#import "HREntenseButton.h"

@implementation HREntenseButton

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //扩大原热区直径至26，可以暴露个接口，用来设置需要扩大的半径。
    CGFloat widthDelta = MAX(60, 0);
    CGFloat heightDelta = MAX(60, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    
    NSLog(@"%f-->%f", point.x, point.y);
    
    return CGRectContainsPoint(bounds, point);
}

@end
