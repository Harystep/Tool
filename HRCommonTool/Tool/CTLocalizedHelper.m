//
//  CTLocalizedHelper.m
//  CoinThere
//
//  Created by 张建锋 on 2019/2/18.
//  Copyright © 2019 WZB. All rights reserved.
//

#import "CTLocalizedHelper.h"

static NSBundle *_bundle;

static NSString *const kUserLanguage = @"kUserLanguage";

@implementation CTLocalizedHelper

+ (instancetype)standardHelper {
    static CTLocalizedHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[CTLocalizedHelper alloc] init];
    });
    return helper;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        if (!_bundle) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *userLanguage = [defaults valueForKey:kUserLanguage];
            
            //用户未手动设置过语言
            if (userLanguage.length == 0) {
                
                NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
                
                NSString *systemLanguage = languages.firstObject;
                
                userLanguage = systemLanguage;
            }
            
            if ([userLanguage containsString:@"zh-"]) {
                userLanguage = @"zh-Hans";
            }
            if ([userLanguage isEqualToString:@"en"]) {
                userLanguage = @"en";
            }
            NSString *path = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
            
            _bundle = [NSBundle bundleWithPath:path];
        }
        
    }
    return self;
}

- (NSBundle *)bundle {
    return _bundle;
}

- (NSString *)currentLanguage {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userLanguage = [defaults valueForKey:kUserLanguage];
    
    if (userLanguage.length == 0) {
        
        NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
        
        NSString *systemLanguage = languages.firstObject;
        
        return systemLanguage;
    }
    
    return userLanguage;
}

- (void)setUserLanguage:(NSString *)language {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    
    _bundle = [NSBundle bundleWithPath:path];
    
    [defaults setValue:language forKey:kUserLanguage];
    
    [defaults synchronize];
}

- (NSString *)stringWithKey:(NSString *)key {
    
    if (_bundle) {
        NSString *content = [_bundle localizedStringForKey:key value:nil table:@"Localizable"];
        return content;
    }else {
        return NSLocalizedString(key, nil);
    }
}

@end
