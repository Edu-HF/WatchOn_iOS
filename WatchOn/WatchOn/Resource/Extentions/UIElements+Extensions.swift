//
//  UIElements+Extensions.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 12/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    override open func awakeFromNib() {
        self.text = self.text?.localized()
    }
}

extension UITextField {
    
    override open func awakeFromNib() {
        self.placeholder = self.placeholder?.localized()
    }
}

extension UIButton {
    
    override open func awakeFromNib() {
        self.setTitle(self.title(for: .normal)?.localized(), for: .normal)
    }
}

extension UITextView {
    
    override open func awakeFromNib() {
        self.text = self.text?.localized()
    }
}
