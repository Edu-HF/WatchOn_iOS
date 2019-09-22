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
    

    
    private func setupView() {
        
        mainLoaderAV = AnimationView(name: "LoadingContent")
        mainLoaderAV.frame = UIScreen.main.bounds
        mainLoaderAV.contentMode = .scaleAspectFit
        mainPlayerLoaderView.addSubview(mainLoaderAV)
        mainLoaderAV.play { (isComplete) in
            if isComplete {
                if self.mainPlayerView.playerState().rawValue == 6 {
                    self.showErrorLoadContent()
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.setupPlayer()
        })
    }
    
    private func setupPlayer() {
        
        let playerOpDic = ["controls" : 1, "playInline" : 1, "autohide" : 1, "showinfo" : 0, "autoplay" : 1, "modestbranding" : 1]
        
        mainPlayerView.delegate = self
        var mContentKey = ""
        mainContentPresenter.mainContentSelected.contentMedia.value.forEach {
            if $0.mKey != nil && $0.mKey != "" {
                mContentKey = $0.mKey!
                mainPlayerView.load(withVideoId: mContentKey, playerVars: playerOpDic)
                return
            }
        }
        
        if mContentKey == "" {
            showErrorLoadContent()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeVC), name: UIWindow.didBecomeHiddenNotification, object: self.view)
    }
    
    private func showErrorLoadContent() {
        let mErrorAlert = UIAlertController.init(title: "LoadMediaErrorTitleKey".localized(), message: "LoadMediaErrorMSGKey".localized(), preferredStyle: .alert)
        mErrorAlert.addAction(UIAlertAction.init(title: "AcceptKey".localized(), style: .default, handler: { _ in
            self.closeVC()
        }))
        self.present(mErrorAlert, animated: true, completion: nil)
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
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        self.showErrorLoadContent()
    }
}

