//
//  UIDeviceOrientation.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//

import UIKit

extension UIDeviceOrientation {
    var videoRotationAngle: CGFloat {
        switch self {
        case .landscapeLeft:
            0
        case .portrait:
            90
        case .landscapeRight:
            180
        case .portraitUpsideDown:
            270
        default:
            90
        }
    }
    var uiImageOrientation: UIImage.Orientation {
        switch self {
        case .landscapeLeft:
            .up
        case .portrait:
            .right
        case .landscapeRight:
            .down
        case .portraitUpsideDown:
            .left
        default: .right
        }
    }
}
