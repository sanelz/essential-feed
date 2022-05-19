//
//  FeedViewAdapter.swift
//  EssentialFeediOS
//
//  Created by mbp01 on 2021. 05. 16..
//

import UIKit
import EssentialFeed2
import EssentialFeediOS

final class FeedViewAdatper: ResourceView {
    private weak var controller: FeedViewController?
    private let imageLoader: (URL) -> FeedImageDataLoader.Publisher

    init(controller: FeedViewController, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) {
        self.controller = controller
        self.imageLoader = imageLoader
    }

    func display(_ viewModel: FeedViewModel) {
        controller?.display(viewModel.feed.map { model in
            let adapter = FeedImageDataLoaderPresentationAdapter<WeakRefVirtualProxy<FeedImageCellController>, UIImage>(model: model, imageLoader: imageLoader)
            let view = FeedImageCellController(delegate: adapter)

            adapter.presenter = FeedImagePresenter(
                view: WeakRefVirtualProxy(view),
                imageTransformer: UIImage.init)

            return view
        })
    }
}

