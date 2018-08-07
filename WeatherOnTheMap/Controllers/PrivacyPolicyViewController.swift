//
//  AboutViewController.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/26/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
	var webView: WKWebView!
	
	@IBOutlet weak var activity: UIActivityIndicatorView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.topItem?.title = ""
		self.navigationItem.title = "Privacy policy"
		self.navigationController?.navigationBar.isTranslucent = false
		self.navigationController?.navigationBar.tintColor = .black
		self.navigationController?.navigationBar.barTintColor = UIColor(red: 222.0/255.0, green: 239.0/255.0, blue: 245.0/255.0, alpha: 1)
		self.navigationController?.view.backgroundColor = UIColor(red: 222.0/255.0, green: 239.0/255.0, blue: 245.0/255.0, alpha: 1)
		loadHtmlFile()
		activity.alpha = 1
		activity.startAnimating()
		
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		UIView.animate(withDuration: 2.6, animations: {
			self.activity.alpha = 0
			
		}, completion: nil)
	}
	
	
	func loadHtmlFile() {
//		webView = WKWebView(frame: CGRect( x: 0, y: 80, width: view.frame.width, height: view.frame.height - 60 ), configuration: WKWebViewConfiguration() )
		webView = WKWebView(frame: self.view.frame)
		webView.navigationDelegate = self

		view.addSubview(webView)
		view.bringSubview(toFront: activity)
		guard let path = Bundle.main.path(forResource: "WEATHERinfo", ofType: "html") else { return }
		let url = URL(fileURLWithPath:path)
		let request = URLRequest(url: url)
		
		webView.load(request)
		
	}
	

}
