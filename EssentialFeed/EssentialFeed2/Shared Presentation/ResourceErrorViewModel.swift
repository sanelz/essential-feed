//
//  ResourceErrorViewModel.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 09. 18..
//

public struct ResourceErrorViewModel {
    public let errorMessage: String?

    static var noError: ResourceErrorViewModel {
        ResourceErrorViewModel(errorMessage: nil)
    }

    static func error(message: String) -> ResourceErrorViewModel {
        ResourceErrorViewModel(errorMessage: message)
    }
}
