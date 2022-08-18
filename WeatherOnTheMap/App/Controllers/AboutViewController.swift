//
//  AboutViewController.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 7/26/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import Foundation
import UIKit


class AboutViewController: UIViewController {


	@IBOutlet weak var websiteButton: UIButton!
	@IBOutlet weak var creditsButton: UIButton!
	@IBOutlet weak var privacyButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		sutUpButtonUI()

	}

	func sutUpButtonUI() {
	websiteButton.layer.borderWidth = 1.5
	websiteButton.layer.borderColor = UIColor.black.cgColor
	websiteButton.layer.cornerRadius = 5
	websiteButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)


	privacyButton.layer.borderWidth = 1.5
	privacyButton.layer.borderColor = UIColor.black.cgColor
	privacyButton.layer.cornerRadius = 5

	creditsButton.layer.borderWidth = 1.5
	creditsButton.layer.borderColor = UIColor.black.cgColor
	creditsButton.layer.cornerRadius = 5
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationController?.navigationBar.isTranslucent = true
		navigationController?.view.backgroundColor = .clear
		navigationController?.navigationBar.barTintColor = .clear
		navigationController?.navigationBar.tintColor = .black
	}


	@IBAction func websiteCall(_ sender: Any) {
		if let url = URL(string: "http://www.marinahuber.com"),
			UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url, options: [:])
		}
	}

}

