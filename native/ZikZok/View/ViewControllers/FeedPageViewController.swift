//
//  FeedPageViewController.swift
//  ZikZok
//
//  Created by temp-4400 on 25/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.

import Foundation
import UIKit

typealias IndexedFeed = (feed: Feed, index: Int)


class FeedPageViewController: UIPageViewController {
    
    fileprivate lazy var viewModel: FeedViewModel = {
        return FeedViewModel()
    }()
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func presentInitialFeed(_ feed: Feed) {
        let viewController = FeedViewController.instantiate(feed: feed, andIndex: 0, isPlaying: true) as! FeedViewController
        setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
            
        fetchFeeds()
    }
    
    func fetchFeeds() {
        
        viewModel.feedsDidFinishedFetch = { firstFeed in
            if let firstFeed = firstFeed {
                self.presentInitialFeed(firstFeed)
            }
        }
        
        viewModel.feedsFetchFailed = { error in
            
        }
        
        viewModel.fetchData()
    }
    
}


extension FeedPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?  {
        guard let indexedFeed = viewModel.fetchPreviousFeed() else {
            return nil
        }
        return FeedViewController.instantiate(feed: indexedFeed.feed, andIndex: indexedFeed.index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let indexedFeed = viewModel.fetchNextFeed() else {
            return nil
        }
        return FeedViewController.instantiate(feed: indexedFeed.feed, andIndex: indexedFeed.index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        if
            let viewController = pageViewController.viewControllers?.first as? FeedViewController,
            let previousViewController = previousViewControllers.first as? FeedViewController
        {
            previousViewController.pause()
            viewController.play()
            viewModel.updateFeedIndex(fromIndex: viewController.index)
        }
    }
}


