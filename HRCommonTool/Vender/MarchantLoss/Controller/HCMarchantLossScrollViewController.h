

NS_ASSUME_NONNULL_BEGIN

@interface HCMarchantLossScrollViewController : hczyBaseViewControl

// 子控制器数组
@property (nonatomic, strong) NSMutableArray<UIViewController *> *childVCArray;
@property (nonatomic, assign) NSInteger typeFlag;
+ (void)setupChildVCs:(NSMutableArray *)childVCs;

@end

NS_ASSUME_NONNULL_END
