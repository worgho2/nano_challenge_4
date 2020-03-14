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
    var gameColorPalette: GameColorPalette?
    
    private var lastUpdate = TimeInterval(0)

    let impactFeedback = UIImpactFeedbackGenerator()
    
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
    
    var score: Score!
    var wheel: Wheel!
    var drop: Drop!
    var obstacleSpawner: ObstacleSpawner!
    var gameSpeedManager: GameSpeedManager!
    
    //MARK: - Class Methods
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.score = Score(scene: self, manager: GameScoreManager())
        self.wheel = Wheel(scene: self)
        self.drop = Drop(scene: self)
        self.obstacleSpawner = ObstacleSpawner(scene: self)
        self.gameSpeedManager = GameSpeedManager()
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
            self.wheel
        ]
    }
    private func getUpdatables() -> [Updateable] {
        return [
            self.score,
            self.wheel,
            self.obstacleSpawner,
            self.gameSpeedManager,
            self.vc!
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
    
    private func onGameStart() {
        self.isGameEnded = false
        self.getTriggeredsByGameState().forEach { $0.onGameStart() }
    }
    
    private func onGamePause() {
        self.getTriggeredsByGameState().forEach { $0.onGamePause() }
    }
    
    private func onGameContinue() {
        self.getTriggeredsByGameState().forEach { $0.onGameContinue() }
    }
    
    private func onGameOver() {
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
        guard let obstacleNode = obstacleNode as? SKSpriteNode else { fatalError() }
        let obstacle = self.obstacleSpawner.getObstacleBy(node: obstacleNode)
        
        if painterNode.fillColor == obstacleNode.color {
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
