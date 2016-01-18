#import <UIKit/UIKit.h>
#import <iAd/iAd.h>


@interface equationViewController : UIViewController <ADBannerViewDelegate>

@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *subTopic;
@property (strong, nonatomic) NSString *equation;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
