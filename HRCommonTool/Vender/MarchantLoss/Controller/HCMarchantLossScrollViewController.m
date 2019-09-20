

#import "HCMarchantLossScrollViewController.h"

#define screen_w [UIScreen mainScreen].bounds.size.width
#define screen_h [UIScreen mainScreen].bounds.size.height

@interface HCMarchantLossScrollViewController ()<UIScrollViewDelegate>

//前置图片
@property (nonatomic, strong) UIImageView *titleIv;

// 标题scrollView
@property (nonatomic, strong) UIScrollView *titleScrollView;

// 内容scrollView
@property (nonatomic, strong) UIScrollView *contentScrollView;

// 标题按钮数组
@property (nonatomic, strong) NSMutableArray<UIButton *> *titleButtons;

// 记录选中标题按钮
@property (nonatomic, weak) UIButton *selectButton;


@property (nonatomic, assign) BOOL isSuc;

@property (strong, nonatomic) UIView *bottumView;

@end

@implementation HCMarchantLossScrollViewController

- (UIImageView *)titleIv {
    
    if (_titleIv == nil) {
        
        _titleIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_w, 150)];
        _titleIv.image = [UIImage imageNamed:@"header"];
    }
    return _titleIv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.view.backgroundColor = kBackgroundVCColor;
    //设置图片
    // 2.设置标题scrollView
    [self.view addSubview:self.titleScrollView];
    
    // 3.设置内容scrollView
    [self.view addSubview:self.contentScrollView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_isSuc) {
        // 3.添加所有子控制器
        [self setupAllChildViewController];
        
        // 4.设置所有标题
        [self setupAllTitleButton];
        
        _isSuc = true;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i = scrollView.contentOffset.x / screen_w;
    
    UIButton *titleButton = self.titleButtons[i];
    
    [self titleClick:titleButton];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*
     NSInteger leftI = scrollView.contentOffset.x / screen_w;
     NSInteger rightI = 1 + leftI;
     
     UIButton *leftBtn = self.titleButtons[leftI];
     NSInteger count = self.titleButtons.count;
     
     UIButton *rightBtn;
     if (rightI < count) {
     rightBtn = self.titleButtons[rightI];
     }
     
     // 0~1 => 1~1.3
     CGFloat scaleR = scrollView.contentOffset.x / screen_w;
     scaleR -= leftI;
     
     CGFloat scaleL = 1 - scaleR;
     
     if (scaleL > 0) {
     leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
     rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
     } else {
     rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
     leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
     }
     */
}

#pragma mark - 设置所有标题
- (void)setupAllTitleButton
{
    NSInteger count = self.childVCArray.count;
    CGFloat btnW;
    btnW = screen_w/count;
    CGFloat btnY = 10;
    CGFloat btnH = self.titleScrollView.bounds.size.height-1-36;
    CGFloat btnX = 0;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        titleButton.backgroundColor = [UIColor redColor];
        titleButton.tag = i + 10086;
        UIViewController *vc = self.childVCArray[i];
        [titleButton setTitle:vc.title
                     forState:UIControlStateNormal];
        btnX = i * btnW;
        titleButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [titleButton setTitleColor:kColorHex(@"#333333") forState:UIControlStateNormal];
        [titleButton setTitleColor:kColorHex(@"#FA7224") forState:UIControlStateSelected];
        if (IS_IPHONE_5) {
            titleButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        }else{
            titleButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        }
        UIView *bottumView = [self createViewOnTargetView:titleButton withFrame:CGRectMake((titleButton.width-kMarcoWidth(27))/2, titleButton.height-2, kMarcoWidth(27), 2)];
        bottumView.tag = 10001+i;
        titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // 监听按钮点击
        [titleButton addTarget:self
                        action:@selector(titleClick:)
              forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleButtons addObject:titleButton];
        
        if (i == 0) {
            bottumView.backgroundColor = kColorHex(@"#FA7224");
            self.bottumView = bottumView;
            // 默认点击第一个标题
            [self titleClick:titleButton];
            _selectButton = titleButton;
//            titleButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        }
        
        [self.titleScrollView addSubview:titleButton];
    }
    // 设置标题scrollView的滚动范围
    self.titleScrollView.contentSize = CGSizeMake(count * btnW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置内容scrollView的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * screen_w, 0);
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
}

