//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by mbp01 on 2021. 04. 04..
//

import UIKit
import EssentialFeed2

final public class FeedViewController: UITableViewController {
    private var loader: FeedLoader?

    public convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        load()
    }

    @objc private func load() {
        refreshControl?.beginRefreshing()
        loader?.load { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }
    }
}
