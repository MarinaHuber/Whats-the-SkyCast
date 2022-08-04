//
//  AppDelegate.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/26/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import UIKit
import SystemConfiguration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		let controller = MainViewController()
		controller.setNeedsStatusBarAppearanceUpdate()

		let reachability = Reachability()!
		if reachability.connection != .none {
		} else {
			print("Internet connection FAILED")
			let alert = UIAlertController(title: "No Internet connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
			let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
			alert.addAction(OKAction)
			let alertWindow = UIWindow(frame: UIScreen.main.bounds)
			alertWindow.rootViewController = UIViewController()
			alertWindow.windowLevel = UIWindow.Level.alert + 1;
			alertWindow.makeKeyAndVisible()


			if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {

			} else {
				alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
			}

		}
        return true
    }

	func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {

		switch UIDevice().userInterfaceIdiom {
		case UIUserInterfaceIdiom.pad:

			return .portrait
		default:
			return .portrait
		}


	}

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//UI CUSTOMIZATION
extension AppDelegate {

	func customizeUI() {
		UINavigationBar.appearance().isTranslucent = true
		UINavigationBar.appearance().backgroundColor = UIColor.clear
		UINavigationBar.appearance().barTintColor = UIColor.white
		UINavigationBar.appearance().tintColor = UIColor.black
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
		UINavigationBar.appearance().shadowImage = UIImage()
		UINavigationBar.appearance().layer.shadowColor = UIColor.clear.cgColor

	}

}


