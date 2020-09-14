//
//  MainCoordinator.swift
//  NasaApp
//
//  Created by Juan Camilo on 13/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func splash() {
        let vc = SplashViewController()
        let apodViewModel = ApodViewModel()
        vc.coordinator = self
        vc.apodViewModel = apodViewModel
        navigationController.pushViewController(vc, animated: false)
    }
}
