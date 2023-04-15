//
//  GameControllerProduct.swift
//  GamePadSample
//
//  Created by 藤治仁 on 2023/01/16.
//

import Foundation
import GameController

enum GameControllerProduct {
    case Xbox
    case Switch
    case PS4
    case PS5
    case other
    
    init(controller: GCController) {
        self = .other
        if controller.productCategory.contains("Switch") {
            self = .Switch
        } else if controller.productCategory.hasPrefix(GCProductCategoryXboxOne) {
            self = .Xbox
        } else if controller.productCategory.hasPrefix(GCProductCategoryDualShock4) {
            self = .PS4
        } else if controller.productCategory.hasPrefix(GCProductCategoryDualSense) {
            self = .PS5
        }
    }
}
