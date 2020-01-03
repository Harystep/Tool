//
//  PieChart
//
//  Created by iMac on 17/2/7.
//  Copyright © 2017年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRPieItemsView : UIView

/**
 *  Each initialization method of pie chart
 *  @param frame:frame
 *  @param beginAngle:Starting angle of cake block
 *  @param endAngle：End angle of cake block
 *  @param fillColor：Fill color for this cake block
 */
- (HRPieItemsView *)initWithFrame:(CGRect)frame
                    andBeginAngle:(CGFloat)beginAngle
                      andEndAngle:(CGFloat)endAngle
                     andFillColor:(UIColor *)fillColor;
@end
