

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHRepairRecordCenterView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconIv;

@property (weak, nonatomic) IBOutlet UILabel *repairNumTitelL;

@property (weak, nonatomic) IBOutlet UILabel *repairNumL;

@property (weak, nonatomic) IBOutlet UILabel *repairTypeTitleL;
@property (weak, nonatomic) IBOutlet UILabel *repairTypeL;

@property (weak, nonatomic) IBOutlet UILabel *conpanyTitleL;
@property (weak, nonatomic) IBOutlet UILabel *conpanyL;

@property (weak, nonatomic) IBOutlet UILabel *chargePersonTitleL;
@property (weak, nonatomic) IBOutlet UILabel *chargePersonL;
@property (weak, nonatomic) IBOutlet UILabel *totalPersonTitelL;
@property (weak, nonatomic) IBOutlet UILabel *totalPersonL;

@end

NS_ASSUME_NONNULL_END
