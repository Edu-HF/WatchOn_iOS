//
//  UIView+Extensions.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 31/08/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func applyGradientFromBottom(colorIn: UIColor) {
        
        let mGradient: CAGradientLayer = CAGradientLayer()
        
        mGradient.colors = [UIColor.clear.cgColor, colorIn.cgColor]
        mGradient.locations = [0.0, 1.0]
        mGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        mGradient.endPoint = CGPoint(x: 0.0, y: 0.9)
        mGradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        self.layer.insertSublayer(mGradient, at: 0)
    }
}
