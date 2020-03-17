//
//  GameScene.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var vc: GameViewController?
    
    private var lastUpdate = TimeInterval(0)
    
    var realPaused: Bool = false {
        didSet {
            self.isPaused = realPaused
        }
    }
    override var isPaused: Bool {
        didSet {
            if (!self.isPaused && self.realPaused) {
                self.isPaused = true
            }
        }
    }
    private var isGameEnded: Bool = false
    
    
    var onboarding: Onboarding!
    var score: Score!
    var wheel: Wheel!
    var drop: Drop!
    var obstacleSpawner: ObstacleSpawner!
    
    var gameColorManager =  GameColorManager()
    var gameSpeedManager =  GameSpeedManager()
    var gameScoreManager =  GameScoreManager()
    var gameAudioManager =  GameAudioManager()
    var gameHapticManager =  GameHapticManager()
    
    var gameOnboardingManager = GameOnboardingManager()
    
    //MARK: - Class Methods
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        self.onboarding = Onboarding(scene: self, gameOnboardingManager: self.gameOnboardingManager, gameColorManager: self.gameColorManager)
        
        self.score = Score(scene: self, gameScoreManager: self.gameScoreManager, gameOnboardingManager: self.gameOnboardingManager)
        self.wheel = Wheel(scene: self, gameColorManager: self.gameColorManager)
        self.drop = Drop(scene: self)
        self.obstacleSpawner = ObstacleSpawner(scene: self, gameAudioManager: self.gameAudioManager, gameHapticManager: self.gameHapticManager, gameSpeedManager: self.gameSpeedManager, gameColorManager: self.gameColorManager)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if !isGameEnded {
            guard let deltaTime = self.updateDeltaTime(currentTime) else { return }
            
            self.getUpdatables().forEach { $0.update(deltaTime) }
        }
    }
    
    private func updateDeltaTime(_ currentTime: TimeInterval) -> TimeInterval? {
        
        if lastUpdate == 0 {
            lastUpdate = currentTime
            return nil
        }
        
        let deltaTime = currentTime - lastUpdate
        self.lastUpdate = currentTime
        
        if deltaTime > 0.1 { return  nil }
        
        return deltaTime
    }
    
    private func getTriggeredsByGameState() -> [TriggeredByGameState] {
        return [
            self.score,
            self.drop,
            self.wheel,
            self.vc!,
            self.gameSpeedManager,
            self.obstacleSpawner
        ]
    }
    private func getTouchSensitives() -> [TouchSensitive] {
        return [
            self.wheel,
            self.onboarding
        ]
    }
    private func getUpdatables() -> [Updateable] {
        return [
            self.score,
            self.wheel,
            self.obstacleSpawner,
            self.gameSpeedManager,
            self.vc!,
            self.onboarding
        ]
    }
    
    func play(isGamePaused: Bool) {
        self.realPaused = false
        
        if isGamePaused {
            self.onGameContinue()
        } else {
            self.onGameStart()
        }
    }
    
    func pause() {
        self.realPaused = true
        self.onGamePause()
    }
    
    func onGameStart() {
        self.isGameEnded = false
        self.gameAudioManager.play(soundEffect: .playNew)
        self.getTriggeredsByGameState().forEach { $0.onGameStart() }
    }
    
    private func onGamePause() {
        self.getTriggeredsByGameState().forEach { $0.onGamePause() }
    }
    
    private func onGameContinue() {
        self.getTriggeredsByGameState().forEach { $0.onGameContinue() }
    }
    
    func onGameOver() {
        self.isGameEnded = true
        self.getTriggeredsByGameState().forEach { $0.onGameOver() }
    }
    
    // MARK: - Physics Methods
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if [nodeA.name, nodeB.name].contains("drop") {
            self.onGameOver()
        } else if nodeA.name!.contains("Painter") {
            self.onCollision(nodeA, nodeB)
        } else {
            self.onCollision(nodeB, nodeA)
        }
    }
    
    func onCollision(_ painterNode: SKNode, _ obstacleNode: SKNode) {
        guard let painterNode = painterNode as? SKShapeNode else { fatalError() }
        guard let obstacleNode = obstacleNode as? SKShapeNode else { fatalError() }
        let obstacle = self.obstacleSpawner.getObstacleBy(node: obstacleNode)
        
        if painterNode.fillColor == obstacleNode.fillColor {
            obstacle.onCollision(onCorrectPainter: false)
            self.onGameOver()
        } else {
            obstacle.onCollision(onCorrectPainter: true)
            self.score.incrementObstacleHighScore()
        }
    }
    
    // MARK: - Touch Callbacks
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.getTouchSensitives().forEach { $0.touchDown(atPoint: t.location(in: self)) } }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.getTouchSensitives().forEach { $0.touchUp(atPoint: t.location(in: self)) } }
    }
}
