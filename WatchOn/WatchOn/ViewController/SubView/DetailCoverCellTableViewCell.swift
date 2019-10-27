//
//  DetailCoverCellTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 10/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Nuke

class DetailCoverCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverIMG: UIImageView!
    @IBOutlet weak var coverTitleLb: UILabel!
    @IBOutlet weak var coverDescripLb: UILabel!
    @IBOutlet weak var coverBGView: UIView!
    
    // MARK: Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.coverBGView.applyGradientFromBottom(colorIn: .homeBackground2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(contentIn: Content) {
        
        DispatchQueue.main.async {
            if let posterPath = contentIn.contentBGPoster {
                if let posterURL = URL(string: posterPath.buildURLStringIMG()) {
                    Nuke.loadImage(with: posterURL, options: ImageLoadingOptions().loadIMGBaseOptions(), into: self.coverIMG)
                    self.coverIMG.contentMode = .scaleAspectFill
                }
            }
        }
        
        coverTitleLb.text = contentIn.contentTitle
        coverDescripLb.text = String().buildGenderNamesString(contentGenrersIn: contentIn.contentGenrersID ?? [])
    }

}
