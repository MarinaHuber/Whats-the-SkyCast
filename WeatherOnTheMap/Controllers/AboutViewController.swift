//
//  AboutViewController.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/26/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var webView: WKWebView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHtmlFile()
        activity.alpha = 1
        activity.startAnimating()
        
      }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 1.1, animations: {
            self.activity.alpha = 0

        }, completion: nil)
    }
    
    
    func loadHtmlFile() {
        webView = WKWebView(frame: CGRect( x: 0, y: 60, width: view.frame.width, height: view.frame.height - 20 ), configuration: WKWebViewConfiguration() )
        webView.navigationDelegate = self
        view.insertSubview(webView, belowSubview: activity)
        webView.allowsBackForwardNavigationGestures = true
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        webView.addConstraint(NSLayoutConstraint(item: webView, attribute: .left, relatedBy: .equal, toItem: webView, attribute: .right, multiplier: 1.0, constant: 0.0))
//        webView.addConstraint(NSLayoutConstraint(item: webView, attribute: .right, relatedBy: .equal, toItem: webView, attribute: .right, multiplier: 1.0, constant: 0.0))
        guard let path = Bundle.main.path(forResource: "WEATHERinfo", ofType: "html") else { return }
        let url = URL(fileURLWithPath:path)
        let request = URLRequest(url: url)
        
        webView.load(request)
       
    }



}
