//
//  ContactsTableViewCell.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 6/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
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
