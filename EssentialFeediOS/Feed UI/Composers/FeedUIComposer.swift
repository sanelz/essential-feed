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
        refreshController.onRefresh = adaptFeedToCellControllers(forwardingTo: feedController, loader: imageLoader)
        return feedController
    }

    private static func adaptFeedToCellControllers(forwardingTo controller: FeedViewController, loader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        { [weak controller] feed in
            controller?.tableModel = feed.map { model in
                FeedImageViewCellController(model: model, imageLoader: loader)
            }
        }
    }
}
