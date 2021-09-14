//
//  LaunchControllerVk.swift
//  Vkontakte
//
//  Created by Серёжа on 16/06/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit
import WebKit

class LaunchControllerVk: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet private weak var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7199574"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        let request = URLRequest(url: components.url!)
        webview.load(request)
    }
}

extension LaunchControllerVk: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping(WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else {
                decisionHandler(.allow)
                return
            }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String] ()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let userId = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        
        Singleton.instance.token = token
        Singleton.instance.userId = userId
        
        performSegue(withIdentifier: "segueFriends", sender: nil)
        decisionHandler(.cancel)
    }
}
