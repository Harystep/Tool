
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (CellIdentifiers)

//注册cell
- (void)registerTableViewIndentifiers:(NSArray *)cellIndentifiers;

- (void)registerClassArray:(NSArray *)cellIdentifier;


@end

NS_ASSUME_NONNULL_END
