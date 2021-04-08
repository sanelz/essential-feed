//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by mbp01 on 2021. 04. 08..
//

import EssentialFeed2

public final class FeedUIComposer {
    private init() {}

    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let refreshController = FeedRefreshViewController(feedLoader: feedLoader)
        let feedController = FeedViewController(refreshController: refreshController)
        refreshController.onRefresh = { [weak feedController] feed in
            feedController?.tableModel = feed.map { model in
                FeedImageViewCellController(model: model, imageLoader: imageLoader)
            }
        }

        return feedController
    }
}
