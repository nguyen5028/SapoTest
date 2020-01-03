//
//  InputTextCell.swift
//  SapoTest
//
//  Created by AgileTech on 1/3/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit

class InputTextCell: UITableViewCell {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    var textChanged: ((String) -> Void)?
    var model = UserRegisterModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func setupCell(type: InputCellType, model: UserRegisterModel) {
        self.model = model
        inputTextField.delegate = self
        inputTextField.placeholder = type.textPlaceHolder
        inputTextField.attributedPlaceholder = NSAttributedString(string: type.textPlaceHolder,
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.green])
        warningLabel.isHidden = true
        validate(type: type, model: model)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func validate(type: InputCellType, model: UserRegisterModel) {
        guard let usernameChar = model.username?.count else {
            return
        }
        guard let emailChar = model.email?.count else {return}
        guard let passwordChar = model.password?.count else {return}
        warningLabel.isHidden = model.isShowWarning
        warningLabel.text = model.warningMess
        if type == .username && usernameChar < 8 {
            warningLabel.isHidden = false
            warningLabel.text = "username phải lớn hơn 8 kí tự"
            warningLabel.textColor = .red
            inputTextField.attributedPlaceholder = NSAttributedString(string: type.textPlaceHolder,
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if type == .email && emailChar < 8 {
            warningLabel.isHidden = false
            warningLabel.text = "email không hợp lệ"
            warningLabel.textColor = .red
            inputTextField.attributedPlaceholder = NSAttributedString(string: type.textPlaceHolder,
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if type == .password && passwordChar < 8 {
            warningLabel.isHidden = false
            warningLabel.text = "password phải lớn hơn 8 kí tự"
            warningLabel.textColor = .red
            inputTextField.attributedPlaceholder = NSAttributedString(string: type.textPlaceHolder,
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if type == .rePassWord && (model.password != model.rePassword){
            warningLabel.isHidden = false
            warningLabel.text = "repeat password phải trùng với password"
            warningLabel.textColor = .red
            inputTextField.attributedPlaceholder = NSAttributedString(string: type.textPlaceHolder,
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
    }
    func validateEmail(YourEMailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
}
extension InputTextCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textChanged?(textField.text ?? "")
    }
}
