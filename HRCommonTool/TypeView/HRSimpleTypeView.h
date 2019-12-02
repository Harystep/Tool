

#import <UIKit/UIKit.h>

typedef enum {
    HRSimpleViewTypeText = 0,
    HRSimpleViewTypeField,
    HRSimpleViewTypeTextAndArrow,
    
} HRSimpleViewType;

@interface HRSimpleTypeView : UIView

@property (assign, nonatomic) NSInteger targetTag;

@property (copy, nonatomic) NSString *alertPlaceholder;

@property (copy, nonatomic) NSString *subTitleStr;

- (instancetype)initWithFrame:(CGRect)frame withStyle:(HRSimpleViewType)type;

@end


