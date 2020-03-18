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
        NotificationCenter.default.addObserver(self, selector: #selector(self.verifyGameCenterScore), name: GameCenterSingleton.instance.kAuthSuccess, object: nil)
    }
    
    //MARK: - Class Mehtods

    @objc func verifyGameCenterScore() {
        
        guard GameCenterSingleton.instance.isPlayerAuthenticated() else {
            return
        }
        print("atualizou os scores com game center")
        
        let BestTimeleaderboard = GameCenterSingleton.instance.getLeaderboard(leaderboard: .bestTime)
        BestTimeleaderboard.loadScores { (scores, error) in
            
            if let error = error {
                print("[GameCenterSingleton] -", error.localizedDescription)
                return
            }
            
            if let score = scores?.first {
                let value = TimeInterval(score.value)
                
                if value >= self.getHighScore().time {
                    self.setTimeHighScore(newScore: value)
                } else {
                    let score = GKScore(leaderboardIdentifier: Leaderboard.bestTime.identifier)
                    score.value = Int64(value)

                    GKScore.report([score]) { (error) in
                        if let error = error {
                            print("Erro ao reportar o record!", error.localizedDescription)
                            return
                        }
                        print("[GameCenter] Reported new best time record")
                    }
                }
                
            }
        }
        
        let Obstacleleaderboard = GameCenterSingleton.instance.getLeaderboard(leaderboard: .highScore)
        Obstacleleaderboard.loadScores { (scores, error) in
            
            if let error = error {
                print("[GameCenterSingleton] -", error.localizedDescription)
                return
            }
            
            if let score = scores?.first {
                let value = Int(score.value)
                
                if value >= self.getHighScore().obstacle {
                    self.setObstacleHighScore(newScore: value)
                } else {
                    let score = GKScore(leaderboardIdentifier: Leaderboard.highScore.identifier)
                    score.value = Int64(value)

                    GKScore.report([score]) { (error) in
                        if let error = error {
                            print("Erro ao reportar o record!", error.localizedDescription)
                            return
                        }
                        print("[GameCenter] Reported new best time record")
                    }
                }
                
            }
        }
        
        let TotalObstacleleaderboard = GameCenterSingleton.instance.getLeaderboard(leaderboard: .totalObstacles)
        TotalObstacleleaderboard.loadScores { (scores, error) in
            
            if let error = error {
                print("[GameCenterSingleton] -", error.localizedDescription)
                return
            }
            
            if let score = scores?.first {
                let value = Int(score.value)
                
                if value >= self.getHighScore().obstacle {
                    self.setTotalObstaclesHighScore(newScore: value)
                } else {
                    let score = GKScore(leaderboardIdentifier: Leaderboard.totalObstacles.identifier)
                    score.value = Int64(value)

                    GKScore.report([score]) { (error) in
                        if let error = error {
                            print("Erro ao reportar o record!", error.localizedDescription)
                            return
                        }
                        print("[GameCenter] Reported new best time record")
                    }
                }
                
            }

        }
        
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
            
            if GameCenterSingleton.instance.isPlayerAuthenticated() {
                let score = GKScore(leaderboardIdentifier: Leaderboard.bestTime.identifier)
                score.value = Int64(newScore)

                GKScore.report([score]) { (error) in
                    if let error = error {
                        print("Erro ao reportar o record!", error.localizedDescription)
                        return
                    }
                    print("[GameCenter] Reported new time record")
                }
            }
        }
    }
    
    private func setObstacleHighScore(newScore: Int) {
        if newScore > self.getHighScore().obstacle {
            GameScoreManager.obstaclehighScore = newScore
            
            if GameCenterSingleton.instance.isPlayerAuthenticated() {
                let score = GKScore(leaderboardIdentifier: Leaderboard.highScore.identifier)
                score.value = Int64(newScore)

                GKScore.report([score]) { (error) in
                    if let error = error {
                        print("Erro ao reportar o record!", error.localizedDescription)
                        return
                    }
                    print("[GameCenter] Reported new  obstacle record")
                }
            }
        }
    }
    
    private func setTotalObstaclesHighScore(newScore: Int) {
        if newScore > self.getHighScore().totalObstacles {
            GameScoreManager.totalObstaclesScore = newScore
            
            if GameCenterSingleton.instance.isPlayerAuthenticated() {
                let score = GKScore(leaderboardIdentifier: Leaderboard.totalObstacles.identifier)
                score.value = Int64(newScore)

                GKScore.report([score]) { (error) in
                    if let error = error {
                        print("Erro ao reportar o record!", error.localizedDescription)
                        return
                    }
                    print("[GameCenter] Reported new total obstacle record")
                }
            }
        }
    }
    
}
