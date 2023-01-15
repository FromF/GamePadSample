//
//  GameControllerModel.swift
//  GamePadSample
//
//  Created by 藤治仁 on 2023/01/15.
//

import Foundation
import GameController

protocol GameControllerDelegate {
    func operationGamePad(_ operation: GameControllerOperation)
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
        print(">>Debug \(#fileID) \(#line)  ")
        guard let controller = notification.object as? GCController else {
            return
        }
        setupGameController(controller: controller)
    }
    
    @objc private func handleControllerDidDisconnect(notification: Notification) {
        print(">>Debug \(#fileID) \(#line)  ")
    }
    
    private func setupGameController(controller: GCController) {
        guard let gamepad = controller.extendedGamepad else {
            return
        }
        print(">>Debug \(#fileID) \(#line)  ")

        gamepad.dpad.up.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .upPress : .upRelease)
        }
        gamepad.dpad.down.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .downPress : .downRelease)
        }
        gamepad.dpad.left.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .leftPress : .leftRelease)
        }
        gamepad.dpad.right.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .rightPress : .rightRelease)
        }
        gamepad.dpad.xAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.xAxis(value))
        }
        gamepad.dpad.yAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.yAxis(value))
        }
        gamepad.buttonA.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonAPress : .buttonARelease)
        }
        gamepad.buttonB.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonBPress : .buttonBRelease)
        }
        gamepad.buttonX.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonXPress : .buttonXRelease)
        }
        gamepad.buttonY.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonYPress : .buttonYRelease)
        }
        gamepad.buttonMenu.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonMenuPress : .buttonMenuRelease)
        }
        gamepad.buttonOptions?.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonOptionsPress : .buttonOptionsRelease)
        }
        gamepad.buttonHome?.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonHomePress : .buttonHomeRelease)
        }
        gamepad.leftThumbstick.xAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.leftXAxis(value))
        }
        gamepad.leftThumbstick.yAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.leftYAxis(value))
        }
        gamepad.rightThumbstick.xAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.rightXAxis(value))
        }
        gamepad.rightThumbstick.yAxis.valueChangedHandler = { [weak self] (_, value) in
            self?.operationGamePad(.rightYAxis(value))
        }
        gamepad.leftShoulder.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonLeftShoulderPress : .buttonLeftShoulderRelease)
        }
        gamepad.rightShoulder.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonRightShoulderPress : .buttonRightShoulderRelease)
        }
        gamepad.leftTrigger.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonLeftTriggerPress : .buttonLeftTriggerRelease)
        }
        gamepad.rightTrigger.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .buttonRightTriggerPress : .buttonRightTriggerRelease)
        }
        gamepad.leftThumbstickButton?.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .leftAxisPress : .leftAxisRelease)
        }
        gamepad.rightThumbstickButton?.pressedChangedHandler = { [weak self] (_, _, isPressed) in
            self?.operationGamePad(isPressed ? .rightAxisPress : .rightAxisRelease)
        }
    }
    
    private func operationGamePad(_ operation: GameControllerOperation) {
        print(">>Debug \(#fileID) \(#line) : \(operation)")
        self.delegate?.operationGamePad(operation)
    }
}
