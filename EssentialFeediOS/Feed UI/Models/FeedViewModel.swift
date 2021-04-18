//
//  FeedViewModel.swift
//  EssentialFeediOS
//
//  Created by mbp01 on 2021. 04. 10..
//

import EssentialFeed2

final class FeedViewModel {
    typealias Obeserve<T> = (T) -> Void

    private let feedLoader: FeedLoader

    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    var onLoadingStateChange: Obeserve<Bool>?
    var onFeedLoad: Obeserve<[FeedImage]>?

    func loadFeed() {
        onLoadingStateChange?(true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            self?.onLoadingStateChange?(false)
        }
    }
}
