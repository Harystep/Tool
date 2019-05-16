

#import "DBModelManager.h"

@implementation DBModelManager

+(DBModelManager*)shareManager{
    
    static DBModelManager * modelManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        modelManager = [[DBModelManager alloc]init];
    });
    return modelManager;
}

- (NSDictionary*)userInfoDic{
    if (!_userInfoDic) {
        _userInfoDic = [NSDictionary dictionary];
    }
    return _userInfoDic;
}

@end
