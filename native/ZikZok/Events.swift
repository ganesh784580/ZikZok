//
//  Events.swift
//  CarPooling
//
//  Created by Ganesh Arora on 10/02/20.
//  Copyright © 2020 Ganesh Arora. All rights reserved.
//

import Foundation

enum ZikZokEvents {
    //case LoggedIn
    //case LoggedOut
    //case LogInButtonPressed
    case UserInfoFetched
    case UserPreferenceSubmitted
    case LoggedOut
    case RideJoined
    case RideCompleted
    
    static let LoggedInNotificationName = Notification.Name(rawValue: "LoggedIn")
    static let LoggedOutNotificationName = Notification.Name(rawValue: "LoggedOut")
    static let LogInButtonPressedNotificationName = Notification.Name(rawValue: "LogInButtonPressed")
    static let UserInfoFetchedNotificationName = Notification.Name(rawValue: "UserInfoFetched")
    static let UserPreferenceSubmittedNotificationName = Notification.Name(rawValue: "UserPreferenceSubmitted")
    static let RideJoinedNotificationName = Notification.Name(rawValue: "RideJoined")
    static let RideCompletedNotificationName = Notification.Name(rawValue: "RideCompleted")
    
    
    func post() {
        switch self {
        case ZikZokEvents.LoggedOut: NotificationCenter.default.post(
            name: ZikZokEvents.LoggedOutNotificationName,
            object: self
            )
        case ZikZokEvents.UserInfoFetched: NotificationCenter.default.post(
            name: ZikZokEvents.UserInfoFetchedNotificationName,
            object: self
            )
        case ZikZokEvents.UserPreferenceSubmitted: NotificationCenter.default.post(
            name: ZikZokEvents.UserPreferenceSubmittedNotificationName,
            object: self
            )
        case ZikZokEvents.RideJoined: NotificationCenter.default.post(
            name: ZikZokEvents.RideJoinedNotificationName,
            object: self
            )
        case ZikZokEvents.RideCompleted: NotificationCenter.default.post(
            name: ZikZokEvents.RideCompletedNotificationName,
            object: self
            )
        }
    }
}
