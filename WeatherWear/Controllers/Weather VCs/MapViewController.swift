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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        
        // tap gesture
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(dropPin))
        gesture.delegate = self
        mapView.addGestureRecognizer(gesture)
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
        
        // Add annotation:
        let annotation = LocationMarker(title: "Place", coordinate: coordinate, info: "\(coordinate)")
        //annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        print(annotation.coordinate)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
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
            DispatchQueue.main.async {
                mapView.removeAnnotation(locationMarker)
                print("remove")
            }
            
        }
        
        if control == view.rightCalloutAccessoryView{
            let placeName = locationMarker.title
            let placeInfo = locationMarker.info
            
            let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
       
       
    }
    
    
}
