//
//  LocationMarket.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-02-12.
//

import UIKit
import MapKit


class LocationMarker: NSObject, MKAnnotation {

    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String){
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
