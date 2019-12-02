/*
 self.playVideoView.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_WIDTH*(11.0 / 16.0));
 [self.scrollView addSubview:self.playVideoView];
 
 self.player = [[XLVideoPlayer alloc] init];
 MJWeakSelf;
 self.player.fullXScreenBlock = ^{
 weakSelf.player.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_WIDTH*(11.0 / 16.0));
 [weakSelf.playVideoView addSubview:weakSelf.player];
 };
 
 if (![WorkToolClass judgeIsEmptyWithString:video_url]) {
 self.videoUrl = video_url;
 }else{
 //默认给一个宣传视频
 self.videoUrl = video_url;
 }
 
 self.player.videoUrl = self.videoUrl;
 [self.player playPause];
 self.player.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_WIDTH*(11.0 / 16.0));
 [self.playVideoView addSubview:self.player];
 */

#import "HRVideoPlayerViewController.h"
#import "XLVideoPlayer.h"
#import <AVKit/AVKit.h>

@interface HRVideoPlayerViewController ()

@property (nonatomic, strong) UIView *playVideoView;
@property (nonatomic, strong) XLVideoPlayer *player;

@end

@implementation HRVideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightTextColor];
    self.playVideoView.frame = CGRectMake(0, 0, kWIDTH, 300);
    [self.view addSubview:self.playVideoView];
    __weak typeof(self) weakSelf = self;
    self.player = [[XLVideoPlayer alloc] init];
    self.player.fullXScreenBlock = ^{
        weakSelf.player.frame = CGRectMake(0, 0, kWIDTH, 300);
        [weakSelf.playVideoView addSubview:weakSelf.player];
    };
    //视频链接
    self.player.videoUrl = @"https://isv.hczypay.com/upload/picture/2019/09/04/140448_4522.mp4";
    [self.player playPause];
    self.player.frame = CGRectMake(0, 0, kWIDTH, 300);
    [self.playVideoView addSubview:self.player];
    
    UIImageView *imageIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playVideoView.frame) + 10, kWIDTH, 200)];
    imageIv.image = [self firstFrameWithVideoURL:[NSURL URLWithString:self.player.videoUrl] size:CGSizeMake(kWIDTH, 200)];
    [self.view addSubview:imageIv];
    
}

- (UIView *)playVideoView {
    if (!_playVideoView) {
        _playVideoView = [[UIView alloc] init];
    }
    return _playVideoView;
}

#pragma mark ---- 获取图片第一帧
- (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}

@end
