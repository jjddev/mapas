//
//  ViewController.swift
//  coreloc
//
//  Created by PUCPR on 22/03/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    let lm = CLLocationManager()
    static let geocoder  = CLGeocoder()
    let localInicial = CLLocation(latitude: -28.4579, longitude: -52.822)
    
    @IBOutlet weak var mapa: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
        
        mapa.mapType = .standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.0275, longitudeDelta: 0.0275)
        let regiao = MKCoordinateRegion(center: localInicial.coordinate, span: span)
        
        mapa.setRegion(regiao, animated: true)
        
        let anotacao = MKPointAnnotation()
        anotacao.coordinate = localInicial.coordinate
        anotacao.title = ">>AQUI<<"
        anotacao.subtitle = "SIM"
        
        mapa.addAnnotation(anotacao)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let local = locations[locations.count - 1]
        
        if local.horizontalAccuracy > 0 {
            lm.stopUpdatingLocation()
            print("\(local.coordinate.latitude) | \(local.coordinate.longitude)")
            
            ViewController.geocoder.reverseGeocodeLocation(local) { (placemark, _ ) in
                if let marca = placemark?.first {
                    print(marca.name)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("GPS fora: \(error)")
    }


}

