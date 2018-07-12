//
//  ViewControllerTableViewCell.swift
//  Hill View Apartment
//
//  Created by Vittal Pai on 7/10/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//


import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTeam: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
