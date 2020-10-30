//
//  FeedFetcherService.swift
//  ZikZok
//
//  Created by temp-4400 on 25/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.
//

import Foundation
import ZCCoreFramework

protocol FeedFetchDelegate: class {
    func feedFetchService(_ service: FeedFetchProtocol, didFetchFeeds feeds: [Feed], withError error: Error?)
}

protocol FeedFetchProtocol: class {
    var delegate: FeedFetchDelegate? { get set }
    func fetchFeeds()
    func fetchPrivateFeeds()
}

class FeedFetcher: FeedFetchProtocol {
    fileprivate let networking: ConnectionProtocol.Type
    weak var delegate: FeedFetchDelegate?
    
    init(networking: ConnectionProtocol.Type = Connection.self) {
        self.networking = networking
    }
    
    
    func fetchFeeds() {
       // fetchPrivateFeeds()
        guard let request = HTTPRequest(url: URL(string: BASE_URL)) else { return }
        networking.makeRequest(request, errorHandler: { [weak self] error in
            guard let serviceSelf = self else {
                return
            }
            serviceSelf.fetchFeedFailed(withError: error)
        }) { [weak self] data, _ in
            guard let serviceSelf = self else {
                return
            }
            serviceSelf.fetchFeedSuccess(withData: data)
        }
    }
    
    
    func fetchPrivateFeeds() {

        ZikZokAPIHandler.fetchFeedsReport(searchColoumns: [SearchableColumn]()) { listreport, error in
            if let listreport = listreport, listreport.records.count  > 0 {
                do {
                    let feeds = try PrivateFeedsParser.parseFeeds(listReport: listreport)
                   self.delegate?.feedFetchService(self, didFetchFeeds: feeds, withError: nil)
                } catch {
                    print(error)
                    self.delegate?.feedFetchService(self, didFetchFeeds: [Feed](), withError: error)
                }
            }
        }
    }
    
    
    fileprivate func fetchFeedFailed(withError error: Error) {
        self.delegate?.feedFetchService(self, didFetchFeeds: [], withError: error)
    }
    
    
    fileprivate func fetchFeedSuccess(withData data: Data) {
        var feeds: [Feed]
        do {
            feeds = try JSONDecoder().decode([Feed].self, from: data)
        } catch {
            
            feeds = []
        }
        self.delegate?.feedFetchService(self, didFetchFeeds: feeds, withError: nil)
    }
}