// 处理按钮点击
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag - 10086;
    // 标题颜色变换
    [self selButton:button];
    
    // 把对应子控制器view添加上去
    [self setupChildVCView:i];
    
    // 内容滚动到对应的位置
    CGFloat offsetX = i * screen_w;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    [self setSelectBottumView:button];
}
- (void)setSelectBottumView:(UIButton *)sender {
    self.bottumView.hidden = YES;
    for (UIView *view in sender.subviews) {
        if (view.tag>10000) {
            view.hidden = NO;
            view.backgroundColor = kColorHex(@"#FA7224");
            self.bottumView = view;
        }

    }
}
// 选中标题
- (void)selButton:(UIButton *)button
{
    // 当选中下一个标题时，恢复上一个标题的样式
    
    if (button == _selectButton) return;
    
    
    [_selectButton setTitleColor:kColorHex(@"#333333") forState:UIControlStateNormal];
    
    // 设置标题选中样式
    [button setTitleColor:kColorHex(@"#FA7224") forState:UIControlStateNormal];
    
    _selectButton = button;
    
}

// 标题居中
- (void)setupTitleButtonCenter:(UIButton *)button
{
    // 实际上就是修改titleScrollView的contentOffset
    CGFloat offsetX = button.center.x - screen_w * 0.5;
    
    if (offsetX < 0) {
        // 最左边的按钮不用居中
        offsetX = 0;
    }
    
    //最大偏移量
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - screen_w;
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    //    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

// 添加一个子控制器的View
- (void)setupChildVCView:(NSInteger)i
{
    UIViewController *vc = self.childVCArray[i];
    if (vc.view.superview) {
        //如果一个子控制器已经添加过了，那么它的view一定有superview
        return;
    }
    
    CGFloat x = i * screen_w;
    vc.view.frame = CGRectMake(x, 0, screen_w, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
}


#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    for (UIViewController *childVC in self.childVCArray) {
        [self addChildViewController:childVC];
    }
}

#pragma mark - 懒加载
- (UIScrollView *)titleScrollView
{
    if (_titleScrollView) {
        return _titleScrollView;
    }
    
    // 验证是否有navigationController或navigationBar是否隐藏
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_w, 70)];
    titleScrollView.backgroundColor = [UIColor whiteColor];
    UIView *sepView = [[UIView alloc] init];
    sepView.frame = CGRectMake(0, 0, screen_w, 10);
    sepView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [titleScrollView addSubview:sepView];
    
    UIView *alertView = [[UIView alloc] init];
    alertView.frame = CGRectMake(0, 44, screen_w, 26);
    alertView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [titleScrollView addSubview:alertView];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.frame = CGRectMake(15, 0, screen_w, 26);
    titleL.text = @"以下店铺长时间未进行交易，可能已经流失，请及时召回。";
    titleL.textColor = kColorHex(@"#999999");
    titleL.textAlignment = NSTextAlignmentLeft;
    if (IS_IPHONE_5) {
        titleL.font = kFontSize(11);
    }else {
        titleL.font = kFontSize(12);
    }
    [alertView addSubview:titleL];
    _titleScrollView = titleScrollView;
    
    return _titleScrollView;
}

- (UIScrollView *)contentScrollView
{
    if (_contentScrollView) {
        return _contentScrollView;
    }
    
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, screen_w, screen_h - y)];
    contentScrollView.pagingEnabled = YES;
    contentScrollView.bounces = NO;
    contentScrollView.delegate = self;
    
    _contentScrollView = contentScrollView;
    return _contentScrollView;
}

-(NSMutableArray<UIViewController *> *)childVCArray
{
    if (_childVCArray) {
        return _childVCArray;
    }
    
    _childVCArray = [NSMutableArray array];
    return _childVCArray;
}

-(NSMutableArray<UIButton *> *)titleButtons
{
    if (_titleButtons) {
        return _titleButtons;
    }
    
    _titleButtons = [NSMutableArray array];
    return _titleButtons;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



