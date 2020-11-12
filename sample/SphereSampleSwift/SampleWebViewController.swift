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
        self.webView.configuration.userContentController.add(MyMessageHandler(), name: "TagJSInterface")


        // Navigate to site
        guard let url = Bundle.main.url(forResource: "index", withExtension: "html") else { return }

        self.webView.loadFileURL(url, allowingReadAccessTo: url)

//        let request = URLRequest(url: URL(string: "your website url")!)
//        self.webView.load(request)
    }

}

class MyMessageHandler: NSObject, WKScriptMessageHandler {

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if let body = message.body as? String {
            postMessage(message: body)
        }
    }

    func postMessage(message: String) {
        if let dict = convertToDictionary(jsonString: message) {
            if let name = dict["name"] as? String, name == SPRScriptMessageHandler.handlerName() {
                // Sphere 메세지 핸들러 호출
                SPRScriptMessageHandler.handlePostMessageBody(dict)
            }
        }
    }

    func convertToDictionary(jsonString: String) -> [String: Any]? {
        if let data = jsonString.data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
}
