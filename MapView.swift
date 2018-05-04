//
//  MapView.swift
//  HometownApp
//
//  Created by Apple on 11/1/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import MapKit

class MapView: ViewController {
    
    @IBOutlet weak var viewMap: MKMapView!
    override func viewDidLoad() {
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(10,10)
        
        if latlat.count == 0{
            
            print("No Annotations")
        }
        else{
            for i in 0...latlat.count-1{
                
                if latlat[i]==0 && longlong[i]==0 {
                    
                    let searchRequest = MKLocalSearchRequest()
                    
                    searchRequest.naturalLanguageQuery = namename[i]
                    
                    let activeSearch = MKLocalSearch(request:searchRequest)
                    activeSearch.start{ (response, error) in
                        //UIApplication.shared.endIgnoringInteractionEvents()
                        if response != nil
                     
                        {
                            
                            let latitude = response?.boundingRegion.center.latitude
                            let longitude = response?.boundingRegion.center.longitude
                            let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                            // print (coordinate)
                            let span = MKCoordinateSpanMake(10, 10)
                            let region = MKCoordinateRegionMake(coordinate, span)
                            self.viewMap.setRegion(region, animated: true)
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = coordinate
                            annotation.title = nikki[i]
                            self.viewMap.addAnnotation(annotation)
                        }
                        
                    }
                    
                }
                    
                    
                else {
                    let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latlat[i], longlong[i])
                    let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                    viewMap.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = nikki[i]
                    viewMap.addAnnotation(annotation)
                }
                // Do any additional setup after loading the view.
            }
        }
    }
    override func didReceiveMemoryWarning() {
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
