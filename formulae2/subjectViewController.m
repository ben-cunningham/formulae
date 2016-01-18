#import "subjectViewController.h"
#import "subTopicViewController.h"
#import "equationViewController.h"

@interface subjectViewController ()

@end

@implementation subjectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = nil;
    self.category = [self.category lowercaseString];
    #ifdef LITE
        NSString *catName = [self.category stringByAppendingString:@"_lite"];
        path = [[NSBundle mainBundle] pathForResource:catName
                                               ofType:@".txt"];
        NSString *content = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        self.subCategoriesOfFormulas = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    #else
        path = [[NSBundle mainBundle] pathForResource:self.category
                                               ofType:@".txt"];
        NSString *content = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        self.subCategoriesOfFormulas = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    #endif

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [self.subCategoriesOfFormulas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [self.subCategoriesOfFormulas objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (!self.subCategoriesOfFormulas) {
        [self viewDidLoad];
    }
    if ([segue.identifier isEqualToString:@"segue1"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        subTopicViewController *nextView = segue.destinationViewController;
        nextView.subTopics = [self.subCategoriesOfFormulas objectAtIndex:path.row];
        nextView.title = [self.subCategoriesOfFormulas objectAtIndex:path.row];
        nextView.categories = self.category;
    }
    else if([segue.identifier isEqualToString:@"constants"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        equationViewController *nextView = segue.destinationViewController;
        nextView.subject = @"constants";
        nextView.title = [self.subCategoriesOfFormulas objectAtIndex:path.row];
        nextView.subTopic = @"constants";
        nextView.equation = [self.subCategoriesOfFormulas objectAtIndex:path.row];
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.category isEqualToString:@"constants"]) {
        [self performSegueWithIdentifier:@"constants" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"segue1" sender:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
@end
