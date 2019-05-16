
#import <UIKit/UIKit.h>

@interface UILabel (DBUILabel)

/**
 修改行距
 */
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

- (void)setLabelFont:(CGFloat)font withTextAlignment:(NSTextAlignment)textAlignment withTextColor:(UIColor *)color;


@end
