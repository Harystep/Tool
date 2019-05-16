

#import <Foundation/Foundation.h>


@interface DBModelManager : NSObject

@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NSDictionary * userInfoDic;

+(DBModelManager*)shareManager;


@end
