//
//  MainViewModel.swift
//  MVVM
//
//  Created by liubomyr.drevych on 5/10/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import UIKit

final class MainViewModel {
    
    func showSunsetViewController(from current:UIViewController, with animation: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigationRouter?.showSunsetSunriseViewController(current: current, with: animation)
    }
    
    
}
