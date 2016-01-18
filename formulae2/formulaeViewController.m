#import "formulaeViewController.h"
#import "subjectViewController.h"

@interface formulaeViewController ()

@end

@implementation formulaeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    subjectViewController *nextView = segue.destinationViewController;
    nextView.title = segue.identifier;
    nextView.category = segue.identifier;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    #ifdef PAID
        return 4;
    #else
        return 3;
    #endif
}


@end
