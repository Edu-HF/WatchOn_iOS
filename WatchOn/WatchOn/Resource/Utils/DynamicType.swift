//
//  DynamicType.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 21/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

class DynamicType<T> {
    typealias Listener = (T) -> ()
    private var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bindAndTrigger(_ listenerIn: Listener?) {
        self.listener = listenerIn
        listener?(value)
    }
    
    func bind(_ listenerIn: Listener?) {
        self.listener = listenerIn
    }
    
    init(_ v: T) {
        value = v
    }
}
