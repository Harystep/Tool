//
//  HRDecimalNumberTool.m
//  HRTestDemo1
//
//  Created by pxsl on 2019/9/2.
//  Copyright © 2019 test. All rights reserved.
//

#import "HCDecimalNumberTool.h"

@implementation HCDecimalNumberTool

+ (NSString *)stringConvertDecimalNumberWithRoundingMode:(NSRoundingMode)mode withScale:(NSInteger)scale withNumber:(NSString *)number{
    if ([[HRNetworkTool shareTool] isCheckData:number]) {
        NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                           decimalNumberHandlerWithRoundingMode:mode
                                           scale:scale
                                           raiseOnExactness:NO
                                           raiseOnOverflow:NO
                                           raiseOnUnderflow:NO
                                           raiseOnDivideByZero:YES];
        NSDecimalNumber *multiplyNum = [NSDecimalNumber decimalNumberWithString:@"1.0"];
        NSDecimalNumber *deci = [NSDecimalNumber decimalNumberWithString:number];
        deci = [deci decimalNumberByMultiplyingBy:multiplyNum withBehavior:roundUp];
        return [deci stringValue];
    } else{
        return @"";
    }
}

@end
