//
//  ContentDCollectionViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 22/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Nuke

class ContentDCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var serieContentIMG: UIImageView!
    @IBOutlet weak var serieContentNameLB: UILabel!
    @IBOutlet weak var serieContentOriginalNameLB: UILabel!
    @IBOutlet weak var serieContentGendersLB: UILabel!
    
    override func prepareForReuse() {
        serieContentIMG.image = UIImage(named: "IMGPlaceHolder_IC")
        serieContentNameLB.text = ""
        serieContentOriginalNameLB.text = ""
        serieContentGendersLB.text = ""
    }
    
    func setupCell(serieContentIn: SerieContent) {
        
            DispatchQueue.main.async {
                if let posterPath = serieContentIn.seriePosterPath {
                    if let posterURL = URL(string: posterPath.buildURLStringIMG()) {
                        Nuke.loadImage(with: posterURL, options: ImageLoadingOptions().loadIMGBaseOptions(), into: self.serieContentIMG, progress: nil, completion: { _ in
                            self.serieContentIMG.resizeIMGToFrame()
                        })
                    }
                }
            }
            
            serieContentNameLB.text = serieContentIn.serieName
            serieContentOriginalNameLB.text = serieContentIn.serieOriginalName
            serieContentGendersLB.text = "Generos: Drama, Action, Romance"
    }
}
