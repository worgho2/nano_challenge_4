//
//  Onboarding.swift
//  nano_challenge_4
//
//  Created by otavio on 17/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//
import SpriteKit

class Onboarding: GameObject {
    
    private var gameOnboardingManager: GameOnboardingManager!
    private var gameColorManager: GameColorManager!

    init(scene: SKScene?, gameOnboardingManager: GameOnboardingManager, gameColorManager: GameColorManager) {
        let node = scene?.childNode(withName: "onboardingNode")!
        super.init(node: node, scene: scene)
        
        self.gameOnboardingManager = gameOnboardingManager
        self.gameColorManager = gameColorManager
    }
    
    //MARK: - Class Methods
    
    private func setupToNextStage() {
        self.node.children.forEach{ $0.removeFromParent() }
    }
    
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        if !gameOnboardingManager.isStageDone(.first) && gameOnboardingManager.canShowFirst {
            
            gameOnboardingManager.canShowFirst = false
            onFirstStep()
            print("[ONBOARDING] - SHOWING FIRST STAGE")
            
        } else if !gameOnboardingManager.isStageDone(.second) && gameOnboardingManager.canShowSecond {
            
            gameOnboardingManager.canShowSecond = false
            onSecondStep()
            print("[ONBOARDING] - SHOWING SECOND STAGE")
            
        } else if !gameOnboardingManager.isStageDone(.third) && gameOnboardingManager.canShowThird {
            
            gameOnboardingManager.canShowThird = false
            onThirdStep()
            print("[ONBOARDING] - SHOWING THIRD STAGE")
        }
    }
    
    
    //MARK: - OnboardingDisplayable PROTOCOL
    
    override func onFirstStep() {
        self.setupToNextStage()
        
        let descriptionNode = SKLabelNode(text: "Use one thumb at a time to rotate the colors")
        
        descriptionNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        descriptionNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        descriptionNode.name = "firstStageDescription"
        descriptionNode.preferredMaxLayoutWidth = self.scene.getBounds().width * 2 * 0.75
        descriptionNode.numberOfLines = 3
        descriptionNode.fontColor = .white
        descriptionNode.fontSize = 25
        descriptionNode.fontName = "SF-Pro-Rounded-Light"
        descriptionNode.position = CGPoint(x: 0, y: 70)
        descriptionNode.zPosition = 1
        descriptionNode.alpha = 0
        
        let touchNode = SKShapeNode(circleOfRadius: 20)
        touchNode.name = "firstStageTouch"
        touchNode.fillColor = .white
        touchNode.strokeColor = .clear
        touchNode.position = CGPoint(x: 100, y: -100)
        touchNode.zPosition = 0
        touchNode.alpha = 0
        
        let arcNode = SKShapeNode(circleOfRadius: 25)
        arcNode.name = "firstStageArc"
        arcNode.fillColor = .clear
        arcNode.strokeColor = .white
        arcNode.lineWidth = 3
        arcNode.position = CGPoint(x: 0, y: 0)
        arcNode.zPosition = -1
        arcNode.alpha = 1
        
        self.node.addChild(descriptionNode)
        touchNode.addChild(arcNode)
        self.node.addChild(touchNode)
        
        descriptionNode.run(.fadeIn(withDuration: 1))
        touchNode.run(.repeatForever(.sequence([
            .fadeIn(withDuration: 1),
            .fadeOut(withDuration: 1)
        ])))
    }
    
    override func onSecondStep() {
        self.setupToNextStage()
        
        let descriptionNode = SKLabelNode(text: "Use one thumb at a time to rotate the colors")
        
        descriptionNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        descriptionNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        descriptionNode.name = "secondStageDescription"
        descriptionNode.preferredMaxLayoutWidth = self.scene.getBounds().width * 2 * 0.75
        descriptionNode.numberOfLines = 3
        descriptionNode.fontColor = .white
        descriptionNode.fontSize = 25
        descriptionNode.fontName = "SF-Pro-Rounded-Light"
        descriptionNode.position = CGPoint(x: 0, y: 70)
        descriptionNode.zPosition = 1
        descriptionNode.alpha = 0
        
        let touchNode = SKShapeNode(circleOfRadius: 20)
        touchNode.name = "secondStageTouch"
        touchNode.fillColor = .white
        touchNode.strokeColor = .clear
        touchNode.position = CGPoint(x: -100, y: -100)
        touchNode.zPosition = 0
        touchNode.alpha = 0
        
        let arcNode = SKShapeNode(circleOfRadius: 25)
        arcNode.name = "secondStageArc"
        arcNode.fillColor = .clear
        arcNode.strokeColor = .white
        arcNode.lineWidth = 3
        arcNode.position = CGPoint(x: 0, y: 0)
        arcNode.zPosition = -1
        arcNode.alpha = 1
        
        self.node.addChild(descriptionNode)
        touchNode.addChild(arcNode)
        self.node.addChild(touchNode)
        
        descriptionNode.run(.fadeIn(withDuration: 1))
        touchNode.run(.repeatForever(.sequence([
            .fadeIn(withDuration: 1),
            .fadeOut(withDuration: 1)
        ])))
        
    }
    
    override func onThirdStep() {
        self.setupToNextStage()
        
        let startNode = SKLabelNode(text: "Start")
        startNode.name = "thirdStateStart"
        startNode.fontColor = .white
        startNode.fontSize = 49
        startNode.fontName = "SF-Pro-Rounded-Light"
        startNode.verticalAlignmentMode = .center
        startNode.horizontalAlignmentMode = .center
        startNode.position = CGPoint(x: 0, y: 300)
        startNode.zPosition = 999
        startNode.alpha = 0
        
        let descriptionNode = SKLabelNode(text: "Mix the colors to get the background color and prevent the black ink drop from touching the obstacles")
        
        descriptionNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        descriptionNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        descriptionNode.name = "thirdStageDescription"
        descriptionNode.preferredMaxLayoutWidth = self.scene.getBounds().width * 2 * 0.75
        descriptionNode.numberOfLines = 5
        descriptionNode.fontColor = .white
        descriptionNode.fontSize = 25
        descriptionNode.fontName = "SF-Pro-Rounded-Light"
        descriptionNode.position = CGPoint(x: 0, y: 70)
        descriptionNode.zPosition = 1
        descriptionNode.alpha = 0
        
        let baseNode = SKShapeNode(rectOf: CGSize(width: 200, height: 50), cornerRadius: 25)
        baseNode.name = "thirdBaseNode"
        baseNode.fillColor = .white
        baseNode.strokeColor = .white
        baseNode.position = CGPoint(x: 0, y: -40)
        baseNode.zPosition = 0
        
        let leftNode = SKShapeNode(circleOfRadius: 20)
        leftNode.name = "thirdLeftNode"
        leftNode.fillColor = self.gameColorManager.leftColor
        leftNode.strokeColor = .clear
        leftNode.position = CGPoint(x: -75, y: 0)
        leftNode.zPosition = 1
        baseNode.addChild(leftNode)
        
        let plusNode = SKLabelNode(text: "+")
        plusNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        plusNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        plusNode.name = "thirdPlus"
        plusNode.fontColor = .black
        plusNode.fontSize = 25
        plusNode.fontName = "SF-Pro-Rounded-Light"
        plusNode.position = CGPoint(x: -37, y: 0)
        plusNode.zPosition = 2
        baseNode.addChild(plusNode)
        
        let rightNode = SKShapeNode(circleOfRadius: 20)
        rightNode.name = "thirdRightNode"
        rightNode.fillColor = self.gameColorManager.rightColor
        rightNode.strokeColor = .clear
        rightNode.position = CGPoint(x: 0, y: 0)
        rightNode.zPosition = 1
        baseNode.addChild(rightNode)
        
        let equalNode = SKLabelNode(text: "=")
        equalNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        equalNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        equalNode.name = "thirdEqual"
        equalNode.fontColor = .black
        equalNode.fontSize = 25
        equalNode.fontName = "SF-Pro-Rounded-Light"
        equalNode.position = CGPoint(x: 37, y: 0)
        equalNode.zPosition = 2
        baseNode.addChild(equalNode)
        
        let backgroundNode = SKShapeNode(circleOfRadius: 20)
        backgroundNode.name = "thirdBackgroundNode"
        backgroundNode.fillColor = self.gameColorManager.backgroundColor
        backgroundNode.strokeColor = .clear
        backgroundNode.position = CGPoint(x: 75, y: 0)
        backgroundNode.zPosition = 1
        baseNode.addChild(backgroundNode)
        

        self.node.addChild(startNode)
        self.node.addChild(descriptionNode)
        self.node.addChild(baseNode)
        
        descriptionNode.run(.fadeIn(withDuration: 1))
        baseNode.run(.fadeIn(withDuration: 1))
        startNode.run(.repeatForever(.sequence([
            .fadeIn(withDuration: 1),
            .fadeOut(withDuration: 1)
        ])))
    }
    
    //MARK: - TouchSensitive PROTOCOL
    
    override func touchDown(atPoint pos: CGPoint) {
        
        if pos.y > 0  && self.gameOnboardingManager.isStageDone(.first) && self.gameOnboardingManager.isStageDone(.second) && !self.gameOnboardingManager.isStageDone(.third) {
            gameOnboardingManager.setStageDone(.third)
            self.setupToNextStage()
            if let scene = self.scene as? GameScene {
                scene.onGameOver()
                scene.onGameStart()
            }
            
        }
    }
    
}