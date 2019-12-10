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
#import <AVFoundation/AVFoundation.h>
#import "HREntenseButton.h"
#import "YZXPieGraphView.h"
#import "HRProgressHub.h"
#import "YHRepairRecordSubInfoView.h"
#import "YHRepairRecordCenterView.h"
#import "AFNetworking.h"
#import "BRStringPickerView.h"
#import "HRVideoPlayerViewController.h"
#import "HRFunctionViewController.h"
#import "BMKShowMapPage.h"
#import "HRPieChartView.h"

#define CompressionVideoPaht [NSHomeDirectory() stringByAppendingFormat:@"/Documents/CompressionVideoField"]

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ViewController ()

@property (strong, nonatomic) YZXPieGraphView *pieGraphView;

@property (strong, nonatomic) UITextField *tf;

@property (strong, nonatomic) YHRepairRecordCenterView *centerView;

@property (strong, nonatomic) YHRepairRecordSubInfoView *subView;

@property (strong, nonatomic) HRPieChartView *pieView;

@end

@implementation ViewController


- (YHRepairRecordSubInfoView *)subView {
    if (_subView == nil) {
        _subView = [[NSBundle mainBundle] loadNibNamed:@"YHRepairRecordSubInfoView" owner:self options:nil].firstObject;
        
    }
    return _subView;
}

- (YHRepairRecordCenterView *)centerView {
    if (_centerView == nil) {
        _centerView = [[NSBundle mainBundle] loadNibNamed:@"YHRepairRecordCenterView" owner:self options:nil].firstObject;
        
    }
    return _centerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self addButtonOperate];
    
    [self setButtonBorderColorOperate];
    
    [self addPieChartView];
}
#pragma mark -- 添加按钮
- (void)addButtonOperate {
    HREntenseButton *btn = [[HREntenseButton alloc] init];
    btn.tag = 1;
    btn.frame = CGRectMake(kHRMarginX, 100, kWIDTH - kHRMarginX * 2, 50);
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"不要点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setCornerRadius:5];
    [self.view addSubview:btn];
}
#pragma mark -- 添加按钮边框颜色
- (void)setButtonBorderColorOperate {
    HREntenseButton *btn1 = [[HREntenseButton alloc] init];
    btn1.tag = 2;
    btn1.frame = CGRectMake(kHRMarginX, 200, kWIDTH - 2 * kHRMarginX, 40);
    btn1.backgroundColor = [UIColor lightGrayColor];
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    btn1.layer.borderWidth = 1.0;
    btn1.layer.borderColor = [UIColor orangeColor].CGColor;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"低调一点 我先进了" forState:UIControlStateNormal];
    [btn1 setCornerRadius:20];
}

- (void)addPieChartView {
    
    [self.view addSubview:self.pieView];
    self.pieView.hidden = NO;
    self.pieView.valueArr = @[@"12", @"20", @"30"];
    self.pieView.colorArr = @[[UIColor redColor], [UIColor purpleColor], [UIColor yellowColor]];
    [self.pieView showAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pieView.hidden = YES;
    });
}

