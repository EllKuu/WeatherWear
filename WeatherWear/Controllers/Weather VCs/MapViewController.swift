//
//  MapViewController.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-02-12.
//

import UIKit
import MapKit
import CoreLocation

// 1. handle permissions

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var savedLocations: [[String:Double]] = []
    let defaults = UserDefaults.standard
    var callBackCoordinates: ((_ latitude: Double, _ longitude: Double)-> Void)?

    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search a location"
        searchController.searchBar.searchBarStyle = .minimal
        return searchController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        navigationItem.searchController = searchController
        
        // tap gesture
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(dropPin))
        gesture.delegate = self
        gesture.minimumPressDuration = 1.5
        gesture.delaysTouchesEnded = true
        mapView.addGestureRecognizer(gesture)
        
        // load any annotations
        getSavedLocations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @objc func dropPin(gesture: UILongPressGestureRecognizer){
        
        let location = gesture.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        let saveLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        // Add annotation:
        let annotation = LocationMarker(title: "Place", coordinate: coordinate, info: "\(coordinate)")
        mapView.addAnnotation(annotation)
        
        
        if gesture.state == .ended{
            saveLocationsToUserDefaults(location: saveLocation)
        }
        
        
    }
    
    func saveLocationsToUserDefaults(location: CLLocation){
        let latitude:Double = location.coordinate.latitude
        let longitude:Double = location.coordinate.longitude
        
        savedLocations.append(["Latitude": latitude, "Longitude": longitude])
        defaults.setValue(savedLocations, forKey: "savedLocations")
    }
    
    func getSavedLocations(){
        savedLocations = defaults.object(forKey: "savedLocations") as? [[String:Double]] ?? [[String:Double]]()
        if savedLocations.isEmpty {
            print("no pins")
        }else{
           
            for i in savedLocations{
                print(i)
                let lat = i["Latitude"]!
                let long = i["Longitude"]!
                let saveLocation = CLLocation(latitude: lat, longitude: long)

                // Add annotation:
                let annotation = LocationMarker(title: "Place", coordinate: saveLocation.coordinate, info: "\(saveLocation.coordinate)")
                mapView.addAnnotation(annotation)
            }

        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            render(location)
        }
        
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("access denied")
    }
    
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = LocationMarker(title: "Toronto", coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), info: "Home to the Blue Jays")
        mapView.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is LocationMarker else { return nil }
        
        let identifier = "LocationMarker"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
            let dlt = UIButton(type: .close)
            annotationView?.leftCalloutAccessoryView = dlt
        }else{
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let locationMarker = view.annotation as? LocationMarker else { return }
        
        if control == view.leftCalloutAccessoryView{
            print(mapView.annotations.count, " THIS IS COUNT")
            for i in mapView.annotations{
                if i.coordinate.latitude == locationMarker.coordinate.latitude && i.coordinate.longitude == locationMarker.coordinate.longitude  {
                    
                    mapView.removeAnnotation(i)
                    savedLocations.removeAll(where: {arr in
                        i.coordinate.latitude == arr["Latitude"] && i.coordinate.longitude == arr["Longitude"]
                    })
                    defaults.setValue(savedLocations, forKey: "savedLocations")
                }
            }
        }
        
        if control == view.rightCalloutAccessoryView{
            let placeName = locationMarker.title
            let placeInfo = locationMarker.info

            let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Get 7 Day Forecast", style: .default, handler: { [weak self] _ in
                
                self?.callBackCoordinates?(locationMarker.coordinate.latitude, locationMarker.coordinate.longitude)

                self?.navigationController?.popToRootViewController(animated: true)
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .default))
            present(ac, animated: true)
        }
    }
    
    
}// end of class
