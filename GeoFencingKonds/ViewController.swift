//
//  ViewController.swift
//  Geofencing For Noobs
//
//  Created by Hilton Pintor Bezerra Leite on 25/04/2018.
//  Copyright © 2018 Hilton Pintor Bezerra Leite. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    var locationManager : CLLocationManager?
    @objc func methodOfReceivedNotification(notification: Notification){
        if let message = notification.userInfo!["message"] as? String
        {
            self.distanceLabel.text = message
        }
        else
        {
            self.distanceLabel.text = "Something is wrong!"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.locationManager = appDelegate.locationManager
        self.locationManager?.requestAlwaysAuthorization()
        
        
         //Mumbai
        let geofenceRegionCenter = CLLocationCoordinate2D(
            latitude: 19.01761470,
            longitude: 72.85616440
        )
        
        //My Location
//        let geofenceRegionCenter = CLLocationCoordinate2D(
//            latitude: 19.10801841,
//            longitude: 73.01966504
//        )
        
        
        /* Create a region centered on desired location,
         choose a radius for the region (in meters)
         choose a unique identifier for that region */
        let geofenceRegion = CLCircularRegion(
            center: geofenceRegionCenter,
            radius: 0.01,
            identifier: "UniqueIdentifier"
        )
        
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        self.locationManager?.startMonitoring(for: geofenceRegion)
    }


}

