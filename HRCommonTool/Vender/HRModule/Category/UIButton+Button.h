
#import <UIKit/UIKit.h>

/**
 按钮点击回调
 */
typedef void (^BtTouch)(UIButton * button);

@interface UIButton (Button)

/**
 按钮点击回调
 */
@property (nonatomic,copy)BtTouch touchBlock;

/**
 按钮添加点击事件
 */
-(void)addActionWith:(BtTouch)touchClock;
/**
 按钮圆角
 */
-(void)setCornerRadius:(CGFloat)redius;

- (void)setLayerBorderWidthWithColor:(CGFloat)width withColor:(UIColor *)color;

- (void)setBtnTitleChangeSizeWithImage;

- (void)setButtonTextColor:(UIColor *)color text:(NSString *)text withFont:(CGFloat)font;

@end
