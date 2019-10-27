//
//  DetailCastTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 10/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class DetailCastTableViewCell: UITableViewCell {

    @IBOutlet weak var castCV: UICollectionView!
    private var mainContent: Content!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(contentIn: Content) {
        mainContent = contentIn
        castCV.register(UINib(nibName: "CastCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
        castCV.reloadData()
    }
    
}

extension DetailCastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainContent.contentCast.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCollectionViewCell
        castCell.setupCell(castMemberIn: mainContent.contentCast.value[indexPath.row])
        return castCell
    }
}

extension DetailCastTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
