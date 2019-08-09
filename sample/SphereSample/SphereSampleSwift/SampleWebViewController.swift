import UIKit
import WebKit
import SphereSDK

class SampleWebViewController: UIViewController, WKScriptMessageHandler {
    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the webview and add self as a script message handler.
        self.webView = WKWebView(frame: self.view.frame)
        self.webView.configuration.userContentController.add(self, name: "sphere")
        self.view.addSubview(self.webView)

        // Navigate to site
        guard let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "web") else { return }

        self.webView.loadFileURL(url, allowingReadAccessTo: url)

//        let request = URLRequest(url: URL(string: "your website url")!)
//        self.webView.load(request)
    }

    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {

        SPRScriptMessageHandler.handleReceive(message)
    }
}
