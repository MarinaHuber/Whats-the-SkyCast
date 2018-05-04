//
//  LogoViewController.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 4/11/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import UIKit
import Lottie

class LogoViewController: UIViewController {
	let animateView = LOTAnimationView(name: "logo_final")
	let animateView2 = LOTAnimationView(name: "loader_animation")

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.view.backgroundColor = UIColor.clear
		animateView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/2)
		animateView2.frame = CGRect(x: 0, y: view.frame.size.height/2, width: view.frame.size.width, height: view.frame.size.height/2)
		animateView.contentMode = .scaleAspectFit
		animateView2.contentMode = .scaleAspectFit
		view.addSubview(animateView)
		view.addSubview(animateView2)
		animateView.play()
		animateView2.play()

		UIView.animate(withDuration: 1, delay: 3.0, options: .curveEaseIn, animations: {
			self.view.alpha = 0

		}, completion: { finished in
			self.switchScreen()
		})

	}

	func switchScreen() {
		let storyboard = UIStoryboard(name: "Main", bundle: .main)
		let vc : UIViewController = storyboard.instantiateViewController(withIdentifier: "main") as! MainViewController
		self.navigationController?.pushViewController(vc, animated: true)


	}

}
