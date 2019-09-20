//
//  HCDateSelectorView.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRDatePickerView.h"

@interface HCDateSelectorView : NSObject

+(instancetype)shareDate;

- (NSString *)getDateView:(BRDatePickerMode)mode;

- (NSString *)getNewDate;

@end


