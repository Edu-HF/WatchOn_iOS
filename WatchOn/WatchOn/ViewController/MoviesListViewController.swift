//
//  MoviesListViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 07/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

protocol ContentTappedProtocol {
    func onContentTapped()
}

class MoviesListViewController: BaseViewController {
    
    @IBOutlet weak var moviesTV: UITableView!
    var contentPresenter: ContentPresenter = ContentPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        setVCTitle(titleIn: "Movies")
        
        moviesTV.register(UINib(nibName: "ContentSectionCell", bundle: nil), forCellReuseIdentifier: "ContentSectionCell")
        moviesTV.register(UINib(nibName: "ContentTableCell", bundle: nil), forCellReuseIdentifier: "ContentTableCell")
        
        setupListeners()
    }

    private func setupListeners() {
        
        contentPresenter.mainContentData.bind { mainContentDataIn in
            self.moviesTV.reloadData()
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
        default:
            return 40.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch contentPresenter.mainContentData.value[indexPath.row].contentType {
        case .Section:
            
            let sectionCell = tableView.dequeueReusableCell(withIdentifier: "ContentSectionCell") as! ContentSectionTableViewCell
            sectionCell.setupCell(titleIn: contentPresenter.mainContentData.value[indexPath.row].contentTitle ?? "")
            return sectionCell
            
        case .ContentA, .ContentB:
            
            let contentCell = tableView.dequeueReusableCell(withIdentifier: "ContentTableCell") as! ContentTableViewCell
            contentCell.setupCell(contentTypeIn: contentPresenter.mainContentData.value[indexPath.row].contentType, onContenttappedIn: self)
            return contentCell
            
        default:
            return UITableViewCell()
        }
    }
}

extension MoviesListViewController: ContentTappedProtocol {
    
    func onContentTapped() {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

