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
	@IBOutlet weak var text: UILabel!
	@IBOutlet var presentText: UIView!
	@IBOutlet weak var photoLabel: UILabel!

	let animateView = LOTAnimationView(name: "logo_final")
	let animateView2 = LOTAnimationView(name: "loader_animation")
	

    override func viewDidLoad() {
        super.viewDidLoad()
		imgLogo.isHidden = true
		imgLogo.layer.cornerRadius = 16
		imgLogo.layer.masksToBounds = true
		thnxLabel.isHidden = true
		presentText.isHidden = true
		text.isHidden = true
		photoLabel.isHidden = true

	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		navigationController?.navigationBar.topItem?.title = " "
		navigationItem.title = "Thanks to:"

		UIView.animate(withDuration: 2.0, delay: 0.2, options: .curveEaseInOut, animations: {
			let iPhone = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/2)
			let isPad = UIDevice().userInterfaceIdiom  == .pad
			self.animateView.frame = isPad ? CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/2) : iPhone

			let iPhone2 = CGRect(x: 0, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: self.view.frame.size.height/2)
			self.animateView2.frame = isPad ? CGRect(x: 0, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: self.view.frame.size.height/2) : iPhone2

			self.animateView.contentMode = .scaleAspectFit
			self.animateView2.contentMode = .scaleAspectFit
			self.view.addSubview(self.animateView)
			self.view.addSubview(self.animateView2)
			self.animateView.alpha = 1
			self.animateView2.alpha = 1
			self.animateView.play()
			self.animateView2.play()
		}, completion: { finished in
			self.presentText.isHidden = false
			self.text.isHidden = false
			self.thnxLabel.isHidden = false
			self.imgLogo.isHidden = false
			self.photoLabel.isHidden = false
			self.animateView.alpha = 0
			self.animateView2.alpha = 0
			//self.animateView.removeFromSuperview()
			//self.animateView2.removeFromSuperview()

		})
	}



}
