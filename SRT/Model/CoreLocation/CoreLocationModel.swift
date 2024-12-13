//
//  CoreLocationModel.swift
//  SRT
//
//  Created by 박성민 on 9/28/24.
//

import Foundation
import CoreLocation

class CoreLocationModel : NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    override init(){
        super.init()
        locationManager.delegate = self
    }
}
