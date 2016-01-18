#import "equationViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface equationViewController ()
{
    BOOL _bannerIsVisible;
    ADBannerView *_adBanner;
}

@end

@implementation equationViewController 

UIWebView *myWebView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    
}

- (void) loadImagesOntoScreenWithFilesnames:(NSArray *) filenames withPath: (NSString *) path {
    
    for (int i = 0; i < [filenames count]; i++) {
        NSString *pathForImage = [path stringByAppendingString:(@"/")];
        pathForImage = [pathForImage stringByAppendingString:filenames[i]];
        UIImage *testImage = [[UIImage alloc] initWithContentsOfFile:pathForImage];
        UIImageView *images = [[UIImageView alloc] initWithImage:testImage];
        images.frame = CGRectMake(50, 100*(i+1), testImage.size.width/2, testImage.size.height/2);
        [self.view addSubview:images];
    }
}

-(NSString *) getPath{
  
    NSString *lowerCase = [_equation lowercaseString];
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSString *documentsPath = [path stringByAppendingPathComponent:_subject];
    NSString *specificPath = [documentsPath stringByAppendingPathComponent:_subTopic];
    return [specificPath stringByAppendingPathComponent:lowerCase];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.backgroundColor = UIColorFromRGB(0x6cc0e5);
    NSString *filePath = [[self getPath] stringByAppendingString:@"/"];
    filePath = [filePath stringByAppendingString:[_equation lowercaseString]];
    filePath = [filePath stringByAppendingString:@".html"];
    _webView.scrollView.bounces = NO;
    filePath = [filePath stringByReplacingOccurrencesOfString:@"’" withString:@""];
    [_webView setOpaque:NO];
    _webView.backgroundColor = [UIColor clearColor];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    #ifdef LITE
        _adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 50)];
        _adBanner.delegate = self;
    #endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - iAdBanner Delegates

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!_bannerIsVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (_adBanner.superview == nil)
        {
            [self.view addSubview:_adBanner];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
    
    if (_bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = NO;
    }
}

@end