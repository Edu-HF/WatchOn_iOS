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
        mainSeriesCV.register(UINib(nibName: "ContentCellF", bundle: nil), forCellWithReuseIdentifier: "ContentCellF")
        
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
            return serieContentPresenter.mainContentSeriesData.value[0].mainContentSeries?.count ?? 0
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let serieContent = serieContentPresenter.mainContentSeriesData.value[0].mainContentSeries?[indexPath.row] {
            if serieContent.serieIsSelected != nil && serieContent.serieIsSelected == true {
                let serieSelectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellF", for: indexPath) as! ContentFCollectionViewCell
                serieSelectedCell.setupCell()
                
                return serieSelectedCell
            }else {
                let seriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellD", for: indexPath) as! ContentDCollectionViewCell
                seriesCell.setupCell(serieContentIn: serieContent)
                
                return seriesCell
            }
            
        }else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        serieContentPresenter.mainContentSeriesData.value[0].mainContentSeries?[indexPath.row].serieIsSelected = true
        self.mainSeriesCV.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let serieContent = serieContentPresenter.mainContentSeriesData.value[0].mainContentSeries?[indexPath.row] {
            if serieContent.serieIsSelected != nil && serieContent.serieIsSelected == true {
                return CGSize(width: 400, height: 500)
            }else {
                return CGSize(width: 180, height: 400)
            }
        }else {
            return CGSize(width: 180, height: 400)
        }
    }
    
}
