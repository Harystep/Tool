

#import "DBTipView.h"

@implementation DBTipView


-(instancetype)init{
    CGFloat tip_y = 0.5 * kHEIGHT;
    CGFloat tip_x = 0.2 * kWIDTH;
    CGFloat tip_w = 0.6 * kWIDTH;
    CGFloat tip_h = 30;
    
    self = [super initWithFrame:CGRectMake(tip_x, tip_y, tip_w, tip_h)];
    if (self) {
        [self creatTipView];
    }

    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.backgroundColor =[UIColor blackColor];
    self.alpha = 0.8;
    return self;
}

-(void)creatTipView{
    
    _Lb_message = [[UILabel alloc]init];
    _Lb_message.textAlignment = 1;
    _Lb_message.frame = CGRectMake(0, 0, self.width, self.height);
    _Lb_message.font = [UIFont systemFontOfSize:LabelFont];
    _Lb_message.textColor = [UIColor whiteColor];
    [self addSubview:_Lb_message];
}

- (void)setMessage:(NSString *)message{
    if (!_Lb_message) {
        [self creatTipView];
    }
    //根据 message 计算宽高
    [self resetFrame:message];
    //设置行距
    [_Lb_message setText:message lineSpacing:2];
    _Lb_message.text = message;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(showTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

-(void)setTime:(int)time{
    showTime = time;
}

-(void)resetFrame:(NSString*)message{
    
    NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
    attDic[NSFontAttributeName] = [UIFont systemFontOfSize:LabelFont];
    attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    CGRect strRect = [message boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    
    CGFloat tip_w = 0.6 * kWIDTH - 10;
    if (strRect.size.width > tip_w) {
        
    } else {
        tip_w = strRect.size.width + 20;
    }
    CGFloat newStr_h = strRect.size.height;
    
    CGFloat lineNumber = (long)strRect.size.width / (long)tip_w ;
    if ((long)strRect.size.width % (long)tip_w != 0) {
        lineNumber += 1;
    }
    _Lb_message.frame =CGRectMake(0, 5, tip_w , lineNumber * newStr_h + 10);
    self.frame = CGRectMake((kWIDTH - tip_w) /2, self.y, tip_w, newStr_h * lineNumber + 20);
    
    _Lb_message.numberOfLines = lineNumber;
        
}

@end
