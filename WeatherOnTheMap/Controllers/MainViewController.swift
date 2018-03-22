//
//  MainViewController.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/26/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	let shared = WeatherService()
	var settingsVC: SettingViewController?

    @IBOutlet weak var largeCollectionView: UICollectionView!
    @IBOutlet weak var smallCollectionView: UICollectionView!
    
    @IBOutlet weak var smallCollectionViewWidthConstraint: NSLayoutConstraint!

	//to do intial scroll and prevent flickering
	var initialScrollDone: Bool = false
	var currentCity: Int?
	var unitSetting: String?

// Array for every call made to the group of 6 cities ID
	private var backgrounds: Array<ForcastBackground> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
//		smallCollectionView.reloadData()
//		largeCollectionView.reloadData()

        largeCollectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "ID")
        smallCollectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "IDsmall")
		largeCollectionView.animateAppearance()
		smallCollectionView.animateAppearance()
    }

    func loadCities() {
		shared.getCurrentWeather {
			error, cities in

		//	guard cities != nil else {return}

			self.backgrounds = cities.map {
				ForcastBackground(city: $0.name!, cityTemperature: $0.main.temp!, cityID: $0.weather[0].id!)
            }
			self.reloadSections()
            
       }
     }
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
		//TODO: without this i get a crash?
		guard currentCity != nil else {
			print ("I cannot mark city, as I don't know which city is displayed")
			return
		}

		if (!initialScrollDone) {
			let indexPath = IndexPath(item: currentCity ?? 3, section: 0)
			print(#file, #line, #function, (indexPath), "my first item selected")
			largeCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
			smallCollectionView?.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
			initialScrollDone = true
		}

		smallCollectionViewWidthConstraint.constant = min(view.frame.width - 20, smallCollectionView.contentSize.width)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		loadCities()
		largeCollectionView?.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: true)
		smallCollectionView?.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: true)
    }

    

}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return backgrounds.count
    }






    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = self.backgrounds[indexPath.row]
        switch collectionView {
        case largeCollectionView!:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath) as! collectionViewCell
			cell.labelCityName.text = cellData.city

   		    let tempResult = cellData.cityTemperature
			let temp = Int(round(tempResult))
			let units1: String? = UserDefaults.standard.object(forKey: "Celsius") as? String
			let units2: String? = UserDefaults.standard.object(forKey: "Fahrenheit") as? String
			if let unitsToDisplayCelsius = units1 {
				cell.labelCityTemerature.text = "\(temp)\(unitsToDisplayCelsius)"
			} else if let unitsToDisplayFahrenheit = units2 {
				cell.labelCityTemerature.text = "\(temp)\(unitsToDisplayFahrenheit)"
			}

		 let weatherID = cellData.cityID
		    cell.updateWeatherIcon(conditionFor: weatherID)

            cell.configureCellWithType(.large)
			   return cell
       case smallCollectionView!:
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IDsmall", for: indexPath) as! collectionViewCell
			let tempResult1 = cellData.cityTemperature
			let temp = Int(round(tempResult1))
				cell.labelCityTemerature.text = "\(temp)°"
		if indexPath.row == 0 {
			cell.isSelected = true
			smallCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
			largeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
		} else {
			cell.isSelected = false
		}
                cell.configureCellWithType(.small)
                return cell
        default:
                return UICollectionViewCell()
            }
        
    }







	override var prefersStatusBarHidden: Bool {
		return true
	}
    
    
}




        
        
        
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return collectionView != largeCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if smallCollectionView == collectionView {
			currentCity = indexPath.row
			largeCollectionView.animateAppearance()
            smallCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            largeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard largeCollectionView == collectionView else {
            return CGSize(width: 50, height: 50)
        }
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if largeCollectionView == scrollView {
            let index = Int(targetContentOffset.pointee.x/view.frame.width)
			currentCity = index
            let indexPath = IndexPath(item: index, section: 0)
            
            smallCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}
