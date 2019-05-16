

#import <UIKit/UIKit.h>

@interface HRCreatQRView : UIView

@property (nonatomic,strong)UIImageView * QRImg;

/* 生成二维码 */
- (UIImage*)creatQRView:(NSString *)string;

@end
