//
//  Score.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class Score: GameObject {
    
    var gameScoreManager: GameScoreManager!
    
    private var currentTimeHighScore: TimeInterval!
    private var currentObstacleHighScore: Int!
    
    private var timeHighScoreNode: SKLabelNode!
    private var obstacleHighScoreNode: SKLabelNode!
    
    init(scene: GameScene?, manager: GameScoreManager) {
        let node = scene?.childNode(withName: "scoreNode")!
        node?.position = CGPoint(x: 0, y: 310)
        node?.alpha = 0
        super.init(node: node, scene: scene)
        
        self.gameScoreManager = manager
        
        self.setupHighScoreNodes()
        self.setupCurrentHighScores()
    }
    
    //MARK: - Class Methods
    
    private func setupHighScoreNodes() {
        self.timeHighScoreNode = SKLabelNode(text: "Time: 0.00s")
        
        timeHighScoreNode.name = "timeHighScore"
        timeHighScoreNode.fontColor = .black
        timeHighScoreNode.fontName = "SF-mono-regular"
        timeHighScoreNode.fontSize = 20
        timeHighScoreNode.horizontalAlignmentMode = .left
        timeHighScoreNode.verticalAlignmentMode = .center
        timeHighScoreNode.position = CGPoint(x: self.scene.getBounds().minX + timeHighScoreNode.frame.width/2, y: 0)
        timeHighScoreNode.zPosition = 1
        
        self.obstacleHighScoreNode = SKLabelNode(text: "Blocks: 0s")
        
        obstacleHighScoreNode.name = "timeHighScore"
        obstacleHighScoreNode.fontColor = .black
        obstacleHighScoreNode.fontName = "SF-Mono-Regular"
        obstacleHighScoreNode.fontSize = 20
        obstacleHighScoreNode.horizontalAlignmentMode = .left
        obstacleHighScoreNode.verticalAlignmentMode = .center
        obstacleHighScoreNode.position = CGPoint(x: self.scene.getBounds().minX + timeHighScoreNode.frame.width/2, y: -30)
        obstacleHighScoreNode.zPosition = 1
        
        self.node.addChild(timeHighScoreNode)
        self.node.addChild(obstacleHighScoreNode)
    }
    
    private func setupCurrentHighScores() {
        self.currentTimeHighScore = 0
        self.currentObstacleHighScore = 0
    }
    
    func incrementTimeHighScore(by: TimeInterval = 1) {
        self.currentTimeHighScore += by
    }
    
    func incrementObstacleHighScore(by: Int = 1) {
        self.currentObstacleHighScore += by
    }
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        self.incrementTimeHighScore(by: deltaTime)
        
        self.timeHighScoreNode.text = "Time: \(self.currentTimeHighScore.asString())s"
        self.obstacleHighScoreNode.text = "Blocks: \(self.currentObstacleHighScore.asString())"
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameStart() {
        self.node.run(.fadeIn(withDuration: 0.4))
        self.setupCurrentHighScores()
    }
    
    override func onGameOver() {
        self.node.run(.fadeOut(withDuration: 0.4))
        self.gameScoreManager.setHighScore(newTimeHighScore: self.currentTimeHighScore, newObstacleHighScore: self.currentObstacleHighScore)
    }
}
