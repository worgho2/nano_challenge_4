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
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.curveEaseOut], animations: {
            self.logoImage.alpha = 0
            self.backgroundImage.alpha = 0
        }) { (_) in
            self.backgroundImage.stopAnimating()
            self.logoImage.stopAnimating()
            
            self.performSegue(withIdentifier: "segueGame", sender: nil)
        }
    }
    
    func animateLogo() {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
            self.logoImage.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
            self.logoImage.alpha = 1
            self.backgroundImage.alpha = 1
        }){ (success: Bool) in
            self.readyToStart()
        }
    }
    
    func animateBackground() {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
            self.backgroundImage.alpha = 1
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GameCenterSingleton.instance.authenticate(origin: self)
        
        self.animateLogo()
    }
    
    func setupView() {
        self.logoImage.alpha = 0
        self.backgroundImage.alpha = 0.3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}