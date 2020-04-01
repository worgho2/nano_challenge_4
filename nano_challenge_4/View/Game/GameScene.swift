//
//  GameScene.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
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
    
    var vc: GameViewController?
    var gameManager: GameManager!
    
    var onboarding: Onboarding!
    var wheel: Wheel!
    var drop: Drop!
    
    var obstacleSpawner: ObstacleSpawner!
    var powerUpSpawner: PowerUpSpawner!
    var backgroundPatternBlockSpawner: BackgroundPatternBlockSpawner!
    
    //MARK: - Class Methods
    
    override func didMove(to view: SKView) {
        self.gameManager = GameManager(score: GameScoreManager(interfaceDelegate: self.vc!),
                                       color: GameColorManager(),
                                       speed: GameSpeedManager(),
                                       audio: GameAudioManager(),
                                       haptic: GameHapticManager(),
                                       onboarding: GameOnboardingManager()
        )
        
        self.onboarding = Onboarding(scene: self)
        self.wheel = Wheel(scene: self)
        self.drop = Drop(scene: self)
        
        self.powerUpSpawner = PowerUpSpawner(scene: self)
        self.obstacleSpawner = ObstacleSpawner(scene: self)
        self.backgroundPatternBlockSpawner = BackgroundPatternBlockSpawner(scene: self)
        
        self.backgroundColor = gameManager.color.pallete.background
        self.physicsWorld.contactDelegate = self
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
            self.vc!,
            self.onboarding,
            self.wheel,
            self.drop,
            self.gameManager.score,
            self.gameManager.speed,
            self.obstacleSpawner,
            self.powerUpSpawner
        ]
    }
    
    private func getTouchSensitives() -> [TouchSensitive] {
        return [
            self.onboarding,
            self.wheel
        ]
    }
    
    private func getUpdatables() -> [Updateable] {
        return [
            self.onboarding,
            self.wheel,
            self.gameManager.score,
            self.gameManager.speed,
            self.obstacleSpawner,
            self.powerUpSpawner,
            self.backgroundPatternBlockSpawner,
            
        ]
    }
    
    func play() {
        self.realPaused = false
        self.onGameStart()
    }
    
    func pause(isGamePaused: Bool) {
        
        if isGamePaused {
            self.realPaused = false
            self.onGameContinue()
        } else {
            self.realPaused = true
            self.onGamePause()
        }
        
    }
    
    func onGameStart() {
        self.isGameEnded = false
        gameManager.audio.play(soundEffect: .play)
        self.getTriggeredsByGameState().forEach { $0.onGameStart() }
    }
    
    private func onGamePause() {
        gameManager.audio.pause()
        self.getTriggeredsByGameState().forEach { $0.onGamePause() }
    }
    
    private func onGameContinue() {
        self.getTriggeredsByGameState().forEach { $0.onGameContinue() }
    }
    
    func onGameOver() {
        self.isGameEnded = true
        gameManager.audio.stopCurrentSongs()
        self.getTriggeredsByGameState().forEach { $0.onGameOver() }
    }
    
    // MARK: - Touch Callbacks
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.getTouchSensitives().forEach { $0.touchDown(atPoint: t.location(in: self)) } }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.getTouchSensitives().forEach { $0.touchUp(atPoint: t.location(in: self)) } }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {

        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if [nodeA.name, nodeB.name].contains("drop") {
            self.onGameOver()
        } else if nodeA.name!.contains("Painter") {
            let obstacleContactPoint = self.scene?.convert(contact.contactPoint, to: nodeB)
            self.onCollision(nodeA, nodeB, at: obstacleContactPoint!)
        } else {
            let obstacleContactPoint = self.scene?.convert(contact.contactPoint, to: nodeA)
            self.onCollision(nodeB, nodeA, at: obstacleContactPoint!)
        }
    }
    
    private func onCollision(_ painterNode: SKNode, _ obstacleNode: SKNode, at: CGPoint) {
        guard let painterNode = painterNode as? SKShapeNode else { fatalError() }
        guard let obstacleNode = obstacleNode as? SKShapeNode else { fatalError() }
        let obstacle = self.obstacleSpawner.getObstacleBy(node: obstacleNode)
        
        if painterNode.fillColor == obstacleNode.fillColor {
            obstacle.onCollision(onCorrectPainter: false, at: at)
            self.onGameOver()
        } else {
            obstacle.onCollision(onCorrectPainter: true, at: at)
            gameManager.score.incrementScore()
        }
    }
}
