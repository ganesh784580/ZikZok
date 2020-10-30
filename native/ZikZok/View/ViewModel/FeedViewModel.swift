//
//  FeedViewModel.swift
//  ZikZok
//
//  Created by temp-4400 on 29/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.


import AVFoundation
import Foundation


class FeedViewModel {
    
    var showAlertClosure: (()->())?
    
    var updateLoadingStatusClosure: (()->())?
   
    var feedsDidFinishedFetch: ((_ initialFeed: Feed?)->())?
    
    var feedsFetchFailed: ((Error?) -> ())?
    
    
    // MARK: - Properties
    
    let apiService: FeedFetchProtocol

    
    
    private var feeds: [Feed] = [Feed]() {
        didSet {
            if numberOfFeed > 0 {
                self.feedsDidFinishedFetch?(feeds.first)
            }else{
               
            }
        }
    }
    
    fileprivate var currentFeedIndex = 0
    
    var numberOfFeed: Int {
           return feeds.count
       }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }
    
    var feedsFetchError: Error?{
        didSet{
            self.feedsFetchFailed?(feedsFetchError)
        }
    }
    
    // MARK: - Constructor

    init( apiService: FeedFetchProtocol = FeedFetcher()) {
        self.apiService = apiService
        self.apiService.delegate = self
        configureAudioSession()
    }
    
    
    // MARK: - Fetching functions
    
    func fetchData() {
        self.isLoading = true
        apiService.fetchFeeds()
    }
    
    func fetchPrivateData(){
        
    }
    
    func fetchNextFeed() -> IndexedFeed? {
        return getFeed(atIndex: currentFeedIndex + 1)
    }
    
    func fetchPreviousFeed() -> IndexedFeed? {
        return getFeed(atIndex: currentFeedIndex - 1)
    }
    
    func updateFeedIndex(fromIndex index: Int) {
        currentFeedIndex = index
    }
    
    fileprivate func configureAudioSession() {
           try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
    }
    
    // MARK: - Retieve Data
    func getFeed(atIndex index: Int) -> IndexedFeed? {
        guard index >= 0 && index < feeds.count else {
            return nil
        }
        return (feed: feeds[index], index: index)
    }
}


extension FeedViewModel: FeedFetchDelegate {
    func feedFetchService(_ service: FeedFetchProtocol, didFetchFeeds feeds: [Feed], withError error: Error?) {
        isLoading = false
        self.feedsFetchError = error
        self.feeds = feeds
    }
}
