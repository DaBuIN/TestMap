//
//  testVC.swift
//  TestMap
//
//  Created by Chuei-Ching Chiou on 12/07/2017.
//  Copyright © 2017 DaBuIN. All rights reserved.
//

import UIKit
//import CoreLocation
import MapKit

class annVC: UIViewController, MKMapViewDelegate {

    var annPoint:CLLocationCoordinate2D?
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var mapShowAnn: MKMapView!

    public func addPointAnnotation( point: CLLocationCoordinate2D ) {
        
        // create pin
        let pin:MKPointAnnotation = MKPointAnnotation()
        
        pin.coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
        pin.title = "走馬瀨農場"
        pin.subtitle = "lat:\(pin.coordinate.latitude), lng:\(pin.coordinate.longitude)"
        
        // show pin
//        print(pin.title!)
//        print(pin.description)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        let region = MKCoordinateRegion(center: pin.coordinate, span: span)
        
        
        self.mapShowAnn.setRegion(region, animated: true)
        self.mapShowAnn.addAnnotation(pin)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(annPoint)
        if let point = annPoint {
            print("lat:\(point.latitude), lng:\(point.longitude)")
        
            self.addPointAnnotation(point: point)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
