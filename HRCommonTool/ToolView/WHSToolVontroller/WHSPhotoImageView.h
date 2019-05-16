

#import <UIKit/UIKit.h>
typedef  void(^ImageBlock)(UIImage *image);

@interface WHSPhotoImageView : UIView
@property(nonatomic,copy)ImageBlock imageBlock;
+(WHSPhotoImageView *)shareImageView;
-(void)getFrame:(CGSize)size viewController:(id)viewController withImage:(UIImage *)iconImage;
@end
