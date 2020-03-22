//
//  GameScoreManager.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import GameKit

class GameScoreManager {
    
    @Storage(key: "ObstacleHighScore", defaultValue: 0) private static var obstaclehighScore: Int
    @Storage(key: "TimeHighScore", defaultValue: TimeInterval(0)) private static var timeHighScore: TimeInterval
    @Storage(key: "TotalObstaclesScore", defaultValue: 0) private static var totalObstaclesScore: Int
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onTotalObstaclesNotification(_:)), name: Leaderboard.totalObstacles.notificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onHighScoreNotification(_:)), name: Leaderboard.highScore.notificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onBestTimeNotification(_:)), name: Leaderboard.bestTime.notificationName, object: nil)
    }
    
    //MARK: - Notification Center Methods
    
    @objc func onTotalObstaclesNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let score = dict[0] as? Int {
                
                if score > GameScoreManager.totalObstaclesScore {
                    GameScoreManager.totalObstaclesScore = score
                } else if score < GameScoreManager.totalObstaclesScore {
                    GameCenterSingleton.instance.setScore(leaderboard: .totalObstacles, value: Int64(GameScoreManager.totalObstaclesScore))
                }
                
            }
        }
    }
    
    @objc func onHighScoreNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let score = dict[0] as? Int {
                
                if score > GameScoreManager.obstaclehighScore {
                    GameScoreManager.obstaclehighScore = score
                } else if score < GameScoreManager.obstaclehighScore {
                    GameCenterSingleton.instance.setScore(leaderboard: .highScore, value: Int64(GameScoreManager.obstaclehighScore))
                }
                
            }
        }
    }
    
    @objc func onBestTimeNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let score = dict[0] as? TimeInterval {
                
                if score > GameScoreManager.timeHighScore {
                    GameScoreManager.timeHighScore = score
                } else if score < GameScoreManager.timeHighScore {
                    GameCenterSingleton.instance.setScore(leaderboard: .bestTime, value: Int64(GameScoreManager.timeHighScore))
                }
                
            }
        }
    }
    
    //MARK: - Class Mehtods
    
    func getHighScore() -> (time: TimeInterval, obstacle: Int, totalObstacles: Int) {
        return (GameScoreManager.timeHighScore, GameScoreManager.obstaclehighScore, GameScoreManager.totalObstaclesScore)
    }
    
    func setHighScore(newTimeHighScore: TimeInterval?, newObstacleHighScore: Int?) {
        if let newTimeHighScore = newTimeHighScore {
            self.setTimeHighScore(newScore: newTimeHighScore)
        }
        
        if let newObstacleHighScore = newObstacleHighScore {
            self.setTotalObstaclesHighScore(newScore: self.getHighScore().totalObstacles + newObstacleHighScore)
            self.setObstacleHighScore(newScore: newObstacleHighScore)
        }
    }
    
    private func setTimeHighScore(newScore: TimeInterval) {
        if newScore > self.getHighScore().time {
            GameScoreManager.timeHighScore = newScore
            GameCenterSingleton.instance.setScore(leaderboard: .bestTime, value: Int64(newScore))
        }
    }
    
    private func setObstacleHighScore(newScore: Int) {
        if newScore > self.getHighScore().obstacle {
            GameScoreManager.obstaclehighScore = newScore
            GameCenterSingleton.instance.setScore(leaderboard: .highScore, value: Int64(newScore))
        }
    }
    
    private func setTotalObstaclesHighScore(newScore: Int) {
        if newScore > self.getHighScore().totalObstacles {
            GameScoreManager.totalObstaclesScore = newScore
            GameCenterSingleton.instance.setScore(leaderboard: .totalObstacles, value: Int64(newScore))
        }
    }
    
}
