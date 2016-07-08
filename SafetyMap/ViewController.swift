//
//  ViewController.swift
//  SafetyMap
//
//  Created by Daniel Ku on 7/8/16.
//  Copyright © 2016 djku. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator


class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var crimeDataArr: [CrimeData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        mapView.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last! as CLLocation
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(mapView.userLocation.coordinate.latitude, mapView.userLocation.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        let apiURL = "https://data.sfgov.org/resource/9v2m-8wqu.json"
        Alamofire.request(.GET, apiURL).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var i = 0
                    // Store the crime data into the array
                    while (i < json.count){
                        let crimeData = CrimeData(json: json[i])
                        self.crimeDataArr.append(crimeData)
                        i += 1
                    }
                    
                }
            case .Failure(let error):
                print(error)
            }
            var j = 0
            var crimeAroundUser = 0
            while j < self.crimeDataArr.count{
                let userPosition:CLLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
                let crimeLocation:CLLocation = CLLocation(latitude: self.crimeDataArr[j].latitude, longitude: self.crimeDataArr[j].longitude)
                
                let meters:CLLocationDistance = userPosition.distanceFromLocation(crimeLocation)
                if meters <= 50 {
                    crimeAroundUser += 1
                }
                
                j += 1
            }
            if crimeAroundUser > 15{
                //red
                self.mapView.tintColor = UIColor.redColor()
                print(crimeAroundUser)
            }else if crimeAroundUser <= 15 && crimeAroundUser > 5{
                //yellow
                self.mapView.tintColor = UIColor.yellowColor()
                print(crimeAroundUser)
            }else if crimeAroundUser <= 5 && crimeAroundUser > 0{
                //green
                self.mapView.tintColor = UIColor.greenColor()
                print(crimeAroundUser)
            }

        }


    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

