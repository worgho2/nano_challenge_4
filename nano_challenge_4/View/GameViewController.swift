//
//  GameViewController.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, TriggeredByGameState, Updateable {
    
    @IBOutlet weak var skView: SKView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var highScoreObstacleLabel: UILabel!
    @IBOutlet weak var highScoreTimeLabel: UILabel!
    
    @IBOutlet weak var highScoreDefaultLabel: UILabel!
    @IBOutlet weak var bestTimeDefaultLabel: UILabel!
    
    
    weak var scene: GameScene?
    
    var backgroundView: UIView!
    var viewPattern: UIView!
    
    private var isGamePaused: Bool = false
    
    //MARK: - Class Methods
    
    @IBAction func onPlayButton(_ sender: Any) {
        self.scene?.play(isGamePaused: self.isGamePaused)
    }
    
    @IBAction func onPauseButton(_ sender: Any) {
        self.scene?.pause()
    }
    
    private func loadGame() {
        self.setupBackground()
        self.loadScene()
        self.setupView()
    }
    
    private func loadScene() {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            let randomHue = CGFloat.random(in: 0...360)
            let randomSaturation = CGFloat.random(in: 0.5...1)
            let randomValue = CGFloat.random(in: 0.5...1)
            print("[COLOR GENERATION]: (HUE: \(randomHue) - SATURATION: \(randomSaturation) - VALUE: \(randomValue)")
            
            scene.realPaused = true
            scene.scaleMode = .aspectFill
            scene.vc = self
            scene.backgroundColor = .clear
            
            backgroundView.backgroundColor = scene.gameColorManager.backgroundColor
            viewPattern.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 10)
            let image = UIImage(named: "background")!.tint(tintColor: scene.gameColorManager.pattern).resizeImage(size: CGSize(width: view.frame.width/2, height: view.frame.width/2))!
            viewPattern.backgroundColor = UIColor(patternImage: image)
            
            self.scene = scene
            
            let colorTop =  UIColor.clear.cgColor
            let colorBottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor

            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = skView.bounds

            skView.layer.insertSublayer(gradientLayer, at: 0)
            skView.backgroundColor = .clear
//            skView.showsPhysics = true
            skView.isMultipleTouchEnabled = true
            skView.presentScene(scene)
        }
    }
    
    private func setupBackground() {
        backgroundView = UIView(frame: view.frame)
        view.addSubview(backgroundView)
        
        viewPattern = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 10))
        viewPattern.alpha = 0.4
        view.addSubview(viewPattern)
        
        view.sendSubviewToBack(viewPattern)
        view.sendSubviewToBack(backgroundView)
    }
    
    private func setupView() {
        self.playButton.isHidden = false
        self.highScoreTimeLabel.isHidden = false
        self.highScoreObstacleLabel.isHidden = false
        self.pauseButton.isHidden = true
        self.highScoreDefaultLabel.isHidden = false
        self.bestTimeDefaultLabel.isHidden = false
        
        self.playButton.titleLabel?.textColor = .white
        self.playButton.tintColor = .white
        self.highScoreTimeLabel.textColor = .white
        self.highScoreObstacleLabel.textColor = .white
        self.pauseButton.titleLabel?.textColor = .white
        
        self.playButton.setTitle("Play", for: .normal)
        self.highScoreTimeLabel.text = "\(String(format: "%0.2f", (self.scene?.score.gameScoreManager.getHighScore().time)!))s"
        self.highScoreObstacleLabel.text = "\(self.scene!.score.gameScoreManager.getHighScore().obstacle)"

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadGame()
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
    
    //MARK: - Updateable PROTOCOL
    
    func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * self.scene!.gameSpeedManager.getCurrentSpeed()
        self.viewPattern.center.y -= dY
        
        guard let frame = view?.frame else { return }
        
        if self.viewPattern.center.y <= 0 {
            self.viewPattern.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 10)
        }
    }
    
    //MARK: - TriggeredByGameState PROTOCOL (AJUSTAR PARA NOVA LÓGICA)
    
    func onGameStart() {
        self.playButton.isHidden = true
        self.pauseButton.isHidden = false
        self.highScoreObstacleLabel.isHidden = true
        self.highScoreTimeLabel.isHidden = true
        self.highScoreDefaultLabel.isHidden = true
        self.bestTimeDefaultLabel.isHidden = true
        
        self.playButton.setTitle("Continue", for: .normal)
    }
    
    func onGamePause() {
        self.isGamePaused = true
        
        self.playButton.isHidden = false
        self.pauseButton.isHidden = true
        self.highScoreObstacleLabel.isHidden = true
        self.highScoreTimeLabel.isHidden = true
        self.highScoreDefaultLabel.isHidden = true
        self.bestTimeDefaultLabel.isHidden = true
    }
    
    func onGameContinue() {
        self.isGamePaused = false
        
        self.playButton.isHidden = true
        self.pauseButton.isHidden = false
        self.highScoreObstacleLabel.isHidden = true
        self.highScoreTimeLabel.isHidden = true
        self.highScoreDefaultLabel.isHidden = true
        self.bestTimeDefaultLabel.isHidden = true
    }
    
    func onGameOver() {
        self.playButton.setTitle("Play", for: .normal)
        self.highScoreTimeLabel.text = "\(String(format: "%0.2f", self.scene!.score.gameScoreManager.getHighScore().time))s"
        self.highScoreObstacleLabel.text = "\(self.scene!.score.gameScoreManager.getHighScore().obstacle)"
        
        self.playButton.isHidden = false
        self.pauseButton.isHidden = true
        self.highScoreObstacleLabel.isHidden = false
        self.highScoreTimeLabel.isHidden = false
        self.highScoreDefaultLabel.isHidden = false
        self.bestTimeDefaultLabel.isHidden = false
    }
}

