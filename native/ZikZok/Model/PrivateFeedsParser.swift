//
//  PrivateFeedsParser.swift
//  ZikZok
//
//  Created by temp-4400 on 29/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.
//

import Foundation
import ZCCoreFramework

struct  PrivateFeedsParser {
    static func parseFeeds(listReport: ListReport) throws -> [Feed] {
        var feeds = [Feed]()
        for record in listReport.records {
            
            let feedIDLinkName = ZikZokFeedsConstant.FeedForm.feedID
            let urlLinkName = ZikZokFeedsConstant.FeedForm.url
            
            let feedIDValue   = try record.recordValue(for: feedIDLinkName)
            let feedURLValue   = try record.recordValue(for: urlLinkName)
            
            var feedID: String?
            var feedURL: String?
            
            do{
                if case let RecordValue.Value.text(textValue) = feedIDValue.value {
                    feedID = textValue.value
                }
                
                if case let RecordValue.Value.text(textValue) = feedURLValue.value {
                    feedURL = textValue.value
                }
                
            }
            feeds.append(Feed(id: feedID ?? "", url: URL(string: feedURL ?? "")))
        }
        
        return feeds
    }
}
