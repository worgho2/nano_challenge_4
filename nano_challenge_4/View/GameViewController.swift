//
//  GameViewController.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var skView: SKView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var highScoreObstacleLabel: UILabel!
    @IBOutlet weak var highScoreTimeLabel: UILabel!
    
    weak var scene: GameScene?
    
    //MARK: - Class Methods
    
    private func loadScene() {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            scene.realPaused = true
            scene.scaleMode = .aspectFill
            
            scene.vc = self
            scene.gameColorPalette = GameColorPalette(generator: PaletteGenerator(baseHSV: HSV(hue: CGFloat.random(in: 0...360), saturation: CGFloat.random(in: 0.5...1), value: 1)))
            scene.backgroundColor = scene.gameColorPalette!.backgroundColor
            
            self.scene = scene
            skView.isMultipleTouchEnabled = true
            skView.presentScene(scene)
        }
    }
    
    @IBAction func onPlayButton(_ sender: Any) {
        onGameStart()
    }
    @IBAction func onPauseButton(_ sender: Any) {
        onGamePause()
        
        playButton.isHidden = false
        playButton.setTitle("Continue", for: .normal)
        pauseButton.isHidden = true
    }
    
    func onGameStart() {
        self.scene?.onGameStart()
        
        playButton.isHidden = true
        pauseButton.isHidden = false
        
        highScoreObstacleLabel.isHidden = true
        highScoreTimeLabel.isHidden = true
    }
    func onGamePause() {
        highScoreTimeLabel.text = "HighScore time: " + String(format: "%0.2f", self.scene!.score.gameScoreManager.getHighScore().time)
        highScoreObstacleLabel.text = "HighScore obstacles:  \(self.scene!.score.gameScoreManager.getHighScore().obstacle)"
        highScoreObstacleLabel.isHidden = false
        highScoreTimeLabel.isHidden = false
        self.scene?.onGamePause()
    }
    func onGameOver() {
        self.scene?.onGameOver()
        highScoreTimeLabel.text = "HighScore time: " + String(format: "%0.2f", self.scene!.score.gameScoreManager.getHighScore().time)
        highScoreObstacleLabel.text = "HighScore obstacles:  \(self.scene!.score.gameScoreManager.getHighScore().obstacle)"
        highScoreObstacleLabel.isHidden = false
        highScoreTimeLabel.isHidden = false
        loadScene()
        playButton.isHidden = false
        playButton.setTitle("Play", for: .normal)
        pauseButton.isHidden = true
    }
    
    //MARK: - View Setup
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = self.scene?.gameColorPalette?.backgroundColor
        self.skView.backgroundColor = self.scene?.gameColorPalette?.backgroundColor
        
        highScoreTimeLabel.text = "HighScore time: " + String(format: "%0.2f", self.scene!.score.gameScoreManager.getHighScore().time)
        highScoreObstacleLabel.text = "HighScore obstacles:  \(self.scene!.score.gameScoreManager.getHighScore().obstacle)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         
        playButton.setTitle("Play", for: .normal)
        pauseButton.isHidden = true
        
        loadScene()
        
        scene?.isPaused = true
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = false
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

