//
//  collectionViewCell.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/27/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import UIKit
import Lottie

class collectionViewCell: UICollectionViewCell {
	
	
	enum CellType: Int {
		case large = 0
		case small = 1
	}
	
	var mode: CellType?
	
	var labelCityName = UILabel()
    var labelCity = UILabel()
	var labelCityTemerature = UILabel()
	var iconViewAnima = LOTAnimationView()
	
	lazy var iconImage: UIImageView = {
		let iview = UIImageView()
		iview.image = #imageLiteral(resourceName: "sunny").withRenderingMode(.alwaysOriginal)
		return iview
	}()

	
	override var isSelected: Bool {
		didSet {
			self.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.clear.cgColor
		}
	}
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
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
        
        labelCity.translatesAutoresizingMaskIntoConstraints = false
        labelCity.textColor = .white
        labelCity.textAlignment = .center

		labelCityTemerature.sizeToFit()
		labelCityTemerature.textAlignment = .center
		labelCityTemerature.textColor = .black
		
		layer.borderWidth = 5
		layer.borderColor = UIColor.clear.cgColor

		//change for that bg fog image
//		let isPad = UIDevice().userInterfaceIdiom  == .pad
//		backgroundView = isPad ? UIImageView(image: UIImage(named: "")) : UIImageView(image: UIImage(named: ""))

	}
	
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	
	func configureCellWithType (_ cellType: CellType) {
		
		self.mode = cellType
		
		switch cellType {
		case .large:
			labelCityName.isHidden = false
            labelCity.isHidden = false
			iconImage.isHidden = false

			contentView.addSubview(labelCityName)
			contentView.addSubview(labelCityTemerature)
            contentView.addSubview(labelCity)
			contentView.addSubview(iconImage)
			contentView.addSubview(iconViewAnima)
			contentView.bringSubviewToFront(iconViewAnima)
			contentView.bringSubviewToFront(labelCityTemerature)
            contentView.bringSubviewToFront(labelCity)

			iconViewAnima.layoutIfNeeded()

			contentView.backgroundColor = UIColor(red: .random, green: .random, blue: .random, alpha: 0.3)
            
			switch UIDevice().userInterfaceIdiom {
			case UIUserInterfaceIdiom.pad:
				labelCityTemerature.font = UIFont.boldSystemFont(ofSize: 135)
				labelCityName.font = UIFont.boldSystemFont(ofSize: 28)
                
				labelCityName.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: iconImage.topAnchor, right: nil, topConstant: 310, leftConstant: contentView.frame.width/2 - 60, bottomConstant: 90, rightConstant: 0, widthConstant: 120, heightConstant: 35)
				iconViewAnima.anchor(labelCityName.bottomAnchor, left: contentView.leftAnchor, bottom: iconImage.bottomAnchor, right: contentView.rightAnchor, topConstant: 50, leftConstant: contentView.frame.width/2-270, bottomConstant: 0, rightConstant: contentView.frame.width/2-270, widthConstant: 400, heightConstant: 400)
				iconImage.anchor(labelCityName.bottomAnchor, left: contentView.leftAnchor, bottom: labelCityTemerature.topAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: contentView.frame.width/2-180, bottomConstant: -100, rightConstant: contentView.frame.width/2-180, widthConstant: 350, heightConstant: 350)
				labelCityTemerature.anchor(iconImage.bottomAnchor, left: iconImage.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 0, leftConstant: -280, bottomConstant: 0, rightConstant: 0, widthConstant: 210, heightConstant: 210)




			default:
				labelCityTemerature.font = UIFont.boldSystemFont(ofSize: 100)
				labelCityName.font = UIFont.boldSystemFont(ofSize: 20)
                labelCity.font = UIFont.systemFont(ofSize: 14, weight: .light
                )
                labelCity.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: labelCityName.topAnchor, right: nil, topConstant: 180, leftConstant: contentView.frame.width/2 - 60, bottomConstant: 10, rightConstant: 0, widthConstant: 120, heightConstant: 20)
                labelCityName.anchor(labelCity.bottomAnchor, left: contentView.leftAnchor, bottom: iconImage.topAnchor, right: nil, topConstant: 0, leftConstant: contentView.frame.width/2 - 80, bottomConstant: 40, rightConstant: 0, widthConstant: 160, heightConstant: 60)
				iconViewAnima.anchor(labelCityName.bottomAnchor, left: contentView.leftAnchor, bottom: iconImage.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: contentView.frame.width/2-110, bottomConstant: 0, rightConstant: contentView.frame.width/2-110, widthConstant: 300, heightConstant: 300)
				labelCityTemerature.anchor(iconImage.bottomAnchor, left: iconImage.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 0, leftConstant: -60, bottomConstant: 0, rightConstant: 0, widthConstant: 210, heightConstant: 210)
				iconImage.anchor(labelCityName.bottomAnchor, left: contentView.leftAnchor, bottom: labelCityTemerature.topAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: contentView.frame.width/2-110, bottomConstant: -110, rightConstant: contentView.frame.width/2-100, widthConstant: 210, heightConstant: 210)}


		case .small:
			layer.cornerRadius = 5
			layer.masksToBounds = true
			labelCityName.isHidden = true
            labelCity.isHidden = true
			iconImage.isHidden = true
			iconViewAnima.isHidden = true
			contentView.backgroundColor = UIColor.randomColor
			labelCityTemerature.isHidden = false
			labelCityTemerature.font = UIFont.boldSystemFont(ofSize: 20)
			contentView.addBlurEffect()
			contentView.addSubview(labelCityTemerature)
			contentView.bringSubviewToFront(labelCityTemerature)
			labelCityTemerature.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 10, leftConstant: 5, bottomConstant: 10, rightConstant: 5, widthConstant: 10, heightConstant: 10)
			
			break
			
		}
	}
//TODO:
	 func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
		print("did Rotate device")
		coordinator.animate(alongsideTransition: { (_) in

			// frame center here
		}, completion: nil)

	}
	
	
	func updateWeatherIcon(conditionFor: Int) {
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
		self.iconImage.image = UIImage(named: imageName)
	}

	func updateAnimationIcon(conditionFor: Int) {
		var animaName:String
		switch conditionFor {
		case 200..<300:
			animaName = "loading_ribbon"
		case 300..<700:
			animaName = "color_line"
		case 701..<799:
			animaName = "techno_penguin"
		case 800:
			animaName = "yelloader"
		case 801..<805:
			animaName = "blue_waves_"
		default:
			animaName = "yelloader"

		}
		self.iconViewAnima.setAnimation(named: animaName)
		self.iconViewAnima.play()
		self.iconViewAnima.loopAnimation = true

	}
	
	
	
	
}
