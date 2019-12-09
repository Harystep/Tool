//
//  HRDecimalNumberTool.h
//  HRTestDemo1
//
//  Created by pxsl on 2019/9/2.
//  Copyright © 2019 test. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCDecimalNumberTool : NSNumber


/**
 处理精度数字
 @param mode 精度要求类型 (NSRoundPlain 是四舍五入 NSRoundDown 是向下取整 NSRoundUp 是向上取整)
 @param scale 小数点位数
 @param number 目标数字
 @return 返回值
 */
+ (NSString *)stringConvertDecimalNumberWithRoundingMode:(NSRoundingMode)mode withScale:(NSInteger)scale withNumber:(NSString *)number;

@end

NS_ASSUME_NONNULL_END
