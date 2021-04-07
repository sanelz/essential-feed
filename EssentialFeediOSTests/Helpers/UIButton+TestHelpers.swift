//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by mbp01 on 2021. 04. 07..
//

import UIKit

extension UIButton {
    func simulateTap() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .touchUpInside)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
