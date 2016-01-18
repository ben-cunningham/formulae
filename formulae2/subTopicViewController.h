#import <UIKit/UIKit.h>

@interface subTopicViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSString *subTopics;
@property (strong, nonatomic) NSString *categories;
@property (strong, nonatomic) NSArray *subCategoriesOfFormulas;
@end
