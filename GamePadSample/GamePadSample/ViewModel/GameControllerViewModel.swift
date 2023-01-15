//
//  GameControllerViewModel.swift
//  GamePadSample
//
//  Created by 藤治仁 on 2023/01/15.
//

import SwiftUI

class GameControllerViewModel: NSObject, ObservableObject {
    private let gameControllerModel = GameControllerModel()
    
    func onAppear() {
        gameControllerModel.delegate = self
    }
    
    func onDisappear() {
        gameControllerModel.delegate = nil
    }
}

extension GameControllerViewModel: GameControllerDelegate {
    func operationGamePad(_ operation: GameControllerOperation) {
        print(">>Debug \(#fileID) \(#line) : \(operation)")
    }
}
