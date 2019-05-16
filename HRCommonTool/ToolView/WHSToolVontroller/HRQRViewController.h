

#import <UIKit/UIKit.h>

@protocol QRFinishDelegate <NSObject>

- (void)sweepQRViewResultWithContent:(NSString *)resultStr;

@end

@interface HRQRViewController : UIViewController


@property (nonatomic)id<QRFinishDelegate>delegate;

@end
