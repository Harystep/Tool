

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/** X坐标 */
@property(nonatomic, assign)CGFloat x;

/** Y坐标 */
@property(nonatomic, assign)CGFloat y;

/** x中心点 */
@property(nonatomic, assign)CGFloat centerX;

/** y中心点 */
@property(nonatomic, assign)CGFloat centerY;

/** 坐标 */
@property(nonatomic, assign)CGPoint origin;

/** 宽度 */
@property(nonatomic, assign)CGFloat width;

/** 高度 */
@property(nonatomic, assign)CGFloat height;

/** 尺寸 */
@property(nonatomic, assign)CGSize size;
@end
