//
//  GameCenterSingleton.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import GameKit

enum Leaderboard: CaseIterable {
    case highScore
    case bestTime
    case totalObstacles
    
    var identifier: String {
        switch self {
        case .highScore:
            return "highscore"
        case .bestTime:
            return "besttime"
        case .totalObstacles:
            return "totalobstacles"
        }
    }
    
    var notificationName: Notification.Name {
        switch self {
        case .highScore:
            return Notification.Name("highscoreNotification")
        case .bestTime:
            return Notification.Name("besttimeNotification")
        case .totalObstacles:
            return Notification.Name("totalobstaclesNotification")
        }
    }
}

class GameCenterSingleton: NSObject, GKLocalPlayerListener {
    
    static let instance = GameCenterSingleton()
    
    private let player = GKLocalPlayer.local
    
    private(set) var isGameCenterEnabled = false
    
    let kAuthSuccess = Notification.Name("Player authenticated")
    
    private override init() { super.init() }
    
    //MARK: - Authentication Methods
    
    func authenticate(origin: UIViewController) {
        
        print("[GAME-CENTER] - Authentication started")
        
        self.player.authenticateHandler = { [weak self] (vc, error) -> Void in
            
            if let error = error {
                print("[GAME-CENTER] - Error ->", error.localizedDescription)
                return
            }
            
            if let vc = vc {
                origin.present(vc, animated: true, completion: nil)
                return
            }
            
            if self?.player.isAuthenticated ?? false {
                print("[GAME-CENTER] - User authenticated (Name: \(self!.player.displayName), IsUnderage: \(self!.player.isUnderage))")
                self?.isGameCenterEnabled = true
                NotificationCenter.default.post(name: self!.kAuthSuccess, object: nil)
                Leaderboard.allCases.forEach { self!.getScore(leaderboard: $0) }
                return
            }
            
            self?.isGameCenterEnabled = false
            print("[GAME-CENTER] - Player cannot be authenticated!")
        }
    }
    
    func canUseGameCenter() -> Bool {
        return self.player.isAuthenticated && self.isGameCenterEnabled
    }
    
    //MARK: - Get Leaderboard ViewController
    
    func presentGameCenterView(_ origin: UIViewController) {
        if self.canUseGameCenter() {
            let viewController = GKGameCenterViewController()
            viewController.gameCenterDelegate = self
            
            origin.present(viewController, animated: true, completion: nil)
        } else {
            let viewController = UIAlertController(title: "Game center is not available", message: nil, preferredStyle: .alert)
            viewController.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
            
            origin.present(viewController, animated: true, completion: nil)
        }
    }
    
    //MARK: - Score Manager Methods
    
    func setScore(leaderboard: Leaderboard, value: Int64) {
        if self.canUseGameCenter() {
            let score = GKScore(leaderboardIdentifier: leaderboard.identifier)
            score.value = value
            
            GKScore.report([score]) { (error) in
                if let error = error {
                    print("[GAME-CENTER] ->", error.localizedDescription)
                    return
                }
                print("[GAME-CENTER] - Send Score: (LeaderboardID: \(leaderboard.identifier), Value: \(value))")
            }
        } else {
            print("[GAME-CENTER] -> Fail to send score)")
        }
        
    }
    
    private func getScore(leaderboard: Leaderboard) {
        let leaderboardReference = GKLeaderboard(players: [self.player])
        leaderboardReference.timeScope = .allTime
        leaderboardReference.identifier = leaderboard.identifier
        
        leaderboardReference.loadScores { (scores, error) in
            
            if let error = error {
                print("[GAME-CENTER] ->", error.localizedDescription)
                return
            }
            
            if let scores = scores {
                let myBestScore = scores.first(where: {$0.player.displayName == self.player.displayName})
                let notificationInfo:  [Int : Int64] = [ 0 : myBestScore!.value ]
                
                NotificationCenter.default.post(name: leaderboard.notificationName, object: nil, userInfo: notificationInfo)
                
                print("[GAME-CENTER] - Get Score: (LeaderboardID: \(leaderboard.identifier), Value: \(myBestScore!.value))")
            } else {
                print("[GAME-CENTER] - Get Score: (Empty on: \(leaderboard.identifier))")
            }
            
        }
        
    }
    
}

extension GameCenterSingleton: GKGameCenterControllerDelegate {
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
}
