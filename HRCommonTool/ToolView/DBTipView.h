

#import <UIKit/UIKit.h>


/**
 默认字号
 */
static CGFloat const LabelFont = 13;
/**
 默认显示时间
 */
static int showTime = 1;


@interface DBTipView : UIView
{
    UILabel * _Lb_message;
}
/**
 显示信息
 */
@property (nonatomic,copy)NSString * message;
/**
 显示时间 默认3s （如设置，需在调用message前调用）
 */
@property (nonatomic,assign)int time;


-(instancetype)init;

@end
