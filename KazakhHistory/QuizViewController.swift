//
//  QuizViewController.swift
//  KazakhHistory
//
//  Created by Zhanserik on 5/22/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Reusable
import SwiftRandom
import Cartography
import CircleSlider

class QuizViewController: UIViewController {
    
    let questionLabel = UILabel().then{
        $0.textAlignment = .Center
        $0.textColor = .appTintColor()
        $0.font = UIFont.boldSystemFontOfSize(22)
        $0.numberOfLines = 0
        $0.text = Randoms.randomFakeConversation() + " " + Randoms.randomFakeConversation()
    }
    
    let layout = UICollectionViewFlowLayout().then{
        $0.minimumLineSpacing = 1
        $0.minimumInteritemSpacing = 1
        $0.scrollDirection = .Vertical
    }
    private lazy var optionCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.registerReusableCell(OptionCollectionViewCell)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    let backgroundImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .ScaleAspectFill
    }
    let backgroundOverlayView = UIView().then{
        $0.backgroundColor = .blackColor()
        $0.alpha = 0.5
    }
    let callFriendButton = UIButton().then{
        $0.backgroundColor = UIColor.clearColor()
        $0.setImage(UIImage(named:"call"), forState: .Normal)
    }
    let groupButton = UIButton().then{
        $0.backgroundColor = UIColor.clearColor()
        $0.setImage(UIImage(named:"group"), forState: .Normal)
    }
    let cutButton = UIButton().then{
        $0.backgroundColor = UIColor.clearColor()
        $0.setImage(UIImage(named:"cut"), forState: .Normal)
    }
    let cancelButton = UIButton().then{
        $0.backgroundColor = UIColor.clearColor()
        $0.setImage(UIImage(named:"cancel"), forState: .Normal)
    }
    let coinsLabel = UILabel().then{
        $0.textAlignment = .Center
        $0.textColor = .appTintColor()
        $0.font = UIFont.boldSystemFontOfSize(20)
        $0.text = "12,000"
    }
    let coinsImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .ScaleAspectFit
        $0.image = UIImage(named: "coins")
    }
    
    var containerView = UIView()
    var progressView: CircleSlider?
    let progressLabel = UILabel().then{
        $0.textAlignment = .Center
        $0.textColor = .appTintColor()
        $0.font = UIFont.boldSystemFontOfSize(20)
        $0.text = ""
    }
    private var timer: NSTimer?
    private var progressValue: Float = 0
    
    func setupViews(){
        [backgroundImageView, backgroundOverlayView].forEach{
            view.addSubview($0)
        }
        [callFriendButton, groupButton, cutButton, cancelButton, coinsLabel, coinsImageView, questionLabel].forEach{
            view.addSubviews($0)
        }
        callFriendButton.addTarget(self, action: #selector(QuizViewController.callFriendButtonDidPress), forControlEvents: .TouchUpInside)
        groupButton.addTarget(self, action: #selector(QuizViewController.groupButtonDidPress), forControlEvents: .TouchUpInside)
        cutButton.addTarget(self, action: #selector(QuizViewController.cutButtonDidPress), forControlEvents: .TouchUpInside)
        cancelButton.addTarget(self, action: #selector(QuizViewController.cancelButtonDidPress), forControlEvents: .TouchUpInside)
        backgroundImageView.image = UIImage(named: "batyr.JPG")
        view.backgroundColor = .whiteColor()
        view.addSubview(optionCollectionView)
        
        let options: [CircleSliderOption] = [
            CircleSliderOption.BarColor(UIColor.whiteColor().colorWithAlphaComponent(0.3)),
            CircleSliderOption.ThumbColor(UIColor.clearColor()),
            CircleSliderOption.TrackingColor(UIColor.appTintColor()),
            CircleSliderOption.BarWidth(20),
            CircleSliderOption.StartAngle(-90),
            CircleSliderOption.MaxValue(20),
            CircleSliderOption.MinValue(0)
        ]
        
        containerView.frame = CGRect(x: view.width * 0.2, y: 80, width: view.width * 0.6, height: view.width * 0.6)
        let frame = CGRect(x: 0, y: 0, width: view.width * 0.6, height: view.width * 0.6)
        progressLabel.frame = frame
        progressView = CircleSlider(frame: frame, options: options)
        progressView?.addSubview(progressLabel)
        containerView.addSubview(progressView!)
        view.addSubview(containerView)
        
        if self.timer == nil {
//            self.progressValue = 0
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(QuizViewController.fire(_:)), userInfo: nil, repeats: true)
        }
    }
    func setupLayouts(){
        layout.itemSize = CGSize(width: view.width / 2 - 3, height: 70)
        layout.sectionInset = UIEdgeInsetsMake(1, 1, 2, 2)
        constrain(optionCollectionView){
            $0.height == 140
            $0.bottom == $0.superview!.bottom
            $0.left == $0.superview!.left + 1
            $0.right == $0.superview!.right - 1
        }
        constrain(questionLabel, optionCollectionView){
            $0.height == 140
            $0.bottom == $1.top
            $0.left == $0.superview!.left + 15
            $0.right == $0.superview!.right - 15
        }
        constrain(backgroundImageView){
            $0.size == $0.superview!.size
            $0.center == $0.superview!.center
        }
        constrain(backgroundOverlayView){
            $0.size == $0.superview!.size
            $0.center == $0.superview!.center
        }
        constrain(callFriendButton){
            $0.width == 50
            $0.height == 50
            $0.top == $0.superview!.top + 10
            $0.right == $0.superview!.right - 10
        }
        constrain(groupButton, callFriendButton){
            $0.width == 50
            $0.height == 50
            $0.top == $1.bottom
            $0.right == $0.superview!.right - 10
        }
        constrain(cutButton, groupButton){
            $0.width == 50
            $0.height == 50
            $0.top == $1.bottom
            $0.right == $0.superview!.right - 10
        }
        constrain(cancelButton){
            $0.width == 50
            $0.height == 50
            $0.top == $0.superview!.top + 10
            $0.left == $0.superview!.left + 10
        }
        constrain(coinsLabel){
            $0.height == 50
            $0.top == $0.superview!.top + 10
            $0.centerX == $0.superview!.centerX
        }
        constrain(coinsImageView, coinsLabel){
            $0.height == 24
            $0.width == 24
            $0.left == $1.right + 5
            $0.centerY == $1.centerY
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    func callFriendButtonDidPress() {
        
    }
    func groupButtonDidPress(){
        
    }
    func cutButtonDidPress(){
        for i in 0...1{
            let correctCell = optionCollectionView.cellForItemAtIndexPath(NSIndexPath(forRow: i*3, inSection: 0))
            correctCell?.hidden = true
        }
    }
    func cancelButtonDidPress(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    func fire(timer: NSTimer) {
        self.progressValue += 1.0
        if self.progressValue > 20 {
            self.timer?.invalidate()
            self.timer = nil
            self.progressValue = 0
        }
        self.progressView!.value = self.progressValue
        var numbers = "\(20 - self.progressValue)".componentsSeparatedByString(".")
        progressLabel.text = numbers[0]
    }
    
}
extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as OptionCollectionViewCell
        let letters = ["A", "B", "C", "D"]
        cell.contentView.backgroundColor = UIColor.appTintColor()
        cell.titleLabel.text = "\(letters[indexPath.row % letters.count]). \(Randoms.randomFakeName())"
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 2){
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
            cell?.contentView.backgroundColor = UIColor.turquoiseColor()
        }
        else{
            let correctCell = collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))
            correctCell?.contentView.backgroundColor = UIColor.turquoiseColor()
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
            cell?.contentView.backgroundColor = UIColor.pomegranateColor()
        }
    }
}