//
//  LeaderboardViewController.swift
//  KazakhHistory
//
//  Created by Zhanserik on 5/23/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Sugar
import SwiftRandom
import Cartography

class LeaderboardViewController: UIViewController {
    
    let backgroundImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .ScaleAspectFill
    }
    let backgroundOverlayView = UIView().then{
        $0.backgroundColor = .blackColor()
        $0.alpha = 0.5
    }
    let tableView = UITableView().then {
        $0.backgroundColor = .clearColor()
        $0.separatorColor = UIColor.appTintColor()
    }
    let headerView = UIView().then {
        $0.backgroundColor = .clearColor()
    }

    let segmentedControl = UISegmentedControl().then {
        $0.tintColor = UIColor.appTintColor()
        $0.insertSegmentWithTitle("Global", atIndex: 0, animated: false)
        $0.insertSegmentWithTitle("Local", atIndex: 1, animated: false)
        $0.selectedSegmentIndex = 0
    }
    func setupViews(){
        [backgroundImageView, backgroundOverlayView].forEach{
            view.addSubview($0)
        }
        backgroundImageView.image = UIImage(named: "batyr.JPG")
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        headerView.addSubview(segmentedControl)
        tableView.tableHeaderView = headerView
        title = "Leaderboard"
        
        let cancelButton = UIBarButtonItem()
        cancelButton.title = "Back"
        cancelButton.action = #selector(LeaderboardViewController.cancelButtonDidPress)
        cancelButton.target = self
        navigationItem.leftBarButtonItem = cancelButton
        
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
        constrain(tableView){
            $0.width == $0.superview!.width
            $0.height == $0.superview!.height - 44
            $0.top == $0.superview!.top + 64
        }
        constrain(segmentedControl){
            $0.width == 140
            $0.height == 29
            $0.center == $0.superview!.center
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
extension LeaderboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cellIdentifer"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) //as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = Randoms.randomFakeName()
        cell?.detailTextLabel?.text = "\(Randoms.randomInt(1000, 25000))"
        cell?.textLabel?.textColor = UIColor.appTintColor()
        cell?.detailTextLabel?.textColor = UIColor.appTintColor()
        cell?.detailTextLabel?.textAlignment = .Right
        cell?.backgroundColor = UIColor.clearColor()
        cell?.contentView.backgroundColor = UIColor.clearColor()
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}