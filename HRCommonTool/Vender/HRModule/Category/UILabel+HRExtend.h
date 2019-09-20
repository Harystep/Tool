//
//  UILabel+HRExtend.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HRExtend)

- (void)setLabelTextColor:(UIColor *)color text:(NSString *)text withFont:(CGFloat)font;

- (NSMutableAttributedString *)attributedStringWithSize:(CGSize)size withContent:(NSString *)content withFont:(UIFont *)font;

- (CGSize)sizeFromContentWithSize:(CGSize)size content:(NSString *)content withFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
