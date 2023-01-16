//
//  GameControllerModel.swift
//  GamePadSample
//
//  Created by 藤治仁 on 2023/01/15.
//

import Foundation
import GameController

protocol GameControllerDelegate {
    func operationGamePad(_ operation: GameControllerOperation, product: GameControllerProduct)
}

class GameControllerModel: NSObject {
    var delegate: GameControllerDelegate?
    
    /// ゲームコントローラーが接続されているか？
    var isConnected: Bool {
        return GCController.controllers().count > 0
    }
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleControllerDidConnect),
                                               name: .GCControllerDidConnect,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleControllerDidDisconnect),
                                               name: .GCControllerDidDisconnect,
                                               object: nil)
        
        if let controller = GCController.controllers().first {
            // 既に接続されている場合には検出できるようにする
            setupGameController(controller: controller)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .GCControllerDidConnect, object: nil)
        NotificationCenter.default.removeObserver(self, name: .GCControllerDidDisconnect, object: nil)
    }
    
    @objc private func handleControllerDidConnect(notification: Notification) {
        print(">>Debug \(#fileID) \(#function) \(#line)  ")
        guard let controller = notification.object as? GCController else {
            return
        }
        setupGameController(controller: controller)
    }
    
    @objc private func handleControllerDidDisconnect(notification: Notification) {
        print(">>Debug \(#fileID) \(#function) \(#line)  ")
        guard let controller = notification.object as? GCController else {
            return
        }
        guard let _ = controller.extendedGamepad else {
            return
        }
        let product = gameControllerProduct(controller: controller)
        operationGamePad(.disconnected, product: product)
    }
    
    private func setupGameController(controller: GCController) {
        let product = gameControllerProduct(controller: controller)
        guard let gamepad = controller.extendedGamepad else {
            return
        }
        print(">>Debug \(#fileID) \(#function) \(#line) | \(controller.productCategory) | \(controller.vendorName ?? "nil")")
        
        operationGamePad(.connected, product: product)
        
        gamepad.dpad.up.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .upPress : .upRelease, product: product)
        }
        gamepad.dpad.down.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .downPress : .downRelease, product: product)
        }
        gamepad.dpad.left.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .leftPress : .leftRelease, product: product)
        }
        gamepad.dpad.right.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .rightPress : .rightRelease, product: product)
        }
        gamepad.dpad.xAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.xAxis(value), product: product)
        }
        gamepad.dpad.yAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.yAxis(value), product: product)
        }
        gamepad.buttonA.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonAPress : .buttonARelease, product: product)
        }
        gamepad.buttonB.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonBPress : .buttonBRelease, product: product)
        }
        gamepad.buttonX.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonXPress : .buttonXRelease, product: product)
        }
        gamepad.buttonY.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonYPress : .buttonYRelease, product: product)
        }
        gamepad.buttonMenu.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonMenuPress : .buttonMenuRelease, product: product)
        }
        gamepad.buttonOptions?.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonOptionsPress : .buttonOptionsRelease, product: product)
        }
        gamepad.buttonHome?.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonHomePress : .buttonHomeRelease, product: product)
        }
        gamepad.leftThumbstick.xAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.leftXAxis(value), product: product)
        }
        gamepad.leftThumbstick.yAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.leftYAxis(value), product: product)
        }
        gamepad.rightThumbstick.xAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.rightXAxis(value), product: product)
        }
        gamepad.rightThumbstick.yAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.rightYAxis(value), product: product)
        }
        gamepad.leftShoulder.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonLeftShoulderPress : .buttonLeftShoulderRelease, product: product)
        }
        gamepad.rightShoulder.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonRightShoulderPress : .buttonRightShoulderRelease, product: product)
        }
        gamepad.leftTrigger.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonLeftTriggerPress : .buttonLeftTriggerRelease, product: product)
        }
        gamepad.rightTrigger.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonRightTriggerPress : .buttonRightTriggerRelease, product: product)
        }
        gamepad.leftThumbstickButton?.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .leftAxisPress : .leftAxisRelease, product: product)
        }
        gamepad.rightThumbstickButton?.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .rightAxisPress : .rightAxisRelease, product: product)
        }
    }
    
    private func operationGamePad(_ operation: GameControllerOperation, product: GameControllerProduct) {
        print(">>Debug \(#fileID) \(#function) \(#line) : \(operation) \(product)")
        self.delegate?.operationGamePad(operation, product: product)
    }
    
    private func gameControllerProduct(controller: GCController) -> GameControllerProduct {
        print(">>Debug \(#fileID) \(#function) \(#line) | \(controller.productCategory) | \(controller.vendorName ?? "nil")")
        var product: GameControllerProduct = .other
        if controller.vendorName?.hasPrefix("Joy-Con") ?? false {
            product = .JoyCon
        } else if controller.vendorName?.hasPrefix("Xbox") ?? false {
            product = .Xbox
        }
        
        return product
    }
}
