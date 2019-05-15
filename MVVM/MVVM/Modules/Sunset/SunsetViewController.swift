//
//  SunsetViewController.swift
//  MVVM
//
//  Created by liubomyr.drevych on 5/10/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import CoreLocation

final class SunsetViewController: UIViewController {

    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var twilligtBegin: UILabel!
    
    var viewModel: SunsetSunriseViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.permissionForLocation()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func fetchData(completion: (() -> Void)? = nil) {
        viewModel.getSunsetSunriseData(vc: self, complitionHandler: { [weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.sunset.text = data.info?.sunsetDate
                    self?.sunrise.text = data.info?.sunriseDate
                    self?.twilligtBegin.text = data.info?.twilightEndDate
                }
                completion?()
            case .failude(_):
                guard let `self` = self else { return }
                self.viewModel.showAlertError(on: self, buttonTitle: Constants.buttonAlertTitle, title: Constants.alertControllerTitle, message: Constants.alertControllerMessage, buttonAction: {})
                completion?()
            }
        })
    }
    
}

