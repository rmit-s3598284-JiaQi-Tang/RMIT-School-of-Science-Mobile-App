//
//  DeadLineTableViewCell.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 10/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit

class DeadLineTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
