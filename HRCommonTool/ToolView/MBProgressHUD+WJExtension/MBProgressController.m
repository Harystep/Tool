

#import "MBProgressController.h"
#import "MBProgressHUD.h"

static MBProgressHUD    *HUD;

@interface MBProgressController ()

@end

@implementation MBProgressController

static MBProgressController *progressController = nil;

+ (MBProgressController *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        progressController = [[MBProgressController alloc] init];
    });
    return progressController;
}

- (id)init{
    if (self = [super init]) {
        //自定义的imgView
        self.customV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 74, 37)];
        [self.customV setImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        self.customV.contentMode = UIViewContentModeCenter;
    }
    return self;
}

#pragma mark -Customed MBProgress methods
- (void)showWithText:(NSString *)tipsStr {
    [self allocNewMBprogressHUDwithType: MBProgressHUDModeIndeterminate];
    if (tipsStr && tipsStr.length != 0) {
        self.hud.labelText = tipsStr;
    }
    MBProgressHUD *hud = self.hud;
    [self.hud show:YES];
#pragma mark - 补充网速太差,长时间收不到数据或者弱连接的优化处理
    /**
     *  防止一直卡死在加载中无法操作
     *
     *  @param DISPATCH_TIME_NOW  设置超时时间为多少;
     *
     *  原因:
     *  self.hud是一个添加在window上的一个view,所以要对window的subViews用isKingOf去遍历,;
     *  [UIApplication sharedApplication].keyWindow]可以获取当前显示最前的视图(优先级最高的)
     *  找到以后移除提示视图就好了,然后可以再初始化一个自动消失的提示或者其他操作之类的;
     */
    
    //延迟3s执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
        if (self.hud == hud)
        {
            [self.hud removeFromSuperview];
            self.hud = nil;
//            [self showTipsOnlyText:kName(@"APP_NetNoGood") AndDelay:1.8];
        }
    });
}

- (void)hide {
    if (self.hud) {
        self.hud.removeFromSuperViewOnHide = YES;
        [self.hud hide:YES];
    }
}

- (void)showTipsLoadingWithText:(NSString *)tipsStr AndDelay:(NSTimeInterval)delay {
    [self allocNewMBprogressHUDwithType:MBProgressHUDModeIndeterminate];
    if (tipsStr && tipsStr.length != 0) {
        self.hud.labelText = tipsStr;
    }
    
    [self.hud showAnimated:YES whileExecutingBlock:^{
        [self mbprogressDelaySet:delay];
    } completionBlock:^{
        [self.hud removeFromSuperview];
        self.hud = nil;
    }];
}

- (void)showTipsLoadingWithText:(NSString *)tipsStr WithResult:(BOOL)isSuccess AndDelay:(NSTimeInterval)delay {
    [self allocNewMBprogressHUDwithType:MBProgressHUDModeIndeterminate];
    if (tipsStr && tipsStr.length != 0) {
        self.hud.labelText = tipsStr;
    }
    
    [self.hud showAnimated:YES whileExecutingBlock:^{
        self.isTrue = isSuccess;
        [self mbprogressDelayWithResultSet:delay];
    } completionBlock:^{
        [self.hud removeFromSuperview];
        self.hud = nil;
    }];
}

- (void)showTipsOnlyText:(NSString *)tipsStr AndDelay:(NSTimeInterval)delay {
    if (!tipsStr || tipsStr.length == 0) {
        return;
    }
    [self allocNewMBprogressHUDwithType:MBProgressHUDModeText];
    self.hud.labelText = tipsStr;
    self.hud.margin = 10;
//    self.hud.yOffset = 150;
    self.hud.removeFromSuperViewOnHide = YES;
    [self.hud showAnimated:YES
       whileExecutingBlock:^(){
           [self mbprogressDelaySet:delay];
       }
           completionBlock:^(){
           [self.hud removeFromSuperview];
           self.hud = nil;
       }];
}

- (void)showTipsOnlyCustomViewWith:(NSString *)tipsStr AndDelay:(NSTimeInterval)delay{
    [self allocNewMBprogressHUDwithType:MBProgressHUDModeCustomView];
    if (tipsStr && tipsStr.length != 0) {
        self.hud.labelText = tipsStr;
    }
    [self.hud showAnimated:YES
       whileExecutingBlock:^(){
           [self mbprogressDelaySet:delay];
       }completionBlock:^(){
           [self.hud removeFromSuperview];
           self.hud = nil;
       }];
}

#pragma mark -Init MBprogressHUD methods
- (void)allocNewMBprogressHUDwithType:(MBProgressHUDMode)type {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.hud = [[MBProgressHUD alloc] initWithWindow:window];
    self.hud.mode = type;
    if (type == MBProgressHUDModeCustomView) {
        self.hud.customView = self.customV;
    }
    [window addSubview:self.hud];
}

#pragma mark -Delay methods
- (void)mbprogressDelaySet:(NSTimeInterval)delay{
    sleep(delay);
    
}

-(void)mbprogressDelayWithResultSet:(NSTimeInterval)delay{
    sleep(delay);
    if (self.isTrue) {
        self.hud.mode = MBProgressHUDModeCustomView;
        self.hud.customView = self.customV;
        self.hud.labelText = @"成 功";
    } else {
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"失 败";
        self.hud.margin = 10.0;
        self.hud.yOffset = 150.0;
        self.hud.removeFromSuperViewOnHide = YES;
    }
    sleep(2.0);
}

#pragma mark -- 转圈单独处理
+ (MBProgressHUD *)showHUDWithLabel:(NSString *)labelText
                             onView:(UIView *)view {
    HUD = [[MBProgressHUD alloc] initWithView:view];
    
    [view addSubview:HUD];
    
    HUD.labelText = labelText;
    HUD.labelFont = [UIFont systemFontOfSize:16.0f];
    
    [HUD show:YES];
    
    return HUD;
}

+ (void)removeHUD {
    [HUD hide:YES afterDelay:0];
    [HUD removeFromSuperViewOnHide];
}


@end
