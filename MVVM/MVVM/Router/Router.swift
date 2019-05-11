//
//  Router.swift
//  MVVM
//
//  Created by liubomyr.drevych on 5/10/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import UIKit

enum TypeTransition {
    case push
    case pop
    case popToRoot
    case present
}

final class NavigationRouter {
    
    var navigationController = UINavigationController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showMainViewController() {
        let mainViewController = MainViewController.instantiateFromStoryboardId(.Main)
        mainViewController.viewModel = MainViewModel()
        navigationController.viewControllers = [mainViewController]
    }
    
    func showSunsetSunriseViewController(current: UIViewController, with animation: Bool) {
        let sunsetSunriseViewController = SunsetViewController.instantiateFromStoryboardId(.Sunset)
        let networkManager = NetworkManager()
        let locationManager = LocationManager()
        sunsetSunriseViewController.viewModel = SunsetSunriseViewModel(network: networkManager, location: locationManager)
        navigate(from: current, to: sunsetSunriseViewController, with: animation, with: .push)
    }
    
    private func navigate(from: UIViewController, to: UIViewController, with animation: Bool, with transition: TypeTransition, handler: (()->())? = nil) {
        switch transition {
        case .push:
            from.navigationController?.pushViewController(to, animated: animation)
        case .pop:
            from.navigationController?.popViewController(animated: animation)
        case .popToRoot:
            from.navigationController?.popToRootViewController(animated: animation)
        case .present:
            from.navigationController?.present(to, animated: animation, completion: handler)
        }
    }
    
    public func dismiss(current: UIViewController,with animation: Bool, handler: (()->())? = nil) {
        current.navigationController?.dismiss(animated: animation, completion: handler)
    }
    
}
