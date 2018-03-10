//
//  SettingViewController.swift
//  MangroveWeatherForecastDemo
//
//  Created by Marina Huber on 1/28/18.
//  Copyright © 2018 Marina Huber. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

	var inputCityText: String = ""

	@IBOutlet weak var pickerView: UIPickerView!


	var isHidden: Bool = true {
		didSet {

			pickerView.isHidden = isHidden ? true :  false
		}
	}



	var dataSource:[String] = []
	@IBOutlet weak var buttonTitleLocation: UIButton!
	@IBOutlet weak var buttonTitleTemp: UIButton!
	@IBOutlet weak var buttonTitleDays: UIButton!

	let unitData = [UnitsPicker.Fahrenheit.rawValue, UnitsPicker.Celsius.rawValue]

	enum UnitsPicker: String {
		case Fahrenheit
		case Celsius
	}



	let daysData = [DaysPicker.today.rawValue, DaysPicker.two.rawValue, DaysPicker.three.rawValue, DaysPicker.four.rawValue, DaysPicker.five.rawValue]

	enum DaysPicker: String {
		case today
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

		buttonTitleTemp.setTitle(unitData[0], for: .normal)
		buttonTitleDays.setTitle(daysData[0], for: .normal)

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
				let theTextFields = textFields as [UITextField]
				self?.inputCityText = theTextFields[0].text!
				//self!.currentForcastLabel.text = self?.inputCityText

//  1. create basic request without making the object first
//  2. getCurrenWeather is after made the object

				let urlString = ""// String("\(Constants.base_URL)/weather?q=" + (self?.inputCityText.replacingOccurrences(of: " ", with: "%20"))! + ",uk&appid=\(Constants.APIKey)")
				//  print(urlString)

				guard let url = URL(string: urlString) else { return }

				URLSession.shared.dataTask(with: url) { (data, response, err) in

					guard let data = data else { return }
					do {
						let decoder = JSONDecoder()
						if #available(iOS 10.0, *) {
							decoder.dateDecodingStrategy = .iso8601
						} else {

							decoder.dateDecodingStrategy = .secondsSince1970
						}
						let currentForecastDecoded = try decoder.decode(AllCurrentWeather.self, from: data)
						//print(currentForecastDecoded)
						for city in currentForecastDecoded.cities {
							print(city.name)
							DispatchQueue.main.async(execute: {
								self?.buttonTitleLocation.titleLabel?.text = city.name


							})
						}


					} catch let jsonErr {
						print("Error serializing json:", jsonErr)

					}

					}.resume()




			}

		})

		alertController?.addAction(action)
		alertController?.addAction(cancelAction)
		self.present(alertController!, animated: true, completion: nil)
    }










	@IBAction func buttonUnits(_ sender: Any) {
		toggleDatepicker()
		dataSource = unitData
		pickerView.reloadAllComponents()

	}

	@IBAction func buttonDays(_ sender: UIButton) {
		toggleDatepicker()
		dataSource = daysData
		pickerView.reloadAllComponents()

	}





//MARK: UIPickerViewDataSourcefunc

	// returns the number of 'columns' to display.
	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}


	public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return dataSource.count
	}

	public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return dataSource[row]
	}
	public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

		if dataSource == daysData {
			let selectedUnits = daysData[row]
			buttonTitleDays.titleLabel?.text = selectedUnits

		} else {
			let selectedUnits = unitData[row]
			buttonTitleTemp.titleLabel?.text = selectedUnits

		}

		toggleDatepicker()
		tableView.endUpdates()
		pickerView.resignFirstResponder()

	}

	func toggleDatepicker() {

		isHidden = !isHidden
		tableView.endUpdates()


	}

	@IBAction func backToMainView(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}


	
	// to show in Dashboard vc
//	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//		let wod = FilteredWodList[index]
//		if segue.identifier == "showBenchmarkDetail" {
//			let controller = segue.destinationViewController as? BenchmarkWODDetailView
//			if let indexPath = self.tableView.indexPathForSelectedRow
//
//			{
//				controller?.nameText = wod.name![indexPath]
//				controller?.descriptionText = wod.description![indexPath]
//				controller?.exerciseText = wod.exercise![indexPath]
//			}



}
