//
//  GameScoreManager.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class GameScoreManager {
    
    @Storage(key: "ObstacleHighScore", defaultValue: 0) private static var obstaclehighScore: Int
    @Storage(key: "TimeHighScore", defaultValue: TimeInterval(0)) private static var timeHighScore: TimeInterval
    
    func getHighScore() -> (time: TimeInterval, obstacle: Int) {
        return (GameScoreManager.timeHighScore, GameScoreManager.obstaclehighScore)
    }
    
    func setHighScore(newTimeHighScore: TimeInterval?, newObstacleHighScore: Int?) {
        if let newTimeHighScore = newTimeHighScore {
            self.setTimeHighScore(newScore: newTimeHighScore)
        }
        
        if let newObstacleHighScore = newObstacleHighScore {
            self.setObstacleHighScore(newScore: newObstacleHighScore)
        }
    }
    
    private func setTimeHighScore(newScore: TimeInterval) {
        if newScore > self.getHighScore().time {
            GameScoreManager.timeHighScore = newScore
        }
    }
    
    private func setObstacleHighScore(newScore: Int) {
        if newScore > self.getHighScore().obstacle {
            GameScoreManager.obstaclehighScore = newScore
        }
    }
    
}
