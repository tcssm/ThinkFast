//
//  CircleView.swift
//  ThinkFast
//
//  Created by  Owen Gregson on 8/31/21.
//

import UIKit

class CircleView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    @IBInspectable var cornerRadius: CGFloat = 50.0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    

}
