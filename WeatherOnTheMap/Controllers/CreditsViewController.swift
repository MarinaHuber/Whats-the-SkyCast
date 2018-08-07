//
//  CreditsViewController.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 7/26/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import UIKit
import Lottie

class CreditsViewController: UIViewController {
	@IBOutlet weak var thnxLabel: UILabel!

	@IBOutlet weak var imgLogo: UIImageView!
	let animateView = LOTAnimationView(name: "logo_final")
	let animateView2 = LOTAnimationView(name: "loader_animation")
	

    override func viewDidLoad() {
        super.viewDidLoad()
		imgLogo.layer.cornerRadius = 16
		imgLogo.layer.masksToBounds = true
		thnxLabel.isHidden = true

    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)



		UIView.animate(withDuration: 1, delay: 3.0, options: .curveEaseIn, animations: {
			self.animateView.frame = CGRect(x: 0, y: self.view.frame.size.height/3, width: self.view.frame.size.width, height: self.view.frame.size.height/2)

			self.animateView2.frame = CGRect(x: 0, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: self.view.frame.size.height/2)
			self.animateView.contentMode = .scaleAspectFit
			self.animateView2.contentMode = .scaleAspectFit
			self.view.addSubview(self.animateView)
			self.view.addSubview(self.animateView2)
			self.animateView.play()
			self.animateView2.play()
		}, completion: { finished in
			self.thnxLabel.isHidden = false
		})
	}



}
