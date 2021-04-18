//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by mbp01 on 2021. 04. 08..
//

import UIKit

final class FeedRefreshViewController: NSObject {
    private(set) lazy var view = binded(UIRefreshControl())

    private let feedViewModel: FeedViewModel

    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
    }

    @objc func refresh() {
        feedViewModel.loadFeed()
    }

    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        feedViewModel.onLoadingStateChange = { [weak view] isLoading in
            if isLoading {
                view?.beginRefreshing()
            } else {
                view?.endRefreshing()
            }
        }
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
