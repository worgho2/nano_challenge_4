//
//  Score.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class Score: Updateable, TriggeredByGameState {
    
    var gameOnboardingManager: GameOnboardingManager!
    var gameScoreManager: GameScoreManager!
    var interfaceDelegate: InterfaceDelegate!
    
    private var currentTime: TimeInterval!
    private var currentScore: Int!
    
    init(scene: SKScene?, gameScoreManager: GameScoreManager, gameOnboardingManager: GameOnboardingManager, interfaceDelegate: InterfaceDelegate) {
        
        self.gameScoreManager = gameScoreManager
        self.gameOnboardingManager = gameOnboardingManager
        self.interfaceDelegate = interfaceDelegate
    
        self.setupValues()
    }
    
    //MARK: - Class Methods
    
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
    
    //MARK: - Updateable PROTOCOL
    
    func update(_ deltaTime: TimeInterval) {
        self.incrementTime(by: deltaTime)
        self.interfaceDelegate.sendScore(score: currentScore, time: currentTime)
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    func onGameStart() {
        self.setupValues()
    }
    
    func onGameOver() {
        self.gameScoreManager.setHighScore(newTimeHighScore: self.currentTime, newObstacleHighScore: self.currentScore)
    }
    
    func onGamePause() {
        return
    }
    
    func onGameContinue() {
        return
    }
}
