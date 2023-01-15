//
//  GameControllerOperation.swift
//  GamePadSample
//
//  Created by 藤治仁 on 2023/01/15.
//

import Foundation

enum GameControllerOperation {
    case upPress
    case upRelease
    case downPress
    case downRelease
    case leftPress
    case leftRelease
    case rightPress
    case rightRelease
    case xAxis(_ value: Float)
    case yAxis(_ value: Float)
    case buttonAPress
    case buttonARelease
    case buttonBPress
    case buttonBRelease
    case buttonXPress
    case buttonXRelease
    case buttonYPress
    case buttonYRelease
    case buttonMenuPress
    case buttonMenuRelease
    case buttonOptionsPress
    case buttonOptionsRelease
    case buttonHomePress
    case buttonHomeRelease
    case leftXAxis(_ value: Float)
    case leftYAxis(_ value: Float)
    case leftAxisPress
    case leftAxisRelease
    case rightXAxis(_ value: Float)
    case rightYAxis(_ value: Float)
    case rightAxisPress
    case rightAxisRelease
    case buttonLeftShoulderPress
    case buttonLeftShoulderRelease
    case buttonRightShoulderPress
    case buttonRightShoulderRelease
    case buttonLeftTriggerPress
    case buttonLeftTriggerRelease
    case buttonRightTriggerPress
    case buttonRightTriggerRelease
}
