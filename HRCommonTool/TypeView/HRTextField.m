//
//  HRTextField.m
//  HCMerchant
//
//  Created by pxsl on 2019/12/26.
//  Copyright © 2019 Hanchen Zhongyi. All rights reserved.
//

#import "HRTextField.h"

@interface HRTextField () <UITextFieldDelegate>


@end

@implementation HRTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    UITextField *fieldF = [self createTextFieldOnTargetView:self withFrame:self.bounds withPlaceholder:@""];
    [fieldF addTarget:self action:@selector(textFieldEventEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    fieldF.delegate = self;
    self.fieldF = fieldF;
}

- (void)setPlacehloderFont:(CGFloat)placehloderFont {
    _placehloderFont = placehloderFont;
    [self.fieldF setValue:kFontSize(placehloderFont) forKeyPath:@"_placeholderLabel.font"];
}

//限制两位
#pragma mark - 文本框内容改变
- (void)textFieldEventEditingChanged:(UITextField *)textField {
    if (textField.text.length == 1) {
        if ([textField.text isEqualToString:@"."]) {
            textField.text = @"";
            return;
        }
    } else if (textField.text.length == 2) {
        if ([[textField.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
            if ([[textField.text substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"."]) {
            } else {
                textField.text = @"0";
                return;
            }
        }
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *futureString = [NSMutableString stringWithString:textField.text];
    if ([futureString containsString:@"."]) {
        if ([string isEqualToString:@"."]) {
            return NO;
        }
    }
    [futureString insertString:string atIndex:range.location];
    
    NSInteger flag = 0;
    // 这个可以自定义,保留到小数点后两位,后几位都可以
    const NSInteger limited = 2;
    
    for (NSInteger i = futureString.length - 1; i >= 0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            // 如果大于了限制的就提示
            if (flag > limited) {
                return NO;
            }
            break;
        }
        flag++;
    }
    return YES;
    
}

@end
