//
//  MainViewController.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/26/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var loadMainFeed: MainVCLoader!

    convenience init(loader: MainVCLoader) {
        self.init()
        self.loadMainFeed = loader
    }

	var settingsVC: SettingViewController!

	@IBOutlet weak var largeCollectionView: UICollectionView!
	@IBOutlet weak var smallCollectionView: UICollectionView!

//not connected
	@IBOutlet weak var smallCollectionViewWidthConstraint: NSLayoutConstraint!

	private var citiesWeather: Array<ForcastBackground> = UserDefaults.standard.cities

	private var selectedUnit: String? {
		// show from UserDefault
		return UserDefaults.standard.string(forKey: "unitsChanged") ?? "C"
	}
	var unitType: Int? = 0





	override func viewDidLoad() {
		super.viewDidLoad()
	//TODO: setNavigationBar() -> appDelegate
		loadCities()
		largeCollectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "ID")
		smallCollectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "IDsmall")

	}

	func loadCities() {
		if citiesWeather.isEmpty {

            loadMainFeed.getCurrentWeather { result in
				switch result {
				case .success(let cities):
					self.citiesWeather = cities.map {
						ForcastBackground(cityName: $0.name ?? "", cityTemperature: $0.main.temp ?? 0, cityID: $0.weather[0].id ?? 0)
					}
					UserDefaults.standard.cities = self.citiesWeather
					self.reloadSectionsUI()
				case .failure(let error):
					print(error)
				}
			}

		}
	}
	
	//MARK: GCD async for closure
	func reloadSectionsUI() {

		DispatchQueue.main.async(execute: {
			self.largeCollectionView.reloadSections(IndexSet(integer: 0))
			self.smallCollectionView.reloadSections(IndexSet(integer: 0))
			//important! on main thread random first scroll selected
            self.largeCollectionView.isPagingEnabled = false
			self.largeCollectionView?.scrollToItem(at: IndexPath(row: self.citiesWeather.count - 4, section: 0), at: .centeredHorizontally, animated: true)
            self.largeCollectionView.isPagingEnabled = true
			self.smallCollectionView?.selectItem(at: IndexPath(row: self.citiesWeather.count - 4, section: 0), animated: true, scrollPosition: .centeredHorizontally)
			self.largeCollectionView.animateAppearance()
			self.smallCollectionView.animateAppearance()

		})

	}


	public func setNavigationBar() {
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.view.backgroundColor = UIColor.clear

	}


	override func viewWillLayoutSubviews() {
        largeCollectionView.layoutIfNeeded()
	}

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigationBar()
        largeCollectionView.contentInset = UIEdgeInsets.zero
        
        if !citiesWeather.isEmpty {
            largeCollectionView.isPagingEnabled = false
            largeCollectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
            largeCollectionView.isPagingEnabled = true
            
            smallCollectionView?.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                //Reload here to update units for first load
          //  largeCollectionView?.reloadItems(at: [IndexPath(row: self.citiesWeather.count - 1, section: 0)])
                //smallCollectionViewWidthConstraint.constant = min(view.frame.width - 20, smallCollectionView.contentSize.width)
            citiesWeather = UserDefaults.standard.cities
        }

	}

}

//MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return citiesWeather.count
	}





	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if indexPath.row > citiesWeather.count {
			print(indexPath.row)
		}
		let cellData = self.citiesWeather[indexPath.row]
		let tempResult = cellData.cityTemperature
		switch collectionView {
		case largeCollectionView!:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath) as! collectionViewCell
			cell.labelCityName.text = cellData.cityName
            cell.labelCity.text = Localizations.cityLabel
//TODO: place to model
			let temp = cToFahrenheit(tempC: tempResult)
			let tempF = Int(round(temp))
			let tempC = Int(round(tempResult))

			if (selectedUnit != nil) {
				//fix here the first load of vc main
			if (unitType == 0) {
				   cell.labelCityTemerature.text = "\(tempC)°\(self.selectedUnit ?? "C")"
				   cell.labelCityTemerature.animateAppearance()
			} else if unitType == 1 {
					cell.labelCityTemerature.text = "\(tempF)°\(self.selectedUnit ?? "F")"
					cell.labelCityTemerature.animateAppearance()
				  }
			} else if (unitType == nil && selectedUnit == nil) {

				cell.labelCityTemerature.text = "\(tempC)°C"
			}

			let weatherID = cellData.cityID
			UserDefaults.init(suiteName: "group.com.hubermarina.SunWeather.Widget")?.set(weatherID, forKey: "icon")
			cell.updateWeatherIcon(conditionFor: weatherID)
			cell.updateAnimationIcon(conditionFor: weatherID)

			cell.configureCellWithType(.large)
			return cell

		case smallCollectionView!:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IDsmall", for: indexPath) as! collectionViewCell
			let temp = cToFahrenheit(tempC: tempResult)
			let tempF = Int(round(temp))
			
			let tempC = Int(round(tempResult))

				//fix here the first load of vc main
				if (unitType == 0) {
					cell.labelCityTemerature.text = "\(tempC)°"
					cell.labelCityTemerature.animateAppearance()
				} else if unitType == 1 {
					cell.labelCityTemerature.text = "\(tempF)°"
					cell.labelCityTemerature.animateAppearance()
				} else if unitType == nil {

					cell.labelCityTemerature.text = "\(tempC)°"
			}
            
