#import "subTopicViewController.h"
#import "equationViewController.h"

@interface subTopicViewController ()

@end

@implementation subTopicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = nil;
    NSString *temp = _subTopics;
    self.subTopics = _categories;
    self.subTopics = [self.subTopics stringByAppendingString:@"/"];
    self.subTopics = [self.subTopics stringByAppendingString:temp];
    self.subTopics = [self.subTopics lowercaseString];
    path = [[NSBundle mainBundle] pathForResource:self.subTopics
                                           ofType:@".txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    self.subCategoriesOfFormulas = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

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
    if ([segue.identifier isEqualToString:@"segue2"]) {
    
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        equationViewController *nextView = segue.destinationViewController;
        nextView.equation = [self.subCategoriesOfFormulas objectAtIndex:path.row];
        nextView.title = [self.subCategoriesOfFormulas objectAtIndex:path.row];
        NSString *seugeCategory = [self.subTopics substringFromIndex:[self.subTopics rangeOfString:@"/"].location + 1];
        nextView.subTopic = seugeCategory;
        nextView.subject = self.categories;
        
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"segue2" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
