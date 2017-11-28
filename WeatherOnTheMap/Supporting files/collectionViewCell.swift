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
    
    var labelCityName = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    var labelCityTemerature = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = isSelected ? UIColor.red.cgColor : UIColor.clear.cgColor
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelCityName.translatesAutoresizingMaskIntoConstraints = false
        labelCityName.center = CGPoint(x: frame.width/2.0, y: frame.height/2.0)
        labelCityTemerature.center = CGPoint(x: frame.width/2.0, y: frame.height/2.0)
        labelCityTemerature.font = UIFont.systemFont(ofSize: 25)
        labelCityName.textAlignment = .center
        labelCityName.textColor = UIColor.white
        labelCityName.font = UIFont.boldSystemFont(ofSize: 28)
        
        
        contentView.addSubview(labelCityName)
        contentView.addSubview(labelCityTemerature)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureCellWithType (_ cellType: CellType) {
        
        self.mode = cellType
        
        switch cellType {
            
        case .large:
            labelCityName.isHidden = false
           // labelCityName.text = "test"
        case .small:
            labelCityName.isHidden = true
            self.layer.borderWidth = 1.5
            self.layer.borderColor = UIColor.clear.cgColor
        default:
            break
            
        }
    }
}
