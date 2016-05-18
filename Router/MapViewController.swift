//
//  MapViewController.swift
//  Router
//
//  Created by  Harold LIU on 5/18/16.
//  Copyright © 2016 MandyXue. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocation()
        map.delegate = self
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        map.showsUserLocation = true
        map.userTrackingMode = MKUserTrackingMode.Follow
        cameraSetUp()
        search()
    }
    
    func search () {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "gas"
        request.region = map.region
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) in
            if error != nil {
                print(error)
            }
            else {
                let placeMarks = NSMutableArray()
                for place in (response?.mapItems)! {
                    placeMarks.addObject(place.placemark)
                }
                self.map.showAnnotations(placeMarks.copy() as! [MKAnnotation], animated: true)
            }
        }
    }
    
    func initLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.distanceFilter = 1000
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private func cameraSetUp()
    {
        map.camera.altitude = 1400
        map.camera.pitch = 50
        map.camera.heading = 180
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        let blue = "blue"
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(blue)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: blue)
            anView!.image = UIImage(named:"annotation-me")
            anView!.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        return anView
    }
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        search()
    }

    
}