//            if indexPath.row == 0 {
//                cell.isSelected = true
//              //  smallCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
//                largeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
//            } else {
//                cell.isSelected = false
//            }

			cell.configureCellWithType(.small)
			return cell
		default:
			return UICollectionViewCell()
		}

	}







	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		// TODO: refactor
		let reachability = Reachability()!
		if reachability.connection != .none {
		} else {
			print("Internet connection FAILED")
			let alert = UIAlertController(title: "No Internet connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
			let alertWindow = UIWindow(frame: UIScreen.main.bounds)
			alertWindow.rootViewController = UIViewController()
			alertWindow.windowLevel = UIWindow.Level.alert + 1;
			alertWindow.makeKeyAndVisible()


			if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {

			} else {
				alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
			}

		}
		if let settingsViewController = segue.destination as? SettingViewController, segue.identifier == "SettingsSegue" {
			settingsViewController.delegate = self
			// passing picker value from block and gobal Int property
			settingsViewController.celsiusBlock = {
				self.unitType = 0
				self.smallCollectionView.reloadData()
			}
			settingsViewController.fahrenheitBlock = {
				self.unitType = 1
				self.smallCollectionView.reloadData()
			}

		}
	}



	// MARK: - Helper functions for temperature conversion
	func cToFahrenheit(tempC: Double) -> Double {
		return (tempC * 1.8) + 32
	}

	override var prefersStatusBarHidden: Bool {
		return false
	}

}


//MARK: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
		return collectionView != largeCollectionView
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if smallCollectionView == collectionView {
            self.largeCollectionView.isPagingEnabled = false
			smallCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
			largeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.largeCollectionView.isPagingEnabled = false
		}
	}
}



//MARK: Passing data from SettingsVC to UICollectionView
extension MainViewController: SettingViewControllerDelegate {

	func citySelected(cityWeather: SingleCurrentWeather) {
		let forecastWeather = ForcastBackground(cityName: cityWeather.name ?? "", cityTemperature: cityWeather.main?.temp ?? 0, cityID: cityWeather.weather?.first?.id ?? 0)
		citiesWeather.append(forecastWeather)
		//important! on background thread
		largeCollectionView.reloadData()
		smallCollectionView.reloadData()
        self.largeCollectionView.isPagingEnabled = false
		largeCollectionView?.scrollToItem(at: IndexPath(row: citiesWeather.count - 1, section: 0), at: .centeredHorizontally, animated: true)
        self.largeCollectionView.isPagingEnabled = true
		smallCollectionView?.selectItem(at: IndexPath(row: citiesWeather.count - 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)


		UserDefaults.standard.cities = citiesWeather
	}
}








//MARK: Cell Layout CollectionView
extension MainViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		guard largeCollectionView == collectionView else {
			return CGSize(width: 60, height: 60)
		}

		return CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
	}


	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		if largeCollectionView == collectionView {
			return 0
		} else if smallCollectionView == collectionView {
			return 17
		}
		return 0
	}

	//For top/bottom/left/right padding method
	func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

		if largeCollectionView == collectionView {
			if #available(iOS 11, *) {
				let window = UIApplication.shared.windows[0]
				let insets:UIEdgeInsets = window.safeAreaInsets
				return insets
			}
		} else if smallCollectionView == collectionView {
			switch UIDevice().userInterfaceIdiom {
			case UIUserInterfaceIdiom.pad:
				let totalCellWidth = 60 * 6
				let totalSpacingWidth = 7 * (6 - 1)
				let leftInset = (view.bounds.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
				let rightInset = leftInset
				return UIEdgeInsets(top: 10, left: leftInset, bottom: 10, right: rightInset)
			default:

			return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
			}
		}
		return UIEdgeInsets()
	}

}


//MARK: CollectionView scroll
extension MainViewController: UIScrollViewDelegate {

	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		if largeCollectionView == scrollView {
			let index = Int(targetContentOffset.pointee.x/view.frame.width)
			let indexPath = IndexPath(item: index, section: 0)
			smallCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
		}
	}
}
