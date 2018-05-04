//
//  getLocation.swift
//  HometownApp
//
//  Created by Apple on 11/2/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var latt:String = ""
var longg:String = ""
var val1:Double = 0
var val2:Double = 0

class GetLocation: ViewController, CLLocationManagerDelegate, MKMapViewDelegate,NSMachPortDelegate {
    
    var lat1:String = ""
    var lat2:String = ""
    var qw3:String = ""
    var qw4:String = ""
    var locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var mapView1: MKMapView!
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: self.mapView1)
        let locCoord = self.mapView1.convert(location, toCoordinateFrom: self.mapView1)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locCoord
        annotation.title = "Your Location"
        self.mapView1.addAnnotation(annotation)
        latt = String(locCoord.latitude)
        longg = String(locCoord.longitude)
    }
    
    override func viewDidLoad() {
       
        
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        val1 = lat1 != "" ? Double(lat1)! : 0.0
        val2 = lat2 != "" ? Double(lat2)! : 0.0
        
        if val1 == 0 && val2 == 0
        {
            
            let searchRequest = MKLocalSearchRequest()
            
            searchRequest.naturalLanguageQuery = qw3
            
            let activeSearch = MKLocalSearch(request:searchRequest)
            activeSearch.start{ (response, error) in
                //UIApplication.shared.endIgnoringInteractionEvents()
                if response != nil
                {
                    
                    let latitude = response?.boundingRegion.center.latitude
                    let longitude = response?.boundingRegion.center.longitude
                    
                    let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                    // print (coordinate)
                    let span = MKCoordinateSpanMake(1, 1)
                    let region = MKCoordinateRegionMake(coordinate, span)
                    self.mapView1.setRegion(region, animated: true)
                }
                
            }
        }
        else{
            let annotations = self.mapView1.annotations
            if annotations.count > 0 {
                self.mapView1.removeAnnotations(annotations)
            }
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1,0.1)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(val1,val2)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.mapView1.setRegion(region,animated:true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Your Location"
            self.mapView1.addAnnotation(annotation)
            latt = String(val1)
            longg = String(val2)
            
        }
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
