//
//  MapViewController.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 9/26/17.
//  Copyright © 2017 Marina Huber. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longitude: CLLocationDegrees = 8.03
        let latitude: CLLocationDegrees =  27.17
        let lanDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: lonDelta)
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)
        let uilongpress = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.longpress(gestureRecognizer:)))
        uilongpress.minimumPressDuration = 2
        map.addGestureRecognizer(uilongpress)
    }

    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func longpress(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: self.map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "New weather place "
        map.addAnnotation(annotation)
    }


}
