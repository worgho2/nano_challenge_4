//
//  StorableData.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

@propertyWrapper
struct Storage<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}


//    @Storage(key: "ObstacleHighScore", defaultValue: 0) private static var obstaclehighScore: Int
//    @Storage(key: "TimeHighScore", defaultValue: TimeInterval(0)) private static var timeHighScore: TimeInterval
//    @Storage(key: "TotalObstaclesScore", defaultValue: 0) private static var totalObstaclesScore: Int
