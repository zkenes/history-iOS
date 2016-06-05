//
//  MenuViewController.swift
//  KazakhHistory
//
//  Created by Zhanserik on 5/22/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import Foundation
import UIKit
import Sugar
import Cartography

class MenuViewController: UIViewController, TimerManageable {
    
    let logoImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .ScaleAspectFit
        $0.image = UIImage(named: "logo.png")
    }
    
    let backgroundImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .ScaleAspectFill
    }
    let backgroundOverlayView = UIView().then{
        $0.backgroundColor = .blackColor()
        $0.alpha = 0.5
    }
    
    let playButton = UIButton().then{
        $0.backgroundColor = UIColor.appTintColor()
        $0.setTitle("Play", forState: .Normal)
        $0.setTitleColor(.whiteColor(), forState: .Normal)
        $0.alpha = 0.0
        $0.titleLabel!.font = UIFont.boldSystemFontOfSize(20)
    }
    let leaderBoardButton = UIButton().then{
        $0.backgroundColor = UIColor.appTintColor()
        $0.setTitle("Leaderboard", forState: .Normal)
        $0.setTitleColor(.whiteColor(), forState: .Normal)
        $0.alpha = 0.0
        $0.titleLabel!.font = UIFont.boldSystemFontOfSize(20)
    }
    let settingsButton = UIButton().then{
        $0.backgroundColor = UIColor.appTintColor()
        $0.setTitle("Settings", forState: .Normal)
        $0.setTitleColor(.whiteColor(), forState: .Normal)
        $0.alpha = 0.0
        $0.titleLabel!.font = UIFont.boldSystemFontOfSize(20)
    }
    
    func setupViews(){
        view.backgroundColor = .whiteColor()
        view.addSubviews(backgroundImageView, backgroundOverlayView, logoImageView)
        [playButton, leaderBoardButton, settingsButton].forEach{
            view.addSubviews($0)
        }
        let image = UIImage(named: "bata.png")
        backgroundImageView.image = image
        playButton.addTarget(self, action: #selector(MenuViewController.playButtonDidPress), forControlEvents: .TouchUpInside)
        leaderBoardButton.addTarget(self, action: #selector(MenuViewController.leaderboardButtonDidPress), forControlEvents: .TouchUpInside)
        settingsButton.addTarget(self, action: #selector(MenuViewController.settingsButtonDidPress), forControlEvents: .TouchUpInside)
    }
    
    func setupConstraints(){
        let image = backgroundImageView.image
        let koef = (image?.size.width)! / (image?.size.height)!
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: view.height * koef,  height: view.height)
        backgroundImageView.image = image
        backgroundOverlayView.frame = view.frame
        
        constrain(logoImageView){
            $0.width == 200
            $0.height == 200
            $0.centerX == $0.superview!.centerX
            $0.top == $0.superview!.top + 50
        }
        constrain(settingsButton){
            $0.left == $0.superview!.left + 30
            $0.right == $0.superview!.right - 30
            $0.height == 50
            $0.bottom == $0.superview!.bottom - 10
        }
        constrain(leaderBoardButton, settingsButton){
            $0.left == $0.superview!.left + 30
            $0.right == $0.superview!.right - 30
            $0.height == 50
            $0.bottom == $1.top - 10
        }
        constrain(playButton, leaderBoardButton){
            $0.left == $0.superview!.left + 30
            $0.right == $0.superview!.right - 30
            $0.height == 50
            $0.bottom == $1.top - 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        startMovingBackground(true)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        [playButton, leaderBoardButton, settingsButton].forEach{button in
            UIView.animateWithDuration(1.0, animations: {
                button.alpha = 1.0
            })
        }
    }
    func startMovingBackground(forward: Bool){
        var frame = self.backgroundImageView.frame
        frame.origin.x = forward ? -(frame.width - view.frame.width) : 0
        UIView.animateWithDuration(60.0, animations: {
            self.backgroundImageView.frame = frame
            }) { (finished) in
            self.startMovingBackground(!forward)
        }
    }
}

extension MenuViewController{
    func playButtonDidPress(){
        self.presentViewController(QuizViewController(), animated: true, completion: nil)
    }
    func leaderboardButtonDidPress(){
        let controller = UINavigationController(rootViewController: LeaderboardViewController())
        self.presentViewController(controller, animated: true, completion: nil)
    }
    func settingsButtonDidPress(){
        let controller = UINavigationController(rootViewController: SettingsViewController())
        self.presentViewController(controller, animated: true, completion: nil)
    }
}