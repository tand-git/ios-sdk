import UIKit
import WebKit
import SphereSDK

class SampleWebViewController: UIViewController {
    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the webview
        self.webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(self.webView)


        // Add a script message handler for Sphere Analytics
        self.webView.configuration.userContentController.add(SPRScriptMessageHandler(), name: "sphere")


        // Navigate to site
        guard let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "web") else { return }

        self.webView.loadFileURL(url, allowingReadAccessTo: url)

//        let request = URLRequest(url: URL(string: "your website url")!)
//        self.webView.load(request)
    }

}
