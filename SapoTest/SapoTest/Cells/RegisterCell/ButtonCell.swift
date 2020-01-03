//
//  ButtonCell.swift
//  SapoTest
//
//  Created by AgileTech on 1/3/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit
protocol ButtonCellDelegate: class {
    func onNext()
}
class ButtonCell: UITableViewCell {

    @IBOutlet weak var buttonNext: UIButton!
    weak var delegate: ButtonCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func nextAction(_ sender: Any) {
        delegate?.onNext()
    }
}
