//
//  WButton.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 03/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import UIKit

@objc enum BtnType: Int {
    case CanReturnStadeImageTitle, CanReturnStadeImage, CanReturnStadeTitle, NotReturnStadeImageTitle, NotReturnStadeImage, NotReturnStadeTitle
}

@IBDesignable
open class WButton: UIButton {
    
    var isChecked: Bool = false
    private var mainBtnType: BtnType = .CanReturnStadeImageTitle
    private var baseIMG: UIImage?
    private var baseTitle: String?
    private var baseBGColor: UIColor!
    
    @IBInspectable open var btnIMGName: String = ""
    @IBInspectable open var bntStade: Int = 0 {
        willSet {
            if let newType = BtnType(rawValue: newValue) {
                mainBtnType = newType
            }
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            switch mainBtnType {
            case .CanReturnStadeImageTitle, .NotReturnStadeImageTitle:
                
                self.setImage(UIImage(named: self.btnIMGName + "On_IC"), for: .normal)
                self.backgroundColor = .btnPressColor
                self.returnToBaseStade()
                
            case .CanReturnStadeImage, .NotReturnStadeImage:
                
                self.setImage(UIImage(named: self.btnIMGName + "On_IC"), for: .normal)
                self.returnToBaseStade()
                
            case .CanReturnStadeTitle, .NotReturnStadeTitle:
                
                self.backgroundColor = .btnPressColor
                self.returnToBaseStade()
                
            default:
                break
            }
        }
    }
    
    override open func awakeFromNib() {
        
        self.baseIMG = self.image(for: .normal)
        self.setTitle(self.title(for: .normal)?.localized(), for: .normal)
        self.baseTitle = self.title(for: .normal)?.localized()
        self.baseBGColor = self.backgroundColor
    }
    
    private func returnToBaseStade() {
        
        switch mainBtnType {
        case .CanReturnStadeImageTitle:
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.setImage(self.baseIMG, for: .normal)
                self.setTitle(self.baseTitle, for: .normal)
                self.backgroundColor = self.baseBGColor
            })
            
        case .CanReturnStadeImage:
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.setImage(self.baseIMG, for: .normal)
            })
            
        case .CanReturnStadeTitle:
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.setTitle(self.baseTitle, for: .normal)
                self.backgroundColor = self.baseBGColor
            })
            
        default:
            break
        }
    }
}
