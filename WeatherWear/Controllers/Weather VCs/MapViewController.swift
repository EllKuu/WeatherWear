//
//  MapViewController.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-02-12.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        // Do any additional setup after loading the view.
    }
    

}