#pragma mark -- 添加阴影视图
- (void)addShadowView {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(100, 100, 200, 200);
    view.backgroundColor = [UIColor whiteColor];
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.1f;
    view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowRadius = 5.0f;
    view.layer.masksToBounds = NO;
    //正常矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.shadowPath = path.CGPath;
    [self.view addSubview:view];
}
#pragma mark -- 跳转视图
- (void)click:(UIButton *)sender {
    switch (sender.tag) {
        case 1://跳转功能视图
        {
            [self jumpMapOperate];
        }
            break;
        case 2:
        {
            [self jumpFunctionView];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -- 跳转地图
- (void)jumpMapOperate {

    [HCRouter router:@"mapLocation" viewController:self animated:YES];
}
#pragma mark -- 跳转功能视图
- (void)jumpFunctionView {
    
    [HCRouter router:@"safeFunction" viewController:self animated:YES];
}

- (void)jumpVideoView {
    
    [HCRouter router:@"videoPlayer" viewController:self animated:YES];
}

- (void)addAlertViewOperate:(UIButton *)sender {
    [[HRProgressHub sharedInstance] showTextMsg:@"hfshaiufshihfshaiufshihfshaiufshihfshaiufshiihfshaiufshihfshaiufshihfshaiufshi"];

    if (sender.tag == 1) {
        [self uploadFileWithPic:@"image/jpg"];
    } else {
        [self uploadFileWithVideo:@"video/mp4"];
    }

    NSArray *titleArr = @[@"123", @"456"];
    [BRStringPickerView showStringPickerWithTitle:@"" dataSource:titleArr defaultSelValue:titleArr.lastObject isAutoSelect:NO resultBlock:^(id selectValue) {
        NSLog(@"%@", selectValue);
    } cancelBlcok:^{

    }];
}

- (void)uploadFileWithPic:(NSString *)type {
    UIImage *image1 = [UIImage imageNamed:@"all"];
    NSData *data2 = UIImageJPEGRepresentation(image1, 1);
    NSString *fileStr = [[NSBundle mainBundle] pathForResource:@"123.jpg" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:fileStr];
    [self uploadFile:data withType:type];
//    [self uploadFile:data2];
//    [self requestUpdateFileWithStr:@"http://39.104.54.5:39/dogdisk/servlet/UploadHandleServlet" withData:data requestDict:@{}];
}

- (void)uploadFileWithVideo:(NSString *)type {
    NSString *fileStr = [[NSBundle mainBundle] pathForResource:@"1570693338102654.mp4" ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:fileStr];
    /*
     AVAssetExportPresetLowQuality
     
     AVAssetExportPresetMediumQuality
     
     VAssetExportPresetHighestQuality
     
     AVAssetExportPreset640x480
     
     AVAssetExportPreset1280x720
     */
    NSData *data = [NSData dataWithContentsOfFile:fileStr];
    NSLog(@"pre--->%ld", data.length);
    [self uploadFile:data withType:type];
//    [self compressedVideoOtherMethodWithURL:fileUrl compressionType:AVAssetExportPresetLowQuality];
    
//    [self requestUpdateFileWithStr:@"http://39.104.54.5:39/dogdisk/servlet/UploadHandleServlet" withData:data requestDict:@{}];

}

- (void)uploadFile:(NSData *)data withType:(NSString *)type {
    NSDictionary *params = @{};
    NSString *url = @"http://39.104.54.5:39/dogdisk/servlet/UploadHandleServlet";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    // 1、组装 http body ===================
    // ①定义分界线（boundary）
    NSString *boundaryID = @"fca01082-5fdf-4b8f-a472-acb03e965bfc"; // 分界线标识符
    NSString *boundary = [NSString stringWithFormat:@"--%@", boundaryID]; // 分界线
    NSString *boundaryEnding = [NSString stringWithFormat:@"--%@--", boundaryID]; // 分界线结束
    
    // ②图片data
    NSData *imgData = data;
    
    // ③http body的字符串
    NSMutableString *bodyString = [NSMutableString string];
    // 遍历keys，组装文本类型参数
    NSArray *keys = [params allKeys];
    for (NSString *key in keys) {
        // 添加分界线，换行
        [bodyString appendFormat:@"%@\r\n", boundary];
        // 添加参数名称，换2行
        [bodyString appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
        // 添加参数的值,换行
        [bodyString appendFormat:@"%@\r\n", [params objectForKey:key]];
    }
    // 添加分界线，换行
    [bodyString appendFormat:@"%@\r\n", boundary];
    // 组装文件类型参数, 换行
    NSString *fileParamName = @"file"; // 文件参数名
    NSString *filename = [type stringByReplacingOccurrencesOfString:@"/" withString:@"."]; // 文件名
    [bodyString appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fileParamName, filename];
    // 声明上传文件的格式，换2行
    NSString *fileType = type;
    [bodyString appendFormat:@"Content-Type: %@\r\n\r\n", fileType];
    
    // 声明 http body data
    NSMutableData *bodyData = [NSMutableData data];
    // 将 body 字符串 bodyString 转化为UTF8格式的二进制数据
    NSData *bodyParamData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [bodyData appendData:bodyParamData];
    // 将 image 的 data 加入
    [bodyData appendData:imgData];
    
    [bodyData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]]; // image数据添加完后 加一个换行
    
    // 分界线结束符加入（以 NSData 形式）
    NSString *boundryEndingWithReturn = [NSString stringWithFormat:@"%@\r\n", boundaryEnding]; // 分界线结束符加换行
    NSData *boundryEndingData = [boundryEndingWithReturn dataUsingEncoding:NSUTF8StringEncoding];
    [bodyData appendData:boundryEndingData];
    // 设置 http body data
    request.HTTPBody = bodyData;
    // 组装 http body 结束 ===================
    
    // 设置 http header 中的 Content-Type 的值
    NSString *content = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundaryID];
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    // 设置 Content-Length
//    [request setValue:[NSString stringWithFormat:@"%@", @(bodyData.length)] forHTTPHeaderField:@"Content-Length"];
    // 设置请求方式 POST
    request.HTTPMethod = @"POST";
    
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:bodyData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"content:%@", content);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic : %@", dic);
        NSLog(@"%@", data);
        
    }] resume];
}

- (void)requestUpdateFileWithStr:(NSString *)urlStr withData:(NSData *)data requestDict:(id)dict {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    manager.requestSerializer.timeoutInterval = 20;

    [manager POST:urlStr parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@", str];
        
        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%@%@", fileName, @".jpg"] mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    
    }];
    
}

- (void)addGraphView {
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
}

