//
//  BaseViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 08/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Reachability

class BaseViewController: UIViewController {
    
    private var mainReachability: Reachability?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStandarView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
    fileprivate func setupStandarView() {
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor = .darkTwo
        self.tabBarController?.tabBar.barTintColor = .darkTwo
        self.view.backgroundColor = .homeBackground2
        
        self.mainReachability = Reachability()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: .reachabilityChanged, object: nil)
        
        do {
            try self.mainReachability!.startNotifier()
        }catch {
            print("")
        }
    }
    
    @objc private func reachabilityChanged(notification: NSNotification) {
        switch (mainReachability!.connection) {
        case .none:
            print("NO HAY INTERNET")
        default:
            print("SI HAY")
        }
    }
}

