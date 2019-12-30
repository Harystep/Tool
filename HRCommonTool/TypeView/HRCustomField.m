//
//  HRCustomField.m
//  HCMerchant
//
//  Created by pxsl on 2019/12/26.
//  Copyright © 2019 Hanchen Zhongyi. All rights reserved.
//

#import "HRCustomField.h"

@implementation HRCustomField

- (void)deleteBackward {
    [super deleteBackward];
    if ([self.ct_delegate respondsToSelector:@selector(ctTextFieldDeleteBackward:)]) {
        [self.ct_delegate ctTextFieldDeleteBackward:self];
    }
}

@end
