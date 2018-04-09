//
//  collectionViewCell.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import UIKit

class collectionViewCell: UICollectionViewCell {
	
	
	enum CellType: Int {
		case large = 0
		case small = 1
	}
	
	var mode: CellType?
	
	var labelCityName = UILabel()
	var labelCityTemerature = UILabel()
	
	lazy var iconImage: UIImageView = {
		let iview = UIImageView()
		iview.image = #imageLiteral(resourceName: "sunny").withRenderingMode(.alwaysOriginal)
		return iview
	}()
	
	
	override var isSelected: Bool {
		didSet {
			self.layer.borderColor = isSelected ? UIColor.black.cgColor : UIColor.clear.cgColor
		}
	}
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		layer.borderColor = UIColor.black.cgColor
	}
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		labelCityName.translatesAutoresizingMaskIntoConstraints = false
		labelCityName.textColor = .white
		labelCityName.textAlignment = .center
		labelCityName.lineBreakMode = .byCharWrapping
		labelCityName.numberOfLines = 2
		labelCityName.font = UIFont.boldSystemFont(ofSize: 20)
		
		labelCityTemerature.sizeToFit()
		labelCityTemerature.textAlignment = .center
		labelCityTemerature.textColor = .black
		
		layer.borderWidth = 1.5
		layer.borderColor = UIColor.clear.cgColor
		contentView.addSubview(labelCityName)
		contentView.addSubview(labelCityTemerature)
		contentView.addSubview(iconImage)
		labelCityName.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: iconImage.topAnchor, right: nil, topConstant: 200, leftConstant: contentView.frame.width/2 - 60, bottomConstant: 20, rightConstant: 0, widthConstant: 120, heightConstant: 20)
		iconImage.anchor(labelCityName.bottomAnchor, left: contentView.leftAnchor, bottom: labelCityTemerature.topAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: contentView.frame.width/2-110, bottomConstant: -150, rightConstant: contentView.frame.width/2-100, widthConstant: 210, heightConstant: 210)
		contentView.bringSubview(toFront: labelCityTemerature)
		
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	
	func configureCellWithType (_ cellType: CellType) {
		
		self.mode = cellType
		
		switch cellType {
		case .large:
			labelCityName.isHidden = false
			iconImage.isHidden = false
			labelCityTemerature.font = UIFont.boldSystemFont(ofSize: 110)
			contentView.backgroundColor = UIColor(red: .random, green: .random, blue: .random, alpha: 0.3)
			labelCityTemerature.anchor(iconImage.bottomAnchor, left: iconImage.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 0, leftConstant: -60, bottomConstant: 0, rightConstant: 0, widthConstant: 210, heightConstant: 210)
			contentView.bringSubview(toFront: iconImage)
			contentView.bringSubview(toFront: labelCityTemerature)
			contentView.bringSubview(toFront: labelCityName)
			
		case .small:
			labelCityName.isHidden = true
			iconImage.isHidden = true
			contentView.backgroundColor = UIColor.randomColor
			labelCityTemerature.isHidden = false
			labelCityTemerature.font = UIFont.boldSystemFont(ofSize: 20)
			contentView.addBlurEffect()
			contentView.addSubview(labelCityTemerature)
			contentView.bringSubview(toFront: labelCityTemerature)
			labelCityTemerature.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 10, leftConstant: 5, bottomConstant: 10, rightConstant: 5, widthConstant: 10, heightConstant: 10)
			
			break
			
		}
	}
	
	
	func updateWeatherIcon(conditionFor: Int) {
		var imageName:String
		switch conditionFor {
		case 200..<300:
			imageName = "thunderstorm"
		case 300..<700:
			imageName = "rainy"
		case 701..<799:
			imageName = "snowy"
		case 800:
			imageName = "sunny"
		case 801..<805:
			imageName = "cloudy"
		default:
			imageName = "sunny"
			break
		}
		self.iconImage.image = UIImage(named: imageName)
	}
	
	
	
	
}
