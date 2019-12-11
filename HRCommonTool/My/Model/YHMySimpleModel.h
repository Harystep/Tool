//
//  YHMySimpleModel.h
//  HRCommonTool
//
//  Created by pxsl on 2019/12/11.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHMySimpleModel : NSObject
/** 是否带有尖头 */
@property (assign, nonatomic) NSInteger isArrow;

@property (copy, nonatomic) NSString *iconStr;

@property (copy, nonatomic) NSString *title;

+ (instancetype)simpleInfoWithDic:(NSDictionary *)dict;

- (instancetype)initWithDic:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
