//
//  SunsetSunriseViewModel.swift
//  MVVM
//
//  Created by liubomyr.drevych on 5/10/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import CoreLocation

final class SunsetSunriseViewModel {
    
    private var networkManager = NetworkManager()
    private var locationManager = LocationManager()
    
    init(network: NetworkManager, location: LocationManager) {
        self.locationManager = location
        self.networkManager = network
    }
    
    func getSunsetSunriseData(latitude: CLLocationDegrees, longitute: CLLocationDegrees,complitionHandler: @escaping (Result) -> Void, delay: TimeInterval?) {
        networkManager.getSunsetSunriseData(latitude: latitude, longitute: longitute, complitionHandler: complitionHandler, delay: delay)
    }
    
}
