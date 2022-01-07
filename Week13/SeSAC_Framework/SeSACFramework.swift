//
//  SeSACFramework.swift
//  SeSAC_Framework
//
//  Created by 김지현 on 2021/12/23.
//

import UIKit
import WebKit

open class SeSACOpen: UIViewController {
    
    var name: String = "고래밥"
    
    func openfunction() {
        
    }
    
    public enum TransitionStyle {
        case present, push
    }
    
    public func presentWebViewController(url: String, transitionStyle: TransitionStyle, vc: UIViewController) {
        let webViewController = WebViewController()
        webViewController.url = url
        switch transitionStyle {
        case .present:
            vc.present(webViewController, animated: true, completion: nil)
        case .push:
            vc.navigationController?.pushViewController(webViewController, animated: true)
        }
    }
    
}

class WebViewController: UIViewController, WKUIDelegate {
    var url: String = "https://www.apple.com"
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

public class SeSACPublic: UIViewController {
    
    var name: String = "고래밥"
    
    func publicfunction() {
        
    }
    
}

class SeSACInternal: UIViewController {
    
    var name: String = "고래밥"
    
    func internalfunction() {
        
    }
}

fileprivate class SeSACFilePrivate: UIViewController {
    
}

private class SeSACPrivate: UIViewController {
    
}
