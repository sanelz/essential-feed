//
//  FeedImagePresenter.swift
//  EssentialFeed2
//
//  Created by mbp01 on 2021. 09. 19..
//

import Foundation

public final class FeedImagePresenter {
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location)
    }
}
