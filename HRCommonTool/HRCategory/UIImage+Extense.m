//
//  UIImage+Extense.m
//  WHSProject
//
//  Created by 八点半 on 2019/3/6.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "UIImage+Extense.h"

@implementation UIImage (Extense)

+ (UIImage *)imageWithImage:(NSString *)imageStr {
    // 加载图片
    UIImage *image = [UIImage imageNamed:imageStr];    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
    return newImage;
}

@end
