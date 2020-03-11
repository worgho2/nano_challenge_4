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
        node?.position = CGPoint(x: 0, y: 400)
        super.init(node: node, scene: scene)
        
        self.currentTimeHighScore = 0.0
        self.currentObstacleHighScore = 0
        
        self.gameScoreManager = manager
        self.setupScores()
    }
    
    //MARK: - Class Methods
    
    private func setupScores() {
        self.timeHighScoreNode = SKLabelNode(text: String(format: "%.02f", self.gameScoreManager.getHighScore().time))
        
        timeHighScoreNode.name = "timeHighScore"
        timeHighScoreNode.position = CGPoint(x: -120, y: 0)
        timeHighScoreNode.fontColor = .black
        timeHighScoreNode.zPosition = 1
        
        self.obstacleHighScoreNode = SKLabelNode(text: self.gameScoreManager.getHighScore().obstacle.asString())
        
        obstacleHighScoreNode.name = "timeHighScore"
        obstacleHighScoreNode.position = CGPoint(x: 120, y: 0)
        obstacleHighScoreNode.fontColor = .black
        obstacleHighScoreNode.zPosition = 1
        
        self.node.addChild(timeHighScoreNode)
        self.node.addChild(obstacleHighScoreNode)
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
        
        self.timeHighScoreNode.text = String(format: "%.02f", self.currentTimeHighScore)
        self.obstacleHighScoreNode.text = self.currentObstacleHighScore.asString()
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameStart() {
        self.node.run(.move(to: CGPoint(x: 0, y: 310), duration: 0.2))
        self.currentTimeHighScore = 0
        self.currentObstacleHighScore = 0
    }
    override func onGameOver() {
        self.node.run(.move(to: CGPoint(x: 0, y: 400), duration: 0.2))
        self.gameScoreManager.setHighScore(newTimeHighScore: self.currentTimeHighScore, newObstacleHighScore: self.currentObstacleHighScore)
    }
}
