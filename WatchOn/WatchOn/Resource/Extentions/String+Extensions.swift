//
//  String+Extensions.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 29/08/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

extension String {
    
    func buildURLStringIMG() -> String {
        let mainDict = Bundle.main.infoDictionary
        let bURL = mainDict?["API_IMG_BASE_URL"] as! String
        return bURL + self
    }
    
}
