/*
 (
 {
 color = "#69CD66";
 money = "3.08";
 perc = "0.63%";
 type = "微信";
 },
 {
 color = "#41A2E6";
 money = "486.06";
 perc = "99.37%";
 type = "支付宝";
 },
 {
 color = "#66CDC2";
 money = "0.00";
 perc = "0.00%";
 type = "其它";
 }
 )
 */

#import "ViewController.h"
#import "HREntenseButton.h"
#import "YZXPieGraphView.h"

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ViewController ()

@property (strong, nonatomic) YZXPieGraphView *pieGraphView;

@property (strong, nonatomic) UITextField *tf;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(100, 100, 200, 200);
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    HREntenseButton *btn = [[HREntenseButton alloc] init];
    btn.frame = CGRectMake(50, 500, 50, 50);
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSArray *valueMutarr= @[];
    NSArray *percentmut = @[];
    NSArray *showLineMut = @[];
    NSArray *colormut = @[];
    
    _pieGraphView = [[YZXPieGraphView alloc] initWithFrame:CGRectMake((kWIDTH-400)/2, 0, 400, 300) withTitleData:valueMutarr withPercentageData:percentmut withMoneyArr:showLineMut withColors:colormut];
    _pieGraphView.center = CGPointMake(100, 200);
    _pieGraphView.backgroundColor = [UIColor whiteColor];
    _pieGraphView.titleFont = 12;
    //        _pieGraphView.circleRadius = 80;
    _pieGraphView.titleColor = HEXCOLOR(0x999999);
    _pieGraphView.hideTitlt = NO;  //是否隐藏标题(可不设置)
    _pieGraphView.hideAnnotation = YES;  //是否隐藏注释(可不设置)
    _pieGraphView.circleCenter = CGPointMake(200, 80); // 圆的中心点(可不设置)
    ////        }
    [self.view addSubview:_pieGraphView];
    
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 300, 40)];
    tf.backgroundColor = [UIColor lightGrayColor];
    self.tf = tf;
    tf.textColor = [UIColor blackColor];
    [self.view addSubview:tf];
    

    NSLog(@"hahahha");

}

- (void)click {
    NSString *content = self.tf.text;
//    NSString *result = @"^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?!([^(0-9a-zA-Z)])+$).{6,}$";
    NSString *passWordRegex = @"^(?![\d]+$)(?![a-zA-Z]+$)(?!^.*[\u4E00-\u9FA5].*$)(?![^\da-zA-Z]+$).{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    BOOL isMatch = [pred evaluateWithObject:content];
    if (isMatch) {
        NSLog(@"success··");
    } else {
        NSLog(@"fail··");
        [MBProgressHUD wj_showPlainText:@"大家好!!" view:self.view];
    }
}


- (void)testMergeCode {
    self.age = @"10";
    NSLog(@"切换分支%@", self.age);
}

@end
