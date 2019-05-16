//
//  CTLocalizedHelper.h
//  CoinThere
//
//  Created by 张建锋 on 2019/2/18.
//  Copyright © 2019 WZB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTLocalizedHelper : NSObject

+ (instancetype)standardHelper;

- (NSBundle *)bundle;

- (NSString *)currentLanguage;

- (void)setUserLanguage:(NSString *)language;

- (NSString *)stringWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
