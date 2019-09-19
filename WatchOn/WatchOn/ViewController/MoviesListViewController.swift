//
//  MoviesListViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 07/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

protocol ContentTappedProtocol {
    func onContentTapped(contentIn: Content)
}

class MoviesListViewController: BaseViewController {
    
    @IBOutlet weak var moviesTV: UITableView!
    var contentPresenter: ContentPresenter = ContentPresenter.sharedIntance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        setVCTitle(titleIn: "MoviesUKey".localized())
        moviesTV.register(UINib(nibName: "ContentSectionCell", bundle: nil), forCellReuseIdentifier: "ContentSectionCell")
        moviesTV.register(UINib(nibName: "ContentTableCell", bundle: nil), forCellReuseIdentifier: "ContentTableCell")
        
        setupListeners()
    }

    private func setupListeners() {
        
        contentPresenter.mainContentData.bind { mainContentDataIn in
            self.moviesTV.reloadData()
        }
        
        contentPresenter.mainErrorResponse?.bind { errorIn in
            print("Error MALDITO")
        }
        
        contentPresenter.getGenresMovies()
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentPresenter.mainContentData.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch contentPresenter.mainContentData.value[indexPath.row].contentType {
        case .Section:
            return 40.0
        case .ContentA:
            return 150.0
        case .ContentB:
            return 260.0
        case .ContentC:
            return 400.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch contentPresenter.mainContentData.value[indexPath.row].contentType {
        case .Section:
            
            let sectionCell = tableView.dequeueReusableCell(withIdentifier: "ContentSectionCell") as! ContentSectionTableViewCell
            sectionCell.setupCell(titleIn: contentPresenter.mainContentData.value[indexPath.row].contentTitle ?? "")
            return sectionCell
            
        case .ContentA, .ContentB, .ContentC:
            
            let contentCell = tableView.dequeueReusableCell(withIdentifier: "ContentTableCell") as! ContentTableViewCell
            contentCell.setupCell(mainContentIn: contentPresenter.mainContentData.value[indexPath.row], onContenttappedIn: self)
            return contentCell
            
        }
    }
}

extension MoviesListViewController: ContentTappedProtocol {
    
    func onContentTapped(contentIn: Content) {
        self.contentPresenter.mainContentSelected = contentIn
        let detailVC = DetailViewController.loadFromNib()
        //let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        self.dismissAndPresent(viewController: detailVC)
    }
}

