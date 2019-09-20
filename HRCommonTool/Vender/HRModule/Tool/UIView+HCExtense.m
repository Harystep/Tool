//


#import "UIView+HCExtense.h"

@implementation UIView (HCExtense)

- (UIView *)createViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UIView *view = [[UIView alloc] init];
    view.frame = rect;
    [targetView addSubview:view];
    return view;
}

- (UILabel *)createLabelOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UILabel *label = [[UILabel alloc] init];
    label.frame = rect;
    [targetView addSubview:label];
    return label;
}

- (UIImageView *)createImageViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UIImageView *imageIv = [[UIImageView alloc] init];
    imageIv.frame = rect;
    [targetView addSubview:imageIv];
    return imageIv;
}

- (UIButton *)createButtonOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = rect;
    [targetView addSubview:btn];
    return btn;
}

- (UIScrollView *)createScrollViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UIScrollView *scView = [[UIScrollView alloc] init];
    scView.frame = rect;
    [targetView addSubview:scView];
    return scView;
}


- (UITableView *)createTableViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UITableView *tbView = [[UITableView alloc] init];
    tbView.frame = rect;
    [targetView addSubview:tbView];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tbView;
}

- (UITableView *)createTableViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect withStyle:(UITableViewStyle)style{
    UITableView *tbView = [[UITableView alloc] initWithFrame:rect style:style];
    [targetView addSubview:tbView];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tbView;
}

- (UITextField *)createTextFieldOnTargetView:(UIView *)targetView withFrame:(CGRect)rect withPlaceholder:(NSString *)placeholder {
    UITextField *textF = [[UITextField alloc] init];
    textF.frame = rect;
    [targetView addSubview:textF];
    textF.placeholder = placeholder;
    return textF;
}

- (UIView *)createNoneDataViewOnView:(UIView *)targetView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((Wide_breadth-100)/2, (Height_breadth-200)/2, 100, 130)];
    [targetView addSubview:view];
    UIImageView *NoHaveImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    NoHaveImage.image = [UIImage imageNamed:@"zanwushuju.png"];
    [view addSubview:NoHaveImage];
    UILabel *labi = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, 100, 20)];
    labi.textAlignment = NSTextAlignmentCenter;
    labi.textColor = RGBACOLOR(187,187, 187,1);
    labi.font = kFontSize(13);
    labi.text = @"暂无数据";
    view.hidden = YES;
    [view addSubview:labi];
    return view;
}

@end
