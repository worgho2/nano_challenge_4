//
//  Score.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class Score: GameObject {
    
    var gameOnboardingManager: GameOnboardingManager!
    var gameScoreManager: GameScoreManager!
    
    private var currentTimeHighScore: TimeInterval!
    private var currentObstacleHighScore: Int!
    
    private var timeHighScoreNode: SKLabelNode!
    private var obstacleHighScoreNode: SKLabelNode!
    
    private var timeHighScoreDefaultNode: SKLabelNode!
    private var obstacleHighScoreDefaultNode: SKLabelNode!
    
    init(scene: SKScene?, gameScoreManager: GameScoreManager, gameOnboardingManager: GameOnboardingManager) {
        let node = scene?.childNode(withName: "scoreNode")!
        node?.position = CGPoint(x: 0, y: 310)
        node?.alpha = 0
        super.init(node: node, scene: scene)
        
        self.gameScoreManager = gameScoreManager
        self.gameOnboardingManager = gameOnboardingManager
        
        self.setupHighScoreNodes()
        self.setupCurrentHighScores()
    }
    
    //MARK: - Class Methods
    
    private func setupHighScoreNodes() {
        self.timeHighScoreDefaultNode = SKLabelNode(text: "Time")
        timeHighScoreDefaultNode.name = "timeHighScoreDefault"
        timeHighScoreDefaultNode.fontColor = .white
        timeHighScoreDefaultNode.fontSize = 17
        timeHighScoreDefaultNode.fontName = "SF-Pro-Rounded-Light"
        timeHighScoreDefaultNode.horizontalAlignmentMode = .left
        timeHighScoreDefaultNode.verticalAlignmentMode = .center
        timeHighScoreDefaultNode.position = CGPoint(x: self.scene.getBounds().minX + timeHighScoreDefaultNode.frame.width/2 + 30, y: 0)
        timeHighScoreDefaultNode.zPosition = 2
        
        self.timeHighScoreNode = SKLabelNode(text: "0.00s")
        timeHighScoreNode.name = "timeHighScore"
        timeHighScoreNode.fontColor = .white
        timeHighScoreNode.fontSize = 20
        timeHighScoreNode.fontName = "SF-Pro-Rounded-Medium"
        timeHighScoreNode.horizontalAlignmentMode = .left
        timeHighScoreNode.verticalAlignmentMode = .center
        timeHighScoreNode.position = CGPoint(x: self.scene.getBounds().minX + timeHighScoreNode.frame.width/2 + 20, y: -25)
        timeHighScoreNode.zPosition = 2
        
        self.obstacleHighScoreDefaultNode = SKLabelNode(text: "Score")
        obstacleHighScoreDefaultNode.name = "ObstacleScoreDefault"
        obstacleHighScoreDefaultNode.fontColor = .white
        obstacleHighScoreDefaultNode.fontSize = 17
        obstacleHighScoreDefaultNode.fontName = "SF-Pro-Rounded-Light"
        obstacleHighScoreDefaultNode.horizontalAlignmentMode = .left
        obstacleHighScoreDefaultNode.verticalAlignmentMode = .center
        obstacleHighScoreDefaultNode.position = CGPoint(x: self.scene.getBounds().minX + obstacleHighScoreDefaultNode.frame.width/2 + 30, y: -55)
        obstacleHighScoreDefaultNode.zPosition = 2
        
        self.obstacleHighScoreNode = SKLabelNode(text: "00")
        obstacleHighScoreNode.name = "ObstacleScore"
        obstacleHighScoreNode.fontColor = .white
        obstacleHighScoreNode.fontSize = 20
        obstacleHighScoreNode.fontName = "SF-Pro-Rounded-Medium"
        obstacleHighScoreNode.horizontalAlignmentMode = .left
        obstacleHighScoreNode.verticalAlignmentMode = .center
        obstacleHighScoreNode.position = CGPoint(x: self.scene.getBounds().minX + timeHighScoreNode.frame.width/2 + 20, y: -75)
        obstacleHighScoreNode.zPosition = 2
        
        self.node.addChild(timeHighScoreDefaultNode)
        self.node.addChild(obstacleHighScoreDefaultNode)
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
        
        self.timeHighScoreNode.text = "\(self.currentTimeHighScore.asString())s"
        self.obstacleHighScoreNode.text = "\(self.currentObstacleHighScore.asString())"
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameStart() {
        if !gameOnboardingManager.onboardingIsNeeded() {
            self.node.run(.fadeIn(withDuration: 0.4))
            self.setupCurrentHighScores()
        }
    }
    
    override func onGameOver() {
        self.node.run(.fadeOut(withDuration: 0.4))
        self.gameScoreManager.setHighScore(newTimeHighScore: self.currentTimeHighScore, newObstacleHighScore: self.currentObstacleHighScore)
    }
}
