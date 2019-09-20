//
//  UILabel+HRExtend.m
//  HczyJtb
//
//  Created by pxsl on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "UILabel+HRExtend.h"

@implementation UILabel (HRExtend)

- (void)setLabelTextColor:(UIColor *)color text:(NSString *)text withFont:(CGFloat)font{
    self.font = kFontSize(font);
    self.textColor = color;
    if (text != nil) {
        self.text = text;
    }
}

- (NSMutableAttributedString *)attributedStringWithSize:(CGSize)size withContent:(NSString *)content withFont:(UIFont *)font{
    
    CGSize contentSize = [self sizeFromContentWithSize:size content:content withFont:font];
    CGFloat marginx = (size.width - contentSize.width-2)/(content.length-1);
    NSNumber *number = [NSNumber numberWithFloat:marginx];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:content];
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    [paragraphStyle setLineSpacing:marginx];
    [attri addAttribute:NSKernAttributeName value:number range:NSMakeRange(0, content.length-1)];
    return attri;
}

- (CGSize)sizeFromContentWithSize:(CGSize)size content:(NSString *)content withFont:(UIFont *)font {
    return [content boundingRectWithSize:CGSizeMake(size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:font} context:nil].size;
    
}

@end
