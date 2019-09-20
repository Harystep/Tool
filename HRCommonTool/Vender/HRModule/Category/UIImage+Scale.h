//
//  UIImage+Scale.h
//  HczyJtb
//
//  Created by pxsl on 2019/9/7.
//  Copyright © 2019 Wuhan Hanchen Zhongyi Information Technoogy Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Scale)

- (UIImage *)scaleToWidth:(CGFloat)width;

+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (UIImage *)compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
