//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by mbp01 on 2021. 04. 07..
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
