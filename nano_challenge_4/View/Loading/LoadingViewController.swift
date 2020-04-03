//
//  LoadingViewController.swift
//  nano_challenge_4
//
//  Created by otavio on 27/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    
    func readyToStart() {
        
        UIView.animate(withDuration: 1, delay: 0.5, options: [.curveLinear], animations: {
            
            self.logoImage.alpha = 0
            self.backgroundImage.alpha = 0.8
            
        }) { (_) in
            
            self.logoImage.stopAnimating()
            self.backgroundImage.stopAnimating()
            
            self.performSegue(withIdentifier: "segueGame", sender: nil)
            
        }
    }
    
    func animateLogo() {
        self.logoImage.isHidden = false
        
        UIView.animate(withDuration: 1, delay: 0.2, options: [.curveEaseInOut], animations: {
            
            self.logoImage.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/3)
            self.logoImage.alpha = 1
            
        }){ (_) in
            
            self.readyToStart()
            
        }
    }
    
    func animateBackground() {
        UIView.animate(withDuration: 1.2, delay: 0, options: [.curveEaseOut], animations: {
            
            self.view.backgroundColor = GameColorManager.avaliablePalettes[GameColorManager.currentIndex].background
            self.backgroundImage.alpha = 1
            
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animateBackground()
        self.animateLogo()
    }
    
    func setupView() {
        self.logoImage.isHidden = true
        self.logoImage.alpha = 0
        self.backgroundImage.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
