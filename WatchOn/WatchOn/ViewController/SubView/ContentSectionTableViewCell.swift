//
//  ContentSectionTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 08/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class ContentSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionTitleLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.sectionTitleLB.text = ""
    }
    
    func setupCell(titleIn: String) {
        self.sectionTitleLB.text = titleIn
    }

}
