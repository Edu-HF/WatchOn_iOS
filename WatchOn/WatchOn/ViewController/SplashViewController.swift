//
//  SplashViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 07/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: BaseViewController {

    @IBOutlet weak var mAnimationView: UIView!
    @IBOutlet weak var woLB: UILabel!
    fileprivate var mainAnimationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mainAnimationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.mainAnimationView.stop()
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let mainTB = mainSB.instantiateViewController(withIdentifier: "MainTabBarViewController") as! UITabBarController
            self.present(mainTB, animated: true, completion: nil)
        }
    }
    
    private func setupView() {
        woLB.textColor = .btnGreenColor
        mainAnimationView = AnimationView(name: "SplashA")
        mainAnimationView.frame = UIScreen.main.bounds
        mainAnimationView.contentMode = .scaleAspectFit
        mainAnimationView.loopMode = .loop
        mAnimationView.addSubview(mainAnimationView)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
