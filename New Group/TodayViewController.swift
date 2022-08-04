//
//  TodayViewController.swift
//  Widget
//
//  Created by Marina Huber on 10/7/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import UIKit
import NotificationCenter
import WidgetKit


class TodayViewController: UIViewController, NCWidgetProviding {
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var icomImgView: UIImageView!
	private let kAppGroupName = "group.com.hubermarina.SunWeather.Widget"
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)

		if let cityFromApp = UserDefaults.init(suiteName: kAppGroupName)?.value(forKey: "city") {
			cityLabel.text = cityFromApp as? String

		}
		if let cityFromApp = UserDefaults.init(suiteName: kAppGroupName)?.value(forKey: "icon") {
			updateWidgetIcon(cityFromApp as! Int)

		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
		if let cityFromApp = UserDefaults.init(suiteName: kAppGroupName)?.value(forKey: "city") {
			if cityFromApp as? String != cityLabel.text {
				cityLabel.text = cityFromApp as? String
				completionHandler(NCUpdateResult.newData)

			} else {
				completionHandler(NCUpdateResult.noData)
			}


		} else  {
				self.cityLabel.text = "Open your app to read your weather."
				completionHandler(NCUpdateResult.newData)
			}
        
		if let cityIcon = UserDefaults.init(suiteName: kAppGroupName)?.value(forKey: "icon") {
			if (cityIcon as? Int)! >= 0 {
				updateWidgetIcon(cityIcon as! Int)
				completionHandler(NCUpdateResult.newData)

			} else {
				completionHandler(NCUpdateResult.noData)
			}
		} else  {
			print("error image")
			completionHandler(NCUpdateResult.newData)
		}
    }







	func updateWidgetIcon(_ conditionFor: Int) {
		var imageName:String
		switch conditionFor {
		case 200..<300:
			imageName = "thunder"
		case 300..<700:
			imageName = "rain"
		case 701..<799:
			imageName = "snow"
		case 800:
			imageName = "sunny"
		case 801..<805:
			imageName = "cloud"
		default:
			imageName = "sunny"
			break
		}
		self.icomImgView.image = UIImage(named: imageName)
	}


}
