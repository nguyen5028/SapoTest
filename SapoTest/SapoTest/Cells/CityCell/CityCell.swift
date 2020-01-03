//
//  CityCell.swift
//  SapoTest
//
//  Created by AgileTech on 1/3/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit
protocol CityCellDelegate: NSObject {
    func onClick(index: Int)
}
class CityCell: UITableViewCell {
    @IBOutlet weak var cityButton: DesignableButton!
    weak var delegate: CityCellDelegate?
    var infoModel = InfoModel()
    var index: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(index: Int) {
        self.index  = index
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func clickAction(_ sender: Any) {
        delegate?.onClick(index: index)
    }
}
