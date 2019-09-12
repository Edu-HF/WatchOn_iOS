//
//  MainMediaPlayerViewController.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 05/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Lottie
import youtube_ios_player_helper

class MainMediaPlayerViewController: UIViewController {
    
    @IBOutlet weak var mainPlayerView: YTPlayerView!
    @IBOutlet weak var mainPlayerLoaderView: UIView!
    
    fileprivate var mainPlayer: YTPlayerView!
    fileprivate var mainLoaderAV: AnimationView!
    private var mainContentPresenter: ContentPresenter = ContentPresenter.sharedIntance
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    private func setupView() {
        
        mainLoaderAV = AnimationView(name: "LoadingContent")
        mainLoaderAV.frame = UIScreen.main.bounds
        mainLoaderAV.contentMode = .scaleAspectFit
        mainPlayerLoaderView.addSubview(mainLoaderAV)
        mainLoaderAV.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.setupPlayer()
        })
    }
    
    private func setupPlayer() {
        
        let playerOpDic = ["controls" : 1, "playInline" : 1, "autohide" : 1, "showinfo" : 0, "autoplay" : 1, "modestbranding" : 1]
        
        mainPlayerView.delegate = self
        mainPlayerView.load(withVideoId: mainContentPresenter.mainContentSelected.contentMedia.value[0].mKey ?? "", playerVars: playerOpDic)
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeVC), name: UIWindow.didBecomeHiddenNotification, object: self.view)
    }
    
    @objc private func closeVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MainMediaPlayerViewController: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.mainPlayerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        if playTime > 0 {
            self.mainLoaderAV.stop()
            self.mainPlayerLoaderView.isHidden = true
        }
    }
    
//    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
//
//        switch state {
//        case .playing:
//
//        default:
//            break
//        }
//    }
}

