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
    
    enum DirectionX {
        case Left, Right
    }
    
    enum DirectionY {
        case Top, Bottom
    }

    func applyGradientFromBottom(colorIn: UIColor) {
        
        let mGradient: CAGradientLayer = CAGradientLayer()
        
        mGradient.colors = [UIColor.clear.cgColor, colorIn.cgColor]
        mGradient.locations = [0.0, 1.0]
        mGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        mGradient.endPoint = CGPoint(x: 0.0, y: 0.9)
        mGradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        self.layer.insertSublayer(mGradient, at: 0)
    }
    
    func faceAnimation(durationIn: TimeInterval = 1.0, delayIn: TimeInterval = 0.0, alphaIn: CGFloat, completionIn: @escaping ((Bool) -> ()) = {(onFinish: Bool) -> () in}) {
        UIView.animate(withDuration: durationIn, delay: delayIn, options:     UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = alphaIn
        }, completion: completionIn)
        
    }
    
    func animationAlpha(delay: Double, block: @escaping ()->()){
        self.isHidden = false
        self.alpha = 0.0
        UIView.animate(withDuration: delay,  animations: {
            self.alpha = 1.0
        },  completion: { finished in
            self.alpha = 1.0
            block()
        })
    }

    
    func animationSlideInHorizontal(delay: Double, direction: DirectionX, block: @escaping ()->()){
        self.isHidden = true
        if(DirectionX.Left == direction){
            self.transform = CGAffineTransform(translationX: -400, y: 0)
        }else{
            self.transform = CGAffineTransform(translationX: 400, y: 0)
        }
        UIView.animate(withDuration: delay,  animations: {
            self.isHidden = false
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        },  completion: { finished in
            block()
        })
    }
    
    func animationSlideInVertical(delay: Double, direction: DirectionY, block: @escaping ()->()){
        self.isHidden = true
        if(DirectionY.Top == direction){
            self.transform = CGAffineTransform(translationX: 0, y: -400)
        }else{
            self.transform = CGAffineTransform(translationX: 0, y: 800)
        }
        UIView.animate(withDuration: delay,  animations: {
            self.isHidden = false
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        },  completion: { finished in
            block()
        })
    }

    func animationShake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }

}

extension UICollectionViewCell {
    
    var parentVCFromCell: UIViewController? {
        return ((self.superview as? UICollectionView)?.delegate as? UIViewController)
    }
    
    func makeCellAnimation(indexIn: Int) {
        
        if (indexIn % 2 == 0) {
            self.contentView.animationSlideInHorizontal(delay: 0.3, direction: .Left, block: {})
        }else {
            self.contentView.animationSlideInHorizontal(delay: 0.3, direction: .Right, block: {})
        }
        
        self.contentView.animationAlpha(delay: 0.3, block: {})
    }
}
