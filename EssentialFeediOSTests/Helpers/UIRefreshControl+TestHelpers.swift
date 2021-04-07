//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by mbp01 on 2021. 04. 07..
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent:
                        .valueChanged)?.forEach {
                            (target as NSObject).perform(Selector($0))
                        }
        }
    }
}
