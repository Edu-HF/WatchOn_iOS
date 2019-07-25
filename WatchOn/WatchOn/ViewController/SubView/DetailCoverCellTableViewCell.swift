//
//  DetailCoverCellTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 10/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class DetailCoverCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverIMG: UIImageView!
    @IBOutlet weak var coverTitleLb: UILabel!
    @IBOutlet weak var coverDescripLb: UILabel!
    @IBOutlet weak var coverPlayBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
