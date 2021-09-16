//
//  FeedErrorViewModel.swift
//  EssentialFeediOS
//
//  Created by mbp01 on 2021. 09. 16..
//

struct FeedErrorViewModel {
    let errorMessage: String?

    static var noError: FeedErrorViewModel {
        FeedErrorViewModel(errorMessage: nil)
    }

    static func error(message: String) -> FeedErrorViewModel {
        FeedErrorViewModel(errorMessage: message)
    }
}
