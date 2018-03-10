//
//  UIView+Extension.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 3/8/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

	var defaultTransition: Double {
		get {
			return 0.7
		}
	}

	var defaultDelay: Double {
		get {
			return 0.4
		}
	}


	

	func animateAppearanceWithDelay(_ delay: Double) {

		self.alpha = 0
		UIView.animate(withDuration: self.defaultTransition, delay: delay, options: .curveEaseIn, animations: {
			self.alpha = 1
		}, completion: nil)
	}

	func animateAppearance() {

		self.alpha = 0
		UIView.animate(withDuration: defaultTransition, delay: 0, options: .curveEaseIn, animations: {
			self.alpha = 1
		}, completion: nil)
	}

	func animateDisappearance() {

		self.alpha = 1
		UIView.animate(withDuration: defaultTransition, delay: 0, options: .curveEaseIn, animations: {
			self.alpha = 0
		}, completion: nil)
	}



	func animateDisappearanceWithDelay(_ delay: Double) {

		self.alpha = 1
		UIView.animate(withDuration: defaultTransition, delay: delay, options: .curveEaseIn, animations: {
			self.alpha = 0
		}, completion: nil)
   }


}
