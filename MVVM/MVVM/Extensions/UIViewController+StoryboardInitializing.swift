//
//  UIViewController+StoryboardInitializing.swift
//  MVVM
//
//  Created by liubomyr.drevych on 5/10/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit

enum StoryboardId: String {
    case Main
    case Weather
}

protocol StoryboardInitializing {}

extension UIViewController: StoryboardInitializing {}

extension UIViewController {
    
    static func className() -> String {
        return String(describing: self)
    }
    
    static func instantiateInitial(_ storyboardId: StoryboardId) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardId.rawValue, bundle: nil) as UIStoryboard?
        assert(storyboard != nil, "Storyboard name is incorrect")
        let vc = storyboard?.instantiateInitialViewController()
        assert(vc != nil, "No initialViewcontroller in storyboard")
        return vc!
    }
    
}

extension StoryboardInitializing where Self: UIViewController {
    
    static func instantiateFromStoryboardId(_ storyboardId: StoryboardId) -> Self {
        let vcIdentifier = self.className()
        let storyboard = UIStoryboard(name: storyboardId.rawValue, bundle: nil) as UIStoryboard?
        assert(storyboard != nil, "Storyboard name is incorrect")
        let vc = storyboard?.instantiateViewController(withIdentifier: vcIdentifier)
        assert(vc != nil, "ViewController id name is incorrect")
        return vc as! Self
    }
    
}

