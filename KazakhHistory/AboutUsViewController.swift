//
//  SettingsViewController.swift
//  KazakhHistory
//
//  Created by Zhanserik on 5/23/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Sugar
import SwiftRandom
import Cartography

class AboutUsViewController: UIViewController {
    
    let backgroundImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .ScaleAspectFill
    }
    let backgroundOverlayView = UIView().then{
        $0.backgroundColor = .blackColor()
        $0.alpha = 0.5
    }
    
    let logoImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .ScaleAspectFit
        $0.image = UIImage(named: "logo.png")
    }
    let infoLabel = UILabel().then{
        $0.textAlignment = .Center
        $0.textColor = .appTintColor()
        $0.font = UIFont.boldSystemFontOfSize(20)
        $0.numberOfLines = 0
    }
    
    func setupViews(){
        [backgroundImageView, backgroundOverlayView, logoImageView, infoLabel].forEach{
            view.addSubview($0)
        }
        backgroundImageView.image = UIImage(named: "batyr.JPG")
        
        infoLabel.text = "Student IITU 2016\n+7(701)777-7777\nKazakh History\nkazakh-history.kz"
        
        title = "About us"

    }
    func setupLayouts(){
        constrain(backgroundImageView){
            $0.size == $0.superview!.size
            $0.center == $0.superview!.center
        }
        constrain(backgroundOverlayView){
            $0.size == $0.superview!.size
            $0.center == $0.superview!.center
        }
        constrain(logoImageView){
            $0.width == 200
            $0.height == 200
            $0.centerX == $0.superview!.centerX
            $0.top == $0.superview!.top + 100
        }
        constrain(infoLabel, logoImageView){
            $0.top == $1.bottom + 20
            $0.left == $0.superview!.left + 40
            $0.right == $0.superview!.right - 40
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    func cancelButtonDidPress(){
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
