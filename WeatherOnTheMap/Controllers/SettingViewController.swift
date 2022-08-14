//
//  SettingViewController.swift
//  MangroveWeatherForecastDemo
//
//  Created by Marina Huber on 1/28/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import UIKit

protocol SettingViewControllerDelegate: class {
	func citySelected(cityWeather: City)
}

class SettingViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
		
	@IBOutlet weak var pickerView: UIPickerView!
	var celsiusBlock: (() -> ())?
	var fahrenheitBlock: (() -> ())?
	
	
	var isHidden: Bool = true {
		didSet {
			pickerView.isHidden = isHidden ? true :  false
		}
	}
	weak var delegate: SettingViewControllerDelegate?
	var dataSourcePicker:[String] = []
	
	private var citiesWeather: Array<ForcastBackground> = UserDefaults.standard.cities
	
	@IBOutlet weak var buttonTitleLocation: UIButton!
	@IBOutlet weak var buttonTitleTemp: UIButton!
	@IBOutlet weak var buttonTitleDays: UIButton!
	var popOver:UIPopoverPresentationController?

	var currentUnit: String?
	var unitsTitle = "unitsChanged"

	enum UserDefaultsUnitKey: String {
		case celsius = "C"
		case fahrenheit = "F"
	}

	let unitsData = [UserDefaultsUnitKey.celsius.rawValue, UserDefaultsUnitKey.fahrenheit.rawValue]
	var mode: Int? = Int()

	let daysData = [DaysPicker.Today.rawValue, DaysPicker.two.rawValue, DaysPicker.three.rawValue, DaysPicker.four.rawValue, DaysPicker.five.rawValue]
	
	enum DaysPicker: String {
		case Today
		case two
		case three
		case four
		case five
	}




	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.separatorColor = .black
		tableView.allowsSelection = false
		tableView.delegate = self
		tableView.dataSource = self
		mode = 0
	
		pickerView.dataSource = self
		pickerView.delegate = self
		pickerView.isHidden = true
		buttonTitleTemp.setTitle(changedUnits(), for: .normal)
		
		let indexOfDefaultElement = 0 // Make sure that an element at this index exists
		pickerView.selectRow(indexOfDefaultElement, inComponent: 0, animated: false)
		
		buttonTitleDays.setTitle(daysData[0], for: .normal)

	}

	override func viewWillAppear(_ animated: Bool) {
	   navigationController?.navigationBar.isTranslucent = true
	   navigationController?.view.backgroundColor = .clear
	   navigationController?.navigationBar.barTintColor = .clear
	   buttonTitleTemp.titleLabel?.adjustsFontSizeToFitWidth = true


	}

	@IBAction func buttonUnits(_ sender: Any) {
		buttonTitleTemp.setTitle(changedUnits(), for: .normal)
		toggleDatepicker()
		dataSourcePicker = unitsData
		self.pickerView.reloadAllComponents()
	}
	
	@IBAction func buttonDays(_ sender: UIButton) {
		toggleDatepicker()
		dataSourcePicker = daysData
		pickerView.reloadAllComponents()
		
	}
	func toggleDatepicker() {
		isHidden = !isHidden
		tableView.endUpdates()
	}

	public func changedUnits() -> String {
		let units: String? = UserDefaults.standard.object(forKey: unitsTitle) as? String
		if let unitsToDisplay = units {
			currentUnit = unitsToDisplay
		return "°\(unitsToDisplay)"
		}
		//default value on first 
		return "°C"
	}

	@IBAction func buttonCityAdd(_ sender: Any) {

		addCity() { city in
			if city.isEmpty == false {
				WeatherService.getOneCity(city, completionHandler: { result in
					switch result {
					case .success(let one):
                        let forecastWeather = ForcastBackground(cityName: one.name ?? "", cityTemperature: one.main.temp ?? 0, cityID: one.weather.first?.id ?? 0)
						self.buttonTitleLocation.titleLabel?.text = forecastWeather.cityName
						self.citiesWeather.append(forecastWeather)
						self.delegate?.citySelected(cityWeather: one)
                        self.navigationController?.popViewController(animated: true)
					case .failure(let error):
						print(error)
						self.alert(message: "No city found", title: "Location unknown")

					}
					
				})

			} else {
				print("No city provided")
				self.alert(message: "You did not enter a city", title: "Location")

				
			}
		}


	}



	func addCity (_ completionHandler : @escaping (String) -> () ) {

		let alertController = UIAlertController(title: "Location", message: "Enter the city you want the forcast for", preferredStyle: .alert)
		
		alertController.addTextField(
			configurationHandler: {(textField: UITextField!) in
				textField.placeholder = "City name..."
		})
		let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: {
			(action : UIAlertAction!) -> Void in })
		
		let action = UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: {
			(paramAction:UIAlertAction!) in
			if let textFields = alertController.textFields {
				let theTextFields = textFields as [UITextField]

				if let city = theTextFields[0].text, city.isEmpty == false {
					completionHandler(city)
				} else {
					completionHandler("")
				}
			}
			
		})
		
		alertController.addAction(action)
		alertController.addAction(cancelAction)
		self.present(alertController, animated: true)

	// if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
			//TODO: UIPopoverPresentationController
			//self.popOver = UIPopoverPresentationController(contentViewController: action)
			//self.popOver?.present(from: buttonTitleLocation.frame, in: self, permittedArrowDirections: UIPopoverArrowDirection.up, animated: true)

	//	} else {
		//self.present(alertController!, animated: true, completion: nil)
	//	}
		
	}


	//IS THIS USED???
	func alert(message: String, title: String) {
		DispatchQueue.main.async {
			let alertController = UIAlertController(title: title, message:   message, preferredStyle: .alert)
			let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
			alertController.addAction(OKAction)
			self.present(alertController, animated: true)
		}

	}




	//MARK: UIPickerViewDataSourcefunc
	
	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	
	public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return dataSourcePicker.count
	}
	
	
	public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return "°\(dataSourcePicker[row])"
	}
	
	//https://stackoverflow.com/questions/41705050/uipickerview-sending-data-without-segue

	public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
		if dataSourcePicker == daysData {
			let selectedUnits = daysData[row]
			buttonTitleDays.titleLabel?.text = selectedUnits
			
		} else if dataSourcePicker == unitsData {
			
			currentUnit = unitsData[row]

			buttonTitleTemp.titleLabel?.text = "°\(currentUnit ?? "°C")"

	//   pass this to MainVC, currentUnit?.first! = first chosen in picker
			let chosen = pickerView.selectedRow(inComponent: 0)
			print(chosen)
			if chosen == 0 {
				celsiusBlock?()
			} else if chosen == 1 {
				fahrenheitBlock?()
			}

			UserDefaults.standard.set(currentUnit, forKey: unitsTitle)
			UserDefaults.standard.synchronize()
		}
		
		toggleDatepicker()
		tableView.endUpdates()
		pickerView.resignFirstResponder()
		
	}


	
	@IBAction func backToMainView(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
		
	}
	
	
	
	
}
