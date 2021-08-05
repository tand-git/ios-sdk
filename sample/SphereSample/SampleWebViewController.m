@import WebKit;
@import SphereSDK;

#import "SampleWebViewController.h"

@interface SampleWebViewController ()
@property (nonatomic, readonly) WKWebView *webView;
@end

@implementation SampleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize the webview
    _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];


    // Add a script message handler for Sphere Analytics
    [self.webView.configuration.userContentController addScriptMessageHandler:[[SPRScriptMessageHandler alloc] initWithWebView:_webView] name:@"sphere"];


    // Navigate to site
    NSString* fileURL = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:fileURL]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"your website url"]];

    [self.webView loadRequest:request];
}

@end
