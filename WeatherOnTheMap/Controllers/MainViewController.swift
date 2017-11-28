//
//  MainViewController.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/26/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet weak var largeCollectionView: UICollectionView!
    @IBOutlet weak var smallCollectionView: UICollectionView!
    
    @IBOutlet weak var smallCollectionViewWidthConstraint: NSLayoutConstraint!
    var cityNames: Array<Any>? = nil

    private var backgrounds: [Background] = [Background(city: "", backgroundColor: UIColor.yellow.withAlphaComponent(0.3)),Background(city: "", backgroundColor: UIColor.gray.withAlphaComponent(0.3)), Background(city: "", backgroundColor: UIColor.magenta.withAlphaComponent(0.3)),Background(city: "", backgroundColor: UIColor.blue.withAlphaComponent(0.3)), Background(city: "", backgroundColor: UIColor.red.withAlphaComponent(0.3))]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        WeatherService.shared.getCurrentWeather { error, cities in
            
            self.backgrounds = cities.flatMap {
                Background(city: $0.name!, backgroundColor: UIColor.orange)
            }

        }
        largeCollectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "ID")
        smallCollectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "IDsmall")
    }
    
    
    
    public func setNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        Do this after loading the Data
        //        #4 is selected
        
        let indexPath = IndexPath(item: 3, section: 0)
       // print(#file, #line, #function, (indexPath), "my city item")
        
        largeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        smallCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        
        smallCollectionViewWidthConstraint.constant = min(view.frame.width - 20, smallCollectionView.contentSize.width)
    }
    
    func refresh(_ sender:AnyObject) {
        DispatchQueue.main.async(execute: {
            self.largeCollectionView.reloadData()
            
        })
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
         cell.backgroundColor = cellData.backgroundColor
         cell.labelCityName.text = cellData.city
         cell.configureCellWithType(.large)
                return cell
       case smallCollectionView!:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IDsmall", for: indexPath) as! collectionViewCell
        cell.backgroundColor = backgrounds[indexPath.row].backgroundColor
         cell.configureCellWithType(.small)
                return cell
        default:
                return UICollectionViewCell()
            }
        
    }
    
    
    //TODO: delete from NSUserDefaults
    func didTapDeleteCellBtn(delete: UIButton) {
        
    }
    
    
}

        
        
        
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return collectionView != largeCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if smallCollectionView == collectionView {
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
            let indexPath = IndexPath(item: index, section: 0)
            
            smallCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}