- (void)addTestView {
    [self.subView setCornerRadius:10];
    [self.view addSubview:self.subView];
    self.subView.frame = CGRectMake(16, 100, kWIDTH - 16 * 2, 250);

    [self.centerView setCornerRadius:10];
    [self.view addSubview:self.centerView];
    self.centerView.frame = CGRectMake(16, CGRectGetMaxY(self.subView.frame), kWIDTH - 16 * 2, 250);
}

- (void)testMergeCode {
    self.age = @"10";
    NSLog(@"切换分支%@", self.age);
}

-(NSString *)dateConversionTimeStamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    return timeSp;
}

- (void)compressedVideoOtherMethodWithURL:(NSURL *)url compressionType:(NSString *)compressionType {
    
    NSString *resultPath;
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    CGFloat totalSize = (float)data.length / 1024 / 1024;
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    // 所支持的压缩格式中是否有 所选的压缩格式
    if ([compatiblePresets containsObject:compressionType]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:compressionType];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];// 用时间, 给文件重新命名, 防止视频存储覆盖,
        
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        BOOL isExists = [manager fileExistsAtPath:CompressionVideoPaht];
        
        if (!isExists) {
            
            [manager createDirectoryAtPath:CompressionVideoPaht withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        resultPath = [CompressionVideoPaht stringByAppendingPathComponent:[NSString stringWithFormat:@"outputJFVideo-%@.mov", [formater stringFromDate:[NSDate date]]]];
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         {
             if (exportSession.status == AVAssetExportSessionStatusCompleted) {
                 NSData *data = [NSData dataWithContentsOfFile:resultPath];
                 float memorySize = (float)data.length / 1024 / 1024;
                 NSLog(@"视频压缩后大小 %f", memorySize);
                 NSLog(@"end--->%ld", data.length);
                 [self uploadFile:data withType:@"video/mp4"];
                 
             } else {
                 
             }
             
         }];
        
    } else {
        
    }
}


/**
 
 *  清楚沙盒文件中, 压缩后的视频所有, 在使用过压缩文件后, 不进行再次使用时, 可调用该方法, 进行删除
 
 */

+ (void)removeCompressedVideoFromDocuments {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:CompressionVideoPaht]) {
        [[NSFileManager defaultManager] removeItemAtPath:CompressionVideoPaht error:nil];
    }
}


- (void)requestWithFormUploadFile:(NSString *)URLString parameters:(NSDictionary *)parameters data:(NSData *)data fileName:(NSString *)fileName{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//初始化请求对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/javascript",@"text/plain", nil];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]) {
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
            if ([response[@"code"] integerValue] == 101 ||  [response[@"code"] integerValue] == 401) { // 代表验证失败
                
            }
        }
    }];
}

- (void)uploadFile:(NSData *)imageData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/javascript",@"text/plain", nil];
    NSString *boundaryID = @"fca01082-5fdf-4b8f-a472-acb03e965bfc"; // 分界线标识符
    NSString *boundary = [NSString stringWithFormat:@"--%@", boundaryID]; // 分界线
    NSString *boundaryEnding = [NSString stringWithFormat:@"--%@--", boundaryID]; // 分界线结束
    
    NSString *content = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundaryID];
    
    [manager.requestSerializer setValue:content forHTTPHeaderField:@"Content-Type"];
    
    NSString *urlString = @"http://39.104.54.5:39/dogdisk/servlet/UploadHandleServlet";
    
    NSMutableString *bodyString = [NSMutableString string];
    // 添加分界线，换行
    [bodyString appendFormat:@"%@\r\n", boundary];
    // 声明 http body data
    NSMutableData *bodyData = [NSMutableData data];
    // 将 body 字符串 bodyString 转化为UTF8格式的二进制数据
    NSData *bodyParamData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [bodyData appendData:bodyParamData];
    // 将 image 的 data 加入
    [bodyData appendData:imageData];
    
    [bodyData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]]; // image数据添加完后 加一个换行
    
    // 分界线结束符加入（以 NSData 形式）
    NSString *boundryEndingWithReturn = [NSString stringWithFormat:@"%@\r\n", boundaryEnding]; // 分界线结束符加换行
    NSData *boundryEndingData = [boundryEndingWithReturn dataUsingEncoding:NSUTF8StringEncoding];
    [bodyData appendData:boundryEndingData];
    
    //post请求
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 我这里的imgFile是对应后台给你url里面的图片参数，别瞎带。
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:bodyData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *errmsg = [responseObject objectForKey:@"errmsg"];
//        NSString *mediaID = [responseObject objectForKey:@"mediaid"];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"成功:%@", dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@",error);
    }];

}

- (HRPieChartView *)pieView {
    if (_pieView == nil) {
        _pieView = [[HRPieChartView alloc] initWithFrame:CGRectMake((kWIDTH - 200)/2.0, 200, 200, 200)];
    }
    return _pieView;
}

@end
