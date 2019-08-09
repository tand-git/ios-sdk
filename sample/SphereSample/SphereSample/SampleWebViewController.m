@import WebKit;
@import SphereSDK;

#import "SampleWebViewController.h"

@interface SampleWebViewController () <WKScriptMessageHandler>
@property (nonatomic, readonly) WKWebView *webView;
@end

@implementation SampleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize the webview and add self as a script message handler.
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *controller = [[WKUserContentController alloc] init];

    [controller addScriptMessageHandler:self name:@"sphere"];
    configuration.userContentController = controller;
    _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:configuration];
    [self.view addSubview:self.webView];

    // Navigate to site
    NSString* fileURL = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"web/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:fileURL]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"your website url"]];

    [self.webView loadRequest:request];
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {

    [SPRScriptMessageHandler handleReceiveScriptMessage:message];
}
@end
