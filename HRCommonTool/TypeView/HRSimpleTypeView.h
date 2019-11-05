

#import <UIKit/UIKit.h>

typedef enum {
    HRSimpleViewTypeText = 0,
    HRSimpleViewTypeField,
    HRSimpleViewTypeTextAndArrow,
    
} HRSimpleViewType;

@interface HRSimpleTypeView : UIView

@property (assign, nonatomic) NSInteger targetTag;


- (instancetype)initWithFrame:(CGRect)frame withStyle:(HRSimpleViewType)type;

@end


