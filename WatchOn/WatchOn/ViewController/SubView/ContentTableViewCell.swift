//
//  ContentTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 08/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentCV: UICollectionView!
    private var contentType: ContentKind!
    private var onContentTapped: ContentTappedProtocol!
    var numItemsTest: [Int] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(contentTypeIn: ContentKind, onContenttappedIn: ContentTappedProtocol) {
        
        self.onContentTapped = onContenttappedIn
        self.contentType = contentTypeIn
        numItemsTest = [1,2,3,4,5,6]
        
        contentCV.register(UINib.init(nibName: "ContentCellA", bundle: nil), forCellWithReuseIdentifier: "ContentCellA")
        contentCV.register(UINib.init(nibName: "ContentCellB", bundle: nil), forCellWithReuseIdentifier: "ContentCellB")
        
        contentCV.delegate = self
        contentCV.dataSource = self
        
        contentCV.reloadData()
        
    }

}

extension ContentTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numItemsTest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch contentType {
        case .ContentA?:
            let contentACell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellA", for: indexPath) as! ContentACollectionViewCell
            
            return contentACell
        case .ContentB?:
            let contentBCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellB", for: indexPath) as! ContentBCollectionViewCell
            
            return contentBCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onContentTapped.onContentTapped()
    }
}

extension ContentTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellHeight: CGFloat = 0.0
        var cellWidth: CGFloat = 0.0
        
        switch contentType {
        case .ContentB?:
            cellWidth = 150
            cellHeight = 255
        default:
            cellWidth = 256
            cellHeight = 140
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
