//
//  GameControllerViewModel.swift
//  GamePadSample
//
//  Created by 藤治仁 on 2023/01/15.
//

import SwiftUI

class GameControllerViewModel: NSObject, ObservableObject {
    private let gameControllerModel = GameControllerModel()
    @Published var controllerProduct: GameControllerProduct = .other
    @Published var buttonL1 = false
    @Published var buttonL2 = false
    @Published var buttonR1 = false
    @Published var buttonR2 = false
    @Published var buttonUp = false
    @Published var buttonCursorOffsetX = 0.0
    @Published var buttonCursorOffsetY = 0.0
    @Published var buttonDown = false
    @Published var buttonLeft = false
    @Published var buttonRight = false
    @Published var buttonOption = false
    @Published var buttonMenu = false
    @Published var buttonA = false
    @Published var buttonB = false
    @Published var buttonX = false
    @Published var buttonY = false
    @Published var buttonStickR = false
    @Published var buttonStickL = false
    @Published var buttonStickROffsetX = 0.0
    @Published var buttonStickROffsetY = 0.0
    @Published var buttonStickLOffsetX = 0.0
    @Published var buttonStickLOffsetY = 0.0

    func onAppear() {
        gameControllerModel.delegate = self
    }
    
    func onDisappear() {
        gameControllerModel.delegate = nil
    }
}

extension GameControllerViewModel: GameControllerDelegate {
    func operationGamePad(_ operation: GameControllerOperation, product: GameControllerProduct) {
        switch operation {
        case .connected:
            controllerProduct = product
        case .upPress:
            buttonUp = true
        case .upRelease:
            buttonUp = false
        case .downPress:
            buttonDown = true
        case .downRelease:
            buttonDown = false
        case .leftPress:
            buttonLeft = true
        case .leftRelease:
            buttonLeft = false
        case .rightPress:
            buttonRight = true
        case .rightRelease:
            buttonRight = false
        case .xAxis(let value):
            buttonCursorOffsetX = Double(value)
        case .yAxis(let value):
            buttonCursorOffsetY = Double(value)
        case .buttonAPress:
            buttonA = true
        case .buttonARelease:
            buttonA = false
        case .buttonBPress:
            buttonB = true
        case .buttonBRelease:
            buttonB = false
        case .buttonXPress:
            buttonX = true
        case .buttonXRelease:
            buttonX = false
        case .buttonYPress:
            buttonY = true
        case .buttonYRelease:
            buttonY = false
        case .buttonMenuPress:
            buttonMenu = true
        case .buttonMenuRelease:
            buttonMenu = false
        case .buttonOptionsPress:
            buttonOption = true
        case .buttonOptionsRelease:
            buttonOption = false
        case .buttonHomePress:
            print(">>Debug \(#fileID) \(#line)  ")
        case .buttonHomeRelease:
            print(">>Debug \(#fileID) \(#line)  ")
        case .leftXAxis(let value):
            buttonStickLOffsetX = Double(value)
        case .leftYAxis(let value):
            buttonStickLOffsetY = Double(value)
        case .leftAxisPress:
            buttonStickL = true
        case .leftAxisRelease:
            buttonStickL = false
        case .rightXAxis(let value):
            buttonStickROffsetX = Double(value)
        case .rightYAxis(let value):
            buttonStickROffsetY = Double(value)
        case .rightAxisPress:
            buttonStickR = true
        case .rightAxisRelease:
            buttonStickR = false
        case .buttonLeftShoulderPress:
            buttonL1 = true
        case .buttonLeftShoulderRelease:
            buttonL1 = false
        case .buttonRightShoulderPress:
            buttonR1 = true
        case .buttonRightShoulderRelease:
            buttonR1 = false
        case .buttonLeftTriggerPress:
            buttonL2 = true
        case .buttonLeftTriggerRelease:
            buttonL2 = false
        case .buttonRightTriggerPress:
            buttonR2 = true
        case .buttonRightTriggerRelease:
            buttonR2 = false
        }
    }
}
