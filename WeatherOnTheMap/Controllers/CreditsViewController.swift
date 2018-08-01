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
	@IBOutlet weak var scrollView: UIScrollView!

	let animateView = LOTAnimationView(name: "logo_final")
	let animateView2 = LOTAnimationView(name: "loader_animation")
	

    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		animateView.frame = CGRect(x: 0, y: scrollView.frame.size.height/2, width: scrollView.frame.size.width, height: view.frame.size.height/2)
		animateView2.frame = CGRect(x: 0, y: view.frame.size.height/2, width: view.frame.size.width, height: view.frame.size.height/2)
		animateView.contentMode = .scaleAspectFit
		animateView2.contentMode = .scaleAspectFit
		view.addSubview(animateView)
		view.addSubview(animateView2)
		animateView.play()
		animateView2.play()
	}



}
