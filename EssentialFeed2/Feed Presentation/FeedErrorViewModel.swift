//
//  FeedErrorViewModel.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 09. 18..
//

public struct FeedErrorViewModel {
    public let errorMessage: String?

    static var noError: FeedErrorViewModel {
        FeedErrorViewModel(errorMessage: nil)
    }

    static func error(message: String) -> FeedErrorViewModel {
        FeedErrorViewModel(errorMessage: message)
    }
}
