//
//  GameScoreManager.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import GameKit

class GameScoreManager {
    
    private static var obstaclehighScore: Int {
        get {
            return UserDefaults.standard.object(forKey: "ObstacleHighScore") as? Int ?? 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ObstacleHighScore")
        }
    }
    private static var timeHighScore: TimeInterval {
        get {
            return UserDefaults.standard.object(forKey: "TimeHighScore") as? TimeInterval ?? TimeInterval(0)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "TimeHighScore")
        }
    }
    private static var totalObstaclesScore: Int {
        get {
            return UserDefaults.standard.object(forKey: "TotalObstaclesScore") as? Int ?? 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "TotalObstaclesScore")
        }
    }
    
    private var currentTime: TimeInterval!
    private var currentScore: Int!
    
    var interfaceDelegate: InterfaceDelegate!
    
    init(interfaceDelegate: InterfaceDelegate) {
        self.interfaceDelegate = interfaceDelegate
        
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
    
    private func setupValues() {
        self.currentTime = 0
        self.currentScore = 0
    }
    
    func incrementTime(by: TimeInterval = 1) {
        self.currentTime += by
    }
    
    func incrementScore(by: Int = 1) {
        self.currentScore += by
    }
    
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

extension GameScoreManager: Updateable {
    
    func update(_ deltaTime: TimeInterval) {
        self.incrementTime(by: deltaTime)
        self.interfaceDelegate.sendScore(score: currentScore, time: currentTime)
    }
    
}

extension GameScoreManager: TriggeredByGameState {
    
    func onGameStart() {
        self.setupValues()
    }
    
    func onGameOver() {
        self.setHighScore(newTimeHighScore: self.currentTime, newObstacleHighScore: self.currentScore)
    }
    
    func onGamePause() { return }
    
    func onGameContinue() { return }
    
}
