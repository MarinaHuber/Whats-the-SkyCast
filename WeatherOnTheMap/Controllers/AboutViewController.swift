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

		websiteButton.layer.borderWidth = 1.5
		websiteButton.layer.borderColor = UIColor.black.cgColor
		websiteButton.layer.cornerRadius = 5


		privacyButton.layer.borderWidth = 1.5
		privacyButton.layer.borderColor = UIColor.black.cgColor
		privacyButton.layer.cornerRadius = 5

		creditsButton.layer.borderWidth = 1.5
		creditsButton.layer.borderColor = UIColor.black.cgColor
		creditsButton.layer.cornerRadius = 5
	}

	@IBAction func websiteCall(_ sender: Any) {
		if let url = URL(string: "http://www.marinahuber.com"),
			UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url, options: [:])
		}
	}

}

