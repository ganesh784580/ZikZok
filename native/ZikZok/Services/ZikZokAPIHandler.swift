//
//  ZikZokAPIHandler.swift
//  ZikZok
//
//  Created by temp-4400 on 29/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.
//

import Foundation
import ZCCoreFramework

typealias AllFeedsFetchCompletion = (ListReport?, Error?) -> Void

class ZikZokAPIHandler: NSObject {
    // Fetch User Info From Cache
     public static func fetchMyUserInfoFromCache() -> UserInfo?
     {
         return ZCCacheService.fetchUserInfoFromCache()
         
     }
     
     // Fetch User Info From Server
     public static func fetchMyUserInfo(shouldCacheResponse: Bool, completionHandler: @escaping (Result<UserInfo>) -> Void)
     {
         ZCAPIService.fetchUserInfo(shouldCacheResponse: shouldCacheResponse, completionHandler: completionHandler)
     }
    
    // Fetch The Form
       public static func fetch(for formInfo: FormInfo, completionHandler: @escaping (Result<WorkFlowChangeSet>) -> Void)
       {
           ZCFormAPIService.fetch(for: formInfo, completionHandler: completionHandler)
       }
    
    public static func fetchFeedsReport(searchColoumns: [SearchableColumn], completion: @escaping AllFeedsFetchCompletion) {
        
        let appDisplayName = ZikZokFeedsConstant.app_DisplayName
        let reportLinkName = ZikZokFeedsConstant.reportLinkName
        let reportDisplayName = ZikZokFeedsConstant.reportLinkName
        let appOwner = ZikZokFeedsConstant.appOwnerName
        let appLinkName = ZikZokFeedsConstant.app_LinkName
        
       
        
        
        let ridesReportInfo =  ReportInfo(openUrlInfo: nil, appOwner: appOwner, appLinkName: appLinkName, linkName: reportLinkName, type: .report, appDisplayname: appDisplayName, displayName: appDisplayName, notificationEnabled: false)
        
        
        let queryItems = ReportQueryItems(searchedColumns: searchColoumns, selectedFilters: nil, groupedColumns: nil, sortedColumns: nil, selectedCustomFilter: nil, generatedByUrl: false)
        
        let apiConfig = ReportAPIConfiguration(needViewMeta: true, recordID: nil, reportHierarchy: nil, queryItems: queryItems, queryString: nil, setCriteria: false, isOffline: false)
        
        let reportConfiguration = ListReportAPIConfiguration(fromIndex: 0, limit: 50, moreInfo: apiConfig)
        
        ZCReportAPIService.fetchListReport(for: ridesReportInfo, with: reportConfiguration, completionHandler: { (result) in
            switch result{
            case .failure(let error):
                print("log: list failed")
                print(error)
                completion(nil, error)
            case .success(let listReport):
                print("log: list fetched")
                print(listReport)
                completion(listReport, nil)
            }
        }, shouldCacheResponse: true)
    }
}
struct ZikZokFeedsConstant {
    
    static let app_LinkName = "zmluikitdemo"
    static let app_DisplayName = "My Daily Tour"
    static let appOwnerName = "ganeshat0"
    static let reportLinkName = "All_Feeds"
    
    struct FeedForm
    {
        static let feedID = "Feed_ID"
        static let url = "URL"
    }
    
}

