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

enum PlayerTypeContent: String {
    case MovieType, SerieChapterType
}

class MainMediaPlayerViewController: UIViewController {
    
    @IBOutlet weak var mainPlayerLoaderView: UIView!
    
    fileprivate var mainLoaderAV: AnimationView!
    fileprivate var mainYTPlayerView: YTPlayerView!
    private var mainContentPresenter: ContentPresenter = ContentPresenter.sharedIntance
    
    var mPlayerTypeContent: PlayerTypeContent = .MovieType
    
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
                DispatchQueue.main.async {
                    self.setupPlayer()
                }
            }
        }
    }
    
    private func setupPlayer() {
    
        switch self.mPlayerTypeContent {
        case .MovieType:
            self.buildAndShowPlayer(videoIDIn: ContentPresenter.sharedIntance.getMovieContentToShowID())
        case .SerieChapterType:
            self.buildAndShowPlayer(videoIDIn: SerieContentPresenter.sharedInstance.getSerieContentToShowID())
        }
        
    }
    
    private func buildAndShowPlayer(videoIDIn: String) {
        
        self.mainYTPlayerView = YTPlayerView(frame: self.view.bounds)
        self.mainYTPlayerView.delegate = self
        self.mainYTPlayerView.load(withVideoId: videoIDIn, playerVars: ["playsinline":"@1"])
        self.view.addSubview(self.mainYTPlayerView)
        self.buildCloseButton()
    }
    
    private func buildCloseButton() {
        let closeBtn = UIButton(frame: CGRect(x: 10, y: 40, width: 50, height: 50))
        closeBtn.setImage(UIImage(named: "XOff_IC"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        if self.mainYTPlayerView != nil {
            self.mainYTPlayerView.addSubview(closeBtn)
        }
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
        if self.mainYTPlayerView != nil {
            self.mainYTPlayerView.removeFromSuperview()
        }
    }
}

extension MainMediaPlayerViewController: YTPlayerViewDelegate {
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        self.showErrorLoadContent()
    }
}

