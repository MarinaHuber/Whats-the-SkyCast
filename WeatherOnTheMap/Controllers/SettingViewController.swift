//
//  SettingViewController.swift
//  MangroveWeatherForecastDemo
//
//  Created by Marina Huber on 1/28/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import UIKit

protocol SettingViewControllerDelegate: class {
	func citySelected(cityWeather: SingleCurrentWeather)
}

class SettingViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
	
	var inputCityText: String = ""
	
	@IBOutlet weak var pickerView: UIPickerView!
	
	
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
	
	let unitsTitle = "unitsTitle"
	
	let unitsData = [UserDefaultsUnitKey.Fahrenheit.rawValue, UserDefaultsUnitKey.Celsius.rawValue]
	
	enum UserDefaultsUnitKey: String {
		case Fahrenheit = "°F"
		case Celsius = "°C"
	}
	
	var currentUnit: String?
	
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
		
		pickerView.dataSource = self
		pickerView.delegate = self
		pickerView.isHidden = true
		
		let indexOfDefaultElement = 0 // Make sure that an element at this index exists
		pickerView.selectRow(indexOfDefaultElement, inComponent: 0, animated: false)
		
		buttonTitleDays.setTitle(daysData[0], for: .normal)

	}

	override func viewWillAppear(_ animated: Bool) {

       buttonTitleTemp.setTitle(changedUnits(), for: .normal)
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
		return unitsToDisplay
		}
		return "Unknown"
	}
	@IBAction func buttonCityAdd(_ sender: Any) {
		
		
		var alertController:UIAlertController?
		alertController = UIAlertController(title: "Location", message: "Enter the city you want the forcast for", preferredStyle: .alert)
		
		alertController!.addTextField(
			configurationHandler: {(textField: UITextField!) in
				textField.placeholder = "City name..."
		})
		let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: {
			(action : UIAlertAction!) -> Void in })
		
		let action = UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: { [weak self]
			(paramAction:UIAlertAction!) in
			if let textFields = alertController?.textFields{
				//self?.buttonTitleLocation.titleLabel?.text = citiesWeather
				let theTextFields = textFields as [UITextField]
				self?.inputCityText = theTextFields[0].text!
				guard let city = self?.inputCityText else { return }
				WeatherService.getCityWeather(city) { cityWeather, error in
					let forecastWeather = ForcastBackground(cityName: cityWeather.name ?? "", cityTemperature: cityWeather.main?.temp ?? 0, cityID: cityWeather.weather?.first?.id ?? 0)
					self?.buttonTitleLocation.titleLabel?.text = forecastWeather.cityName
					self?.citiesWeather.append(forecastWeather)
					self?.delegate?.citySelected(cityWeather: cityWeather)
				}
				
				
				
			}
			
		})
		
		alertController?.addAction(action)
		alertController?.addAction(cancelAction)
		self.present(alertController!, animated: true, completion: nil)
		
	}
	
	
	
	
	//MARK: UIPickerViewDataSourcefunc
	
	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	
	public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return dataSourcePicker.count
	}
	
	
	public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return dataSourcePicker[row]
	}
	
	
	public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
		if dataSourcePicker == daysData {
			let selectedUnits = daysData[row]
			buttonTitleDays.titleLabel?.text = selectedUnits
			
		} else if dataSourcePicker == unitsData {
			
			currentUnit = unitsData[row]
			buttonTitleTemp.titleLabel?.text = currentUnit
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
