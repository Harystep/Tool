//
//  SZImageView.m
//  CheckCamera
//
//  Created by 哲 on 17/2/23.
//  Copyright © 2017年 XSZ. All rights reserved.
//
#define Widthscale(scale) ((([UIScreen mainScreen].bounds.size.width) * scale) / (375))
#define Heightscale(scale) ((([UIScreen mainScreen].bounds.size.height) * scale) / (667))


#import "SZImageView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface SZImageView()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UINavigationController *navigation;
@property(nonatomic,strong) UIView *viewbg;
@property(nonatomic,strong)UIViewController *viewImageController;
@property (nonatomic, strong) UIImage *iconImage;
@end
@implementation SZImageView
+(SZImageView *)shareImageView{
    
    static SZImageView *imageview = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        imageview = [[SZImageView alloc]init];
    });
    return imageview;
}


- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.viewImageController.view];
}



#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    

    if (buttonIndex == 0) {
        // 拍照
        [self configImagePickerController:1];
    } else if (buttonIndex == 1) {
        // 从相册中选取
         [self configImagePickerController:0];
    } else if (buttonIndex == 2) {
        [self configImagePickerController:2];
    }
 
}


-(void )getFrame:(CGSize)size viewController:(id)viewController withImage:(UIImage *)iconImage{

    self.viewImageController = viewController;
    [self.viewImageController.view addSubview:self];    
    [self editPortrait];
}


-(void)configImagePickerController:(NSInteger)number{
    

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑

    switch (number) {
        case 0:
            //判断是否可以打开相册
            if ([self isPhotoLibrary]) {

                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                [self.viewImageController  presentViewController:picker animated:YES completion:nil];
            } else {
                
                UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:@"应用相册限受限,请在设置中启用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [alertV show];
                return;
            }
            break;
            
        case 1:
            
            if ([self isCameravail]){
                //摄像头
//                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                NSString *typeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"openCamera"];
                
                if ([typeStr isEqualToString:@"0"]) {
                    
                    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:@"应用相机限受限,请在设置中启用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
                    [alertV show];
                    
                }
//                else {
//                    [self.viewImageController  presentViewController:picker animated:YES completion:nil];
//                }
                return;
            }
            
            break;
            //原图
        case 2:
        {
            

            
        }
            break;
        default:
            break;
    }

}

//判断相机是否可用
-(BOOL)isCameravail{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限

        if (granted) {
            [[NSUserDefaults standardUserDefaults] setObject:@"123" forKey:@"openCamera"];
            //摄像头
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.viewImageController  presentViewController:picker animated:YES completion:nil];

        }else{

            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"openCamera"];
        }
    }];
    NSString *typeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"openCamera"];
    if ([typeStr isEqualToString:@"0"]) {
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (authStatus) {
            case AVAuthorizationStatusNotDetermined:
                //没有询问是否开启相机
                //            self.videoStatus = @"AVAuthorizationStatusNotDetermined";
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"openCamera"];
            }
                break;
            case AVAuthorizationStatusRestricted:
                //未授权，家长限制
                //            self.videoStatus = @"AVAuthorizationStatusRestricted";
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"openCamera"];
            }
                break;
            case AVAuthorizationStatusDenied:
                //未授权
                //            self.videoStatus = @"AVAuthorizationStatusDenied";
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"openCamera"];
            }
                break;
            case AVAuthorizationStatusAuthorized:
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"123" forKey:@"openCamera"];
            }
                break;
            default:
                break;
        }
    }
    return YES;
}

- (BOOL) checkVideoStatus
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问是否开启相机
//            self.videoStatus = @"AVAuthorizationStatusNotDetermined";
            return NO;
            break;
        case AVAuthorizationStatusRestricted:
            //未授权，家长限制
//            self.videoStatus = @"AVAuthorizationStatusRestricted";
            return NO;
            break;
        case AVAuthorizationStatusDenied:
            //未授权
//            self.videoStatus = @"AVAuthorizationStatusDenied";
            return NO;
            break;
        case AVAuthorizationStatusAuthorized:
            //用户授权
        {
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.viewImageController  presentViewController:picker animated:YES completion:nil];
        }
            return YES;
            break;
        default:
            break;
    }
}
-(BOOL)isPhotoLibrary{
    
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    NSString *mdeiaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mdeiaType isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        
       
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            SEL saveImage = @selector(ImageWasSaveSuccessfully:didFinishSavingWithError:contextInfo:);
            UIImageWriteToSavedPhotosAlbum(image, self, saveImage, nil);
        }

            self.imageBlock(image);
    }else{
        
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    


    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)ImageWasSaveSuccessfully:(UIImage *)paraImage didFinishSavingWithError:(NSError *)error
 contextInfo:(NSDictionary<NSString *,id> *)paraInfo{
   


    if (error == nil) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"%@",error);
    }
}


/* 下面的代码是一些相关的设置，如果想了解自己可以看一看
 */

//-(void)configImagePickerController{
//    
//    [self removeFromSuperview];
//    [self.viewbg removeFromSuperview];
//
//    UIImagePickerController *controller =[[UIImagePickerController alloc]init];
//    
//    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
//    NSString * requireMediaType = (__bridge NSString*)kUTTypeImage;
//    controller.mediaTypes = [[NSArray alloc]initWithObjects:requireMediaType, nil];
//    
//    controller.allowsEditing  = false;
//    controller.delegate =  self;
//    //打开闪光灯
//    controller.cameraFlashMode=  UIImagePickerControllerCameraFlashModeOn;
//    [self.viewImageController presentViewController:controller animated:YES completion:nil];
//    
//    
//}


//

////前置闪光灯是否可用
//-(BOOL)isCameraFlashavailFront{
//    return  [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceFront];
//}
////后置闪光灯是否可用
//-(BOOL)isCameraFlashavailRear{
//    return  [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
//}
//
////前摄像头是否可用
//-(BOOL)isCameraavailFront{
//    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
//}
////后置摄像头会否可用
//-(BOOL)isCameraavailRear{
//    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
//}
////判断是否支持拍照和录像
//-(BOOL)isCameraSupportMedia:(NSString *)paraMediaType
//{
//    NSArray *avaiablemedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//    for (NSString *item in avaiablemedia) {
//        if ([item isEqualToString:paraMediaType]) {
//            return true;
//        }
//    }
//    return false;
//}

- (BOOL)isCanUsePhotos {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    return YES;
}
@end
