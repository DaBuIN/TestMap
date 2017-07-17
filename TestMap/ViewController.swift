//
//  ViewController.swift
//  TestMap
//
//  Created by Chuei-Ching Chiou on 11/07/2017.
//  Copyright © 2017 DaBuIN. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

//    let app = UIApplication.shared.delegate as! AppDelegate
    var locMgr: CLLocationManager! // 管理使用者的位置資訊
    
    @IBOutlet weak var mapView: MKMapView! // mapView屬性與方法
    @IBOutlet weak var btnCurrentLoc: UIButton!
    
    @IBAction func mapZoomToCurrentLoc(_ sender: Any) {
//        locMgr.startUpdatingLocation()
        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
    }
    
    @IBAction func mapZoomIn(_ sender: Any) {
        
        var region = MKCoordinateRegion()
        // 還有另一個建構式: MKCoordinateRegion(center: CLLocationCoordinate2D, span: MKCoordinateSpan)
        
        let latDelta = mapView.region.span.latitudeDelta * 0.5
        let lngDelta = mapView.region.span.longitudeDelta * 0.5
        
        region.span.latitudeDelta = latDelta
        region.span.longitudeDelta = lngDelta
        region.center = mapView.region.center
        
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func mapZoomOut(_ sender: Any) {
        var region = MKCoordinateRegion()
        
        let latDelta = mapView.region.span.latitudeDelta * 2
        let lngDelta = mapView.region.span.longitudeDelta * 2
        
        region.span.latitudeDelta = latDelta
        region.span.longitudeDelta = lngDelta
        region.center = mapView.region.center
        
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func nextPage(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segMainToAnn", sender: nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "annVC")
        show(vc!, sender: self)
        
    }
    
    @IBAction func backHere( segue: UIStoryboardSegue ) {
        print("Back here")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) )
        
        self.mapView.setRegion(region, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCurrentLoc?.titleLabel?.textAlignment = NSTextAlignment.center

        if CLLocationManager.locationServicesEnabled() {
            locMgr = CLLocationManager()
            locMgr.delegate = self
            locMgr.desiredAccuracy = kCLLocationAccuracyBest
//            locMgr.requestAlwaysAuthorization()
            locMgr.requestWhenInUseAuthorization()
            locMgr.startUpdatingLocation() // 開始更新位置
            
            // 當使用者移動了10公尺再更新座標 (如此地圖畫面就不會一直彈回所在位置)
            locMgr.distanceFilter = CLLocationDistance(10)
            
//            print("OK")
        }
        
        mapView.delegate = self
    
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // 未使用app即停止定位(背景執行定位也會很耗電)
        locMgr.stopUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segMainToAnn" {
            
            let vc = segue.destination as! annVC
            vc.annPoint = CLLocationCoordinate2D(latitude: 23.136494, longitude: 120.430427)
//            vc.addPointAnnotation(point: vc.annPoint ?? mapView.userLocation.coordinate )
        }
    }

}

