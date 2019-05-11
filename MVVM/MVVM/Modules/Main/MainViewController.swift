//
//  ViewController.swift
//  MVVM
//
//  Created by liubomyr.drevych on 5/10/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: IBAction
    @IBAction func didTapOnShowDataViewController(_ sender: Any) {
        viewModel.showSunsetViewController(from: self, with: true)
    }
    
}

