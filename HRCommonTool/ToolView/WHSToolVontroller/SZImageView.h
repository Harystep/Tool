//
//  SZImageView.h
//  CheckCamera
//
//  Created by 哲 on 17/2/23.
//  Copyright © 2017年 XSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^ImageBlock)(UIImage *image);

@interface SZImageView : UIView
@property(nonatomic,copy)ImageBlock imageBlock;
+(SZImageView *)shareImageView;
-(void)getFrame:(CGSize)size viewController:(id)viewController withImage:(UIImage *)iconImage;
@end
