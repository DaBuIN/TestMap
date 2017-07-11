//
//  ViewController.swift
//  TestMap
//
//  Created by Chuei-Ching Chiou on 11/07/2017.
//  Copyright © 2017 DaBuIN. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

//    let app = UIApplication.shared.delegate as! AppDelegate
    var locMgr: CLLocationManager!
    
    @IBOutlet weak var myMap: MKMapView!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) )
        
        self.myMap.setRegion(region, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {
            locMgr = CLLocationManager()
            locMgr.delegate = self
            locMgr.desiredAccuracy = kCLLocationAccuracyBest
//            locMgr.requestAlwaysAuthorization()
            locMgr.requestWhenInUseAuthorization()
            locMgr.startUpdatingLocation() // 開始更新位置
            
            // 移動10公尺再更新座標 (如此就不會一直彈回所在位置)
            locMgr.distanceFilter = CLLocationDistance(10)
            
//            print("OK")
        }
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // 未使用app即停止定位(背景執行定位也會很耗電)
        locMgr.stopUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

