

#import "UITableView+CellIdentifiers.h"

@implementation UITableView (CellIdentifiers)

- (void)registerTableViewIndentifiers:(NSArray *)cellIndentifiers {
    
    [self registerClassArray:cellIndentifiers];
}

- (void)registerClassArray:(NSArray *)cellIdentifier {
    for (NSString * cell in cellIdentifier) {
        [self registerClass:NSClassFromString(cell) forCellReuseIdentifier:cell];
    }
}

@end
