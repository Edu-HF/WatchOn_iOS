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
    private var serieContentPresenter: SerieContentPresenter = SerieContentPresenter.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        setVCTitle(titleIn: "SeriesUKey".localized())
        mainSeriesCV.register(UINib(nibName: "ContentCellD", bundle: nil), forCellWithReuseIdentifier: "ContentCellD")
        
        setupListeners()
    }
    
    private func setupListeners() {
        
        serieContentPresenter.mainContentSeriesData.bind { _ in
            self.mainSeriesCV.reloadData()
        }
        
        serieContentPresenter.mainErrorResponse?.bind { errorIn in
            self.showSomeMSGAlert(titleIn: "OupsErrorKey".localized(), msgIn: errorIn.localizedDescription)
        }
        
        serieContentPresenter.getAllContentForSeries()
    }
}

extension SeriesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if serieContentPresenter.mainContentSeriesData.value.count != 0 {
            return serieContentPresenter.mainContentSeriesData.value.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let seriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellD", for: indexPath) as! ContentDCollectionViewCell
        seriesCell.setupCell(serieContentIn: serieContentPresenter.mainContentSeriesData.value[indexPath.row])
        
        return seriesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.serieContentPresenter.mainSerieContentSelected.value = serieContentPresenter.mainContentSeriesData.value[indexPath.row]
        self.navigationController?.pushViewController(SerieDetailViewController(nibName: "SerieDetailView", bundle: nil), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return serieContentPresenter.getSerieContentCellH()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.makeCellAnimation(indexIn: indexPath.row)
    }
}
