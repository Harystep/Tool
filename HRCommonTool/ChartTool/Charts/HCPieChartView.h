//
//  HCPieChartView.h
//  HczyJtb
//
//  Created by lighthouse on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTemplateView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HCPieChartView : HCTemplateView

@property (nonatomic, strong) NSArray *colorArray;

- (void)start;

@end

NS_ASSUME_NONNULL_END
