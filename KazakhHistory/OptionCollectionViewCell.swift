//
//  OptionCollectionViewCell.swift
//  KazakhHistory
//
//  Created by Zhanserik on 5/22/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import Foundation
import UIKit
import Cartography
import Sugar
import Reusable

class OptionCollectionViewCell: UICollectionViewCell, Reusable {
    
    let titleLabel = UILabel().then{
        $0.textAlignment = .Center
        $0.textColor = .whiteColor()
        $0.font = UIFont.boldSystemFontOfSize(20)
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews(){
        contentView.addSubviews(titleLabel)
        setupLayouts()
    }
    func setupLayouts(){
        constrain(titleLabel){
            $0.width == $0.superview!.width - 30
            $0.height == $0.superview!.height
            $0.center == $0.superview!.center
        }
    }
}