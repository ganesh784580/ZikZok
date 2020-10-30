//
//  FeedViewController.swift
//  ZikZok
//
//  Created by temp-4400 on 25/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.


import Foundation
import UIKit
import AVKit
import AVFoundation

class FeedViewController: AVPlayerViewController {
    
    var index: Int!
    fileprivate var feed: Feed!
    fileprivate var isPlaying: Bool!
    
    static func instantiate(feed: Feed, andIndex index: Int, isPlaying: Bool = false) -> UIViewController {
        let viewController = FeedViewController()
        viewController.feed = feed
        viewController.index = index
        viewController.isPlaying = isPlaying
        return viewController
    }
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFeed()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
         player?.pause()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        player?.play()
    }
    
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    
    fileprivate func initializeFeed() {
        guard let url = feed.url else {return}
        player = AVPlayer(url: url)
        isPlaying ? play() : nil
    }
}


