//
//  SunsetSunriseViewModel.swift
//  MVVM
//
//  Created by liubomyr.drevych on 5/10/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

final class SunsetSunriseViewModel {
    
    private var networkManager = NetworkManager()
    private var locationManager = LocationManager()
    
    init(network: NetworkManager, location: LocationManager) {
        self.locationManager = location
        self.networkManager = network
    }
    
    func getSunsetSunriseData(vc:UIViewController,complitionHandler: @escaping (Result) -> Void, delay: TimeInterval) {
        locationManager.getCurrentLocation { [weak self] (result) in
            switch result {
            case .success(let lattitude, let longitute):
                self?.networkManager.getSunsetSunriseData(latitude: lattitude, longitute: longitute, complitionHandler: complitionHandler, delay: delay)
            case .faild( _):
                self?.showAlertError(on: vc, buttonTitle: Constants.buttonAlertTitle, title: Constants.alertControllerTitle, message: Constants.alertControllerMessage, buttonAction: {})
            }
        }
    }
    
     func showAlertError(on viewController: UIViewController,
                               buttonTitle: String,
                               title: String, message: String,
                               buttonAction: @escaping () -> Void) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: buttonTitle, style: .default) { action in
            buttonAction()
        }
        alertViewController.addAction(alertButton)
        viewController.present(alertViewController,animated: true, completion: nil)
    }
}
