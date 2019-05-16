//
//  DBBaseNavigationController.h
//  GMMC
//
//  Created by 段博 on 2017/11/16.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 按钮点击回调
 */
//typedef void (^BtTouch)(UIButton * button);


@interface WHSBaseNavigationController : UINavigationController


/**
 按钮点击回调
 */

//@property (nonatomic,copy)BtTouch touchBlock;

@property (nonatomic,strong)UIButton * Bt_leftItem;


//- (void)setLeftBt:(NSString*)title with:(BtTouch)touchClock;

@end
