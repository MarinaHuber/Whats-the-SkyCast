//
//  MainViewController.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/26/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	var settingsVC: SettingViewController?

    @IBOutlet weak var largeCollectionView: UICollectionView!
    @IBOutlet weak var smallCollectionView: UICollectionView!
    
    @IBOutlet weak var smallCollectionViewWidthConstraint: NSLayoutConstraint!

	private var citiesWeather: Array<ForcastBackground> = UserDefaults.standard.cities
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
		loadCities()
        largeCollectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "ID")
        smallCollectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "IDsmall")
		largeCollectionView.animateAppearance()
		smallCollectionView.animateAppearance()
    }

    func loadCities() {
		WeatherService.getCurrentWeatherAll {
			error, cities in

			self.citiesWeather = cities.map {
				ForcastBackground(cityName: $0.name ?? "", cityTemperature: $0.main.temp ?? 0, cityID: $0.weather[0].id ?? 0)
            }
			UserDefaults.standard.cities = self.citiesWeather
			self.reloadSections()

            
       }
     }
//MARK: GCD async on main queue
	func reloadSections() {

		DispatchQueue.main.async(execute: {
			self.largeCollectionView.reloadSections(IndexSet(integer: 0))
			self.smallCollectionView.reloadSections(IndexSet(integer: 0))

		})

	}
    
    
    public func setNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
    }

	override var prefersStatusBarHidden: Bool {
		return true
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		citiesWeather = UserDefaults.standard.cities

		largeCollectionView?.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: true)
		smallCollectionView?.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: true)
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

		switch collectionView {
        case largeCollectionView!:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath) as! collectionViewCell
			cell.labelCityName.text = cellData.cityName

   		    let tempResult = cellData.cityTemperature
// TO DO: convert Fahrenheit
//			let tempFahrenh = (tempResult * 1.8) + 32
//			let roundFah = Int(round(tempFahrenh))
			let temp = Int(round(tempResult))
			cell.labelCityTemerature.text = "\(temp)°C"
			let units1: String? = UserDefaults.standard.object(forKey: "Celsius") as? String
			let units2: String? = UserDefaults.standard.object(forKey: "Fahrenheit") as? String
//			if let unitsToDisplayCelsius = units1 {
//				cell.labelCityTemerature.text = "\(temp)\(unitsToDisplayCelsius)"
//			}
//			else if let unitsToDisplayFahrenheit = units2 {
//
//				cell.labelCityTemerature.text = "\(temp)\(unitsToDisplayFahrenheit)"
//			}

		 let weatherID = cellData.cityID
		    cell.updateWeatherIcon(conditionFor: weatherID)

            cell.configureCellWithType(.large)
			   return cell
       case smallCollectionView!:
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IDsmall", for: indexPath) as! collectionViewCell
			let tempResult1 = cellData.cityTemperature
			let temp = Int(round(tempResult1))
				cell.labelCityTemerature.text = "\(temp)°"
		if indexPath.row == citiesWeather.count - 1 {
			cell.isSelected = true
			largeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
			smallCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
		} else {
			cell.isSelected = false
		}
                cell.configureCellWithType(.small)
                return cell
        default:
                return UICollectionViewCell()
            }
        
    }


	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)

		if let settingsViewController = segue.destination as? SettingViewController, segue.identifier == "SettingsSegue" {
			settingsViewController.delegate = self
		}
	}


}

        
//MARK: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return collectionView != largeCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if smallCollectionView == collectionView {
			largeCollectionView.animateAppearance()
            smallCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            largeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}



//MARK: Passing data from SettingsVC to UICollectionView
extension MainViewController: SettingViewControllerDelegate {

	func citySelected(cityWeather: SingleCurrentWeather) {
		let forecastWeather = ForcastBackground(cityName: cityWeather.name ?? "", cityTemperature: cityWeather.main?.temp ?? 0, cityID: cityWeather.weather?.first?.id ?? 0)
		citiesWeather.append(forecastWeather)
		largeCollectionView.reloadData()
		smallCollectionView.reloadData()
		largeCollectionView?.scrollToItem(at: IndexPath(row: citiesWeather.count - 1, section: 0), at: .right, animated: true)
		smallCollectionView?.scrollToItem(at: IndexPath(row: citiesWeather.count - 1, section: 0), at: .right, animated: true)

		UserDefaults.standard.cities = citiesWeather
	}
}








//MARK: Cell Layout CollectionView
extension MainViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		guard largeCollectionView == collectionView else {
			return CGSize(width: 50, height: 50)
		}

		return CGSize(width: view.frame.width, height: view.frame.height)
	}


	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		if largeCollectionView == collectionView {
			return 0
		} else if smallCollectionView == collectionView {
			return 6
		}
		return 0
	}
}


//MARK: CollectionView scroll
extension MainViewController: UIScrollViewDelegate {

	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		if largeCollectionView == scrollView {
			let index = Int(targetContentOffset.pointee.x/view.frame.width)
			//currentCity = index
			let indexPath = IndexPath(item: index, section: 0)
			smallCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
		}
	}
}
