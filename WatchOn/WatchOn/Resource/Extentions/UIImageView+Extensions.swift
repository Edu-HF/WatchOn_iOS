//
//  UIImageView+Extensions.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 31/08/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import UIKit
import Toucan
import Nuke

extension UIImageView {
    
    func resizeIMGToFrame() {
        self.image =  Toucan.Resize.resizeImage(self.image ?? UIImage(named: "IMGPlaceHolder_IC")!, size: self.frame.size, fitMode: .scale)
    }
    
    func resizeRoundedIMG() {
        if let img = Toucan.Resize.resizeImage(self.image ?? UIImage(named: "IMGPlaceHolder_IC")!, size: self.frame.size, fitMode: .scale) {
           self.image = Toucan(image: img).maskWithEllipse(borderWidth: 3, borderColor: .btnGreenColor).image
        }
    }
    
    func resizeRoundedIMGCam() {
        if let img = Toucan.Resize.resizeImage(self.image ?? UIImage(named: "CAMPlaceHolder_IC")!, size: self.frame.size, fitMode: .scale) {
           self.image = Toucan(image: img).maskWithEllipse(borderWidth: 3, borderColor: .btnGreenColor).image
        }
    }
}

extension ImageLoadingOptions {
    
    func loadIMGBaseOptions() -> ImageLoadingOptions {
        return ImageLoadingOptions(
            placeholder: UIImage(named: "IMGPlaceHolder_IC"),
            transition: .fadeIn(duration: 0.33)
        )
    }
}

