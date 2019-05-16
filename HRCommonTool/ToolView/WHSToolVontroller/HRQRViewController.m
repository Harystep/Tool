

#import "HRQRViewController.h"
#import <AVFoundation/AVFoundation.h>
#define iOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0

#define kBorderW 100
#define kMargin ([UIScreen mainScreen].bounds.size.width - 260) / 2


@interface HRQRViewController ()<UIAlertViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
}
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak)   UIView *maskView;
@property (nonatomic, strong) UIView *scanWindow;
@property (nonatomic, strong) UIImageView *scanNetImageView;
@end

@implementation HRQRViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self resumeAnimation];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 这个属性必须打开否则返回的时候会出现黑边
    self.view.clipsToBounds=YES;
    //1.扫描区域
    [self setupScanWindowView];
    //2.遮罩
    [self setupMaskView];
    
    //4.提示文本
    [self setupTipTitleView];
    //5.顶部导航
//    [self setupNavView];
    //6.开始动画
    [self beginScanning];
    //3.下边栏
    [self setupBottomBar];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resumeAnimation) name:@"EnterForeground" object:nil];
    
}


-(void)setupTipTitleView{
    
    //1.补充遮罩
    
    UIView*mask=[[UIView alloc]initWithFrame:CGRectMake(0, _maskView.frame.origin.y +_maskView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height * 0.9 - _maskView.frame.size.height - _maskView.frame.origin.y)];
    mask.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:mask];
    
    UIView *mask1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _maskView.frame.origin.y)];
    mask1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:mask1];
    
    
    //2.操作提示
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.9 - kBorderW * 2, self.view.bounds.size.width, kBorderW)];
    tipLabel.text = @"将取景框对准二维码，即可自动扫描";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipLabel.numberOfLines = 2;
    tipLabel.font=[UIFont systemFontOfSize:12];
    tipLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipLabel];
    
}
-(void)setupNavView{


    self.title = @"扫描二维码";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithTitle:@"相册"
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(addPicture)];
    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];

}
#pragma mark -- 添加相片
- (void)addPicture {
    [self myAlbum];
}

- (void)getImageFromIpc
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}



- (void)setupMaskView{
    
    CGFloat scanWindowH = _scanWindow.frame.size.width + kBorderW * 2 ;
    CGFloat scanWindowW = _scanWindow.frame.size.width + kBorderW * 2 ;
   
    UIView *mask = [[UIView alloc] init];
    _maskView = mask;
    
    mask.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    mask.layer.borderWidth = kBorderW;
    
    mask.bounds = CGRectMake(0, 0, scanWindowW, scanWindowH);
    mask.center = _scanWindow.center ;
    
    [self.view addSubview:mask];
}

- (void)setupBottomBar

{
    //1.下边栏
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 64) * 0.9, self.view.frame.size.width, (self.view.frame.size.height - 64) * 0.1)];
    bottomBar.userInteractionEnabled = YES ;
    bottomBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.92];
    
    [self.view addSubview:bottomBar];
    
  
    //2.我的二维码
   /* UIButton * myCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    myCodeBtn.frame = CGRectMake(0,0, self.view.frame.size.height * 0.1 *35/49, self.view.frame.size.height * 0.1);
    myCodeBtn.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height * 0.1/2);
    [myCodeBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_myqrcode_down"] forState:UIControlStateNormal];
    
    myCodeBtn.contentMode=UIViewContentModeScaleAspectFit;
    
    [myCodeBtn addTarget:self action:@selector(myCode) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:myCodeBtn];
  */
    //3.闪光灯
    
    UIButton * flashBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    flashBtn.frame = CGRectMake(0,0, (self.view.frame.size.height - 64) * 0.1 * 35/49, (self.view.frame.size.height - 64) * 0.1);

    
    flashBtn.center=CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height - 64) * 0.1/2);

    [flashBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    flashBtn.contentMode=UIViewContentModeScaleAspectFit;
    [flashBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:flashBtn];
    
    
}
- (void)setupScanWindowView{
    CGFloat scanWindowH = self.view.frame.size.width - kMargin * 2;
    CGFloat scanWindowW = self.view.frame.size.width - kMargin * 2;
    
    
//    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kMargin, kMargin + 100 , scanWindowW, scanWindowH)];
    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kMargin, (kHEIGHT - scanWindowH)/2 , scanWindowW, scanWindowH)];
    _scanWindow.clipsToBounds = YES;
    [self.view addSubview:_scanWindow];
    
    _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    
    
    CGFloat buttonWH = 18;
    
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowW - buttonWH, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanWindowH - buttonWH, buttonWH, buttonWH +1)];
    [bottomLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(topRight.frame.origin.x, bottomLeft.frame.origin.y, buttonWH, buttonWH +1)];
    [bottomRight setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomRight];
}

