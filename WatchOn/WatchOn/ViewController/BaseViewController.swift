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
    private var mNotInternetVC: NotInternetViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStandarView()
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
            mNotInternetVC = NotInternetViewController()
            mNotInternetVC!.modalPresentationStyle = .fullScreen
            self.present(self.mNotInternetVC!, animated: true, completion: nil)
        default:
            if mNotInternetVC != nil {
                self.mNotInternetVC!.dismiss(animated: true, completion: nil)
                self.mNotInternetVC = nil
            }
        }
    }
}

