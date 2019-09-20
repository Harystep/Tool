//
//  HCPullDownSelectView.h
//  HczyJtb
//
//  Created by pxsl on 2019/8/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HCPullDownSelectViewDelegate <NSObject>

-(void)selectTypeBtnOperate:(NSInteger)type;

@end

@interface HCPullDownSelectView : UIView

@property (weak, nonatomic) id<HCPullDownSelectViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titleArr;

@end


