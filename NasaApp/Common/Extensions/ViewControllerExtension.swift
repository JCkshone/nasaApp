//
//  ViewControllerExtension.swift
//  NasaApp
//
//  Created by Juan Camilo on 14/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setupBg() {
   
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [ApplicationColor.blue.cgColor, ApplicationColor.purple.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
