//
//  ResourceErrorViewModel.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 09. 18..
//

public struct ResourceErrorViewModel {
    public let message: String?

    static var noError: ResourceErrorViewModel {
        ResourceErrorViewModel(message: nil)
    }

    static func error(message: String) -> ResourceErrorViewModel {
        ResourceErrorViewModel(message: message)
    }
}
