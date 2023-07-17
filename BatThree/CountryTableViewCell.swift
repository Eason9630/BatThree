//
//  CountryTableViewCell.swift
//  BatThree
//
//  Created by 林祔利 on 2023/7/17.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var InfoLabel: UILabel!
    @IBOutlet weak var directLabel: UILabel!
    @IBOutlet weak var countryLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
