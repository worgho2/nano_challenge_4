//
//  GameCenterSingleton.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import GameKit

enum Leaderboard {
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
}

class GameCenterSingleton: NSObject, GKLocalPlayerListener {
    
    static let instance = GameCenterSingleton()
    
    private let player = GKLocalPlayer.local
    
    let kAuthSuccess = Notification.Name("Player authenticated")
    
    private override init() { super.init() }
    
    //MARK: - Authentication Methods
    
    func authenticate() {
        print("tentando autenticar")
        self.player.authenticateHandler = { (_ , error) in
            if let error = error {
                print("[GameCenterSingleton] -", error.localizedDescription)
                return
            }
            
            NotificationCenter.default.post(name: self.kAuthSuccess, object: nil)
            
            print("autenticou mané")
        }
    }
    
    func isPlayerAuthenticated() -> Bool {
        return self.player.isAuthenticated
    }
    
    func getLeaderboard(leaderboard l: Leaderboard) -> GKLeaderboard {
        let leaderboard = GKLeaderboard(players: [self.player])
        leaderboard.timeScope = .allTime
        leaderboard.identifier = l.identifier
        return leaderboard
    }
    
    
    //MARK: - Get Leaderboard ViewController
    
    func getGameCenterViewController() -> GKGameCenterViewController? {
        guard self.isPlayerAuthenticated() else {
            return nil
        }
        
        let viewController = GKGameCenterViewController()
        
        return viewController
    }
    
}
