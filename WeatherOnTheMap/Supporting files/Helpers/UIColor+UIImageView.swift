//
//  UIColor.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 3/8/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
	static var random: CGFloat {
		return CGFloat(arc4random()) / CGFloat(UInt32.max)
	}
}

extension UIColor {
	static var randomColor: UIColor {
		return UIColor(red: .random, green: .random, blue: .random, alpha: 0.3)
	}
}

extension UIImageView
{
	func addBlurEffect()
	{
		let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.bounds

		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		self.addSubview(blurEffectView)
	}
}
