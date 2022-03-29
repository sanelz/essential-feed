//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by mbp01 on 2021. 04. 07..
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