- (void)beginScanning{
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) return;
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    CGRect scanCrop=[self getScanCrop:_scanWindow.bounds readerViewBounds:self.view.frame];
    output.rectOfInterest = scanCrop;
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_session addInput:input];
    [_session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
}


#pragma mark-> 扫描结果
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [_session stopRunning];

        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:metadataObject.stringValue preferredStyle:UIAlertControllerStyleAlert];
    }
}
#pragma mark-> 我的相册
-(void)myAlbum{
    
    NSLog(@"我的相册");
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        //1.初始化相册拾取器
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        //2.设置代理
        controller.delegate = self;
        //3.设置资源：
        /**
         UIImagePickerControllerSourceTypePhotoLibrary,相册
         UIImagePickerControllerSourceTypeCamera,相机
         UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
         */
        controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //4.随便给他一个转场动画
//        controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
//        controller.allowsEditing=YES;
        [self presentViewController:controller animated:YES completion:NULL];
        
    }else{
        
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}


#pragma mark-> imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    /**这种方法是ios8之后提供的方法，ios8之前是不能用的,我尝试用之前的第三方去替代结果表示并不是很理想，很显然系统提供的api无论是从识别效率还是识别准确度上都要比第三方的强，我尝试用一个自定义背景色的二维码去被识别但是第三方提取不到信息，系统的可以提取到。这里说的取不到是在系统从相册中提取原图的时候上面的二维码信息提取不到，但是我这里把相册的编辑属性打开，取编辑之后的图片之后奇迹般的获取到了信息，真是奇葩 */
    //1.获取选择的图片
    UIImage *pickImage =[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self decodeImage:pickImage];
        
    }];
    
    
}

/**识别图片中的二维码信息 */
-(void)decodeImage:(UIImage*)image{
    /**这里你完全可以向下兼容没必要用ios8以上的api但是这里这么写主要是为了介绍ios8后提供的这个api，而且性能和识别率要高于第三方 */
    if(iOS8){
        /**ios8环境以上 */
        //初始化一个监测器
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >=1) {
            /**结果对象 
             UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alertView show];
             
             */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            if ([self.delegate respondsToSelector:@selector(sweepQRViewResultWithContent:)]) {
                [self.delegate sweepQRViewResultWithContent:scannedResult];
                
                [self disMiss];
            }
            
            
        }
        else{

             UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含一个二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alertView show];
             
             
           
        }
    }
}

#pragma mark-> 闪光灯
-(void)openFlash:(UIButton*)button{
    
    NSLog(@"闪光灯");
    button.selected = !button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
}

#pragma mark-> 开关闪光灯
- (void)turnTorchOn:(BOOL)on
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}


#pragma mark 恢复动画
- (void)resumeAnimation
{
    CAAnimation *anim = [_scanNetImageView.layer animationForKey:@"translationAnimation"];
    if(anim){
        // 1. 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = _scanNetImageView.layer.timeOffset;
        // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        
        // 3. 要把偏移时间清零
        [_scanNetImageView.layer setTimeOffset:0.0];
        // 4. 设置图层的开始动画时间
        [_scanNetImageView.layer setBeginTime:beginTime];
        
        [_scanNetImageView.layer setSpeed:1.0];
        
    }else{
        
        CGFloat scanNetImageViewH = 241;
        CGFloat scanWindowH = self.view.frame.size.width - kMargin * 2;
        CGFloat scanNetImageViewW = _scanWindow.frame.size.width;
        
        _scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanWindowH);
        scanNetAnimation.duration = 1.0;
        scanNetAnimation.repeatCount = MAXFLOAT;
        [_scanNetImageView.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
        [_scanWindow addSubview:_scanNetImageView];
    }
    
    
    
}
#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}
#pragma mark-> 返回
- (void)disMiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    

}


@end
