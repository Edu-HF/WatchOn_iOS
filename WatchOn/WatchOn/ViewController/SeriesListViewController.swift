//
//  SeriesListViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 07/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class SeriesListViewController: BaseViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mainSeriesCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        setVCTitle(titleIn: "SeriesUKey".localized())
        mainSeriesCV.register(UINib(nibName: "ContentCellD", bundle: nil), forCellWithReuseIdentifier: "ContentCellD")
    }
}

extension SeriesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let seriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellD", for: indexPath)
        
        seriesCell.sizeToFit()
        return seriesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 400)
    }
    
}
