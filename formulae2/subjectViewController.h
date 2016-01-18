#import <UIKit/UIKit.h>

@interface subjectViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *categories;
@property (strong, nonatomic) NSString *category;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *subCategoriesOfFormulas;

@end
