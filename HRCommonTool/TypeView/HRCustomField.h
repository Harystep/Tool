//
//  HRCustomField.h
//  HCMerchant
//
//  Created by pxsl on 2019/12/26.
//  Copyright © 2019 Hanchen Zhongyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HRCustomField;

@protocol HRCustomFieldDelegate <NSObject>

- (void)ctTextFieldDeleteBackward:(HRCustomField *)textField;

@end

@interface HRCustomField : UITextField

@property (nonatomic, weak) id<HRCustomFieldDelegate> ct_delegate;

@end


