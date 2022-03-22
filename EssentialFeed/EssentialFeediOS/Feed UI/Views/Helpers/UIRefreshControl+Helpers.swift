//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by mbp01 on 2021. 09. 16..
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
