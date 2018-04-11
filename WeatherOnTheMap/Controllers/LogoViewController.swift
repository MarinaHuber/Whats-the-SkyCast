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

	let animateView = LOTAnimationView(name: "loader_animation")

	override func viewDidLoad() {
		super.viewDidLoad()
		animateView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
		animateView.contentMode = .scaleAspectFill
		view.addSubview(animateView)
		animateView.play()

		UIView.animate(withDuration: 0.1, delay: 4.0, options: .curveEaseIn, animations: {
			self.view.alpha = 0



		}, completion: { finished in
			self.switchScreen()
		})

	}

	func switchScreen() {
		let storyboard = UIStoryboard(name: "Main", bundle: .main)
		let vc : UIViewController = storyboard.instantiateViewController(withIdentifier: "main") as! MainViewController
		self.navigationController?.present(vc, animated: true, completion: nil)


	}

}
