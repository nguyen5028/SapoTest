//
//  ViewController.swift
//  SapoTest
//
//  Created by AgileTech on 1/3/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var userModel = UserRegisterModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }


}
extension RegisterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150/586 * UIScreen.main.bounds.height
        case 1, 2, 3, 4:
            return 60/586 * UIScreen.main.bounds.height
        default:
            return 150/586 * UIScreen.main.bounds.height
        }
    }
}
extension RegisterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            return headerCell
        case 1:
            let inputCell = tableView.dequeueReusableCell(withIdentifier: "InputTextCell", for: indexPath) as! InputTextCell
            if let type = InputCellType(rawValue: 1) {
                inputCell.setupCell(type: type, model: userModel)
                inputCell.textChanged = { (text) in
                    self.userModel.username = text
                }
            }
            return inputCell
        case 2:
            let inputCell = tableView.dequeueReusableCell(withIdentifier: "InputTextCell", for: indexPath) as! InputTextCell
            if let type = InputCellType(rawValue: 2) {
                inputCell.setupCell(type: type, model: userModel)
                inputCell.textChanged = { (text) in
                    self.userModel.email = text
                }
            }
            return inputCell
        case 3:
            let inputCell = tableView.dequeueReusableCell(withIdentifier: "InputTextCell", for: indexPath) as! InputTextCell
            if let type = InputCellType(rawValue: 3) {
                inputCell.setupCell(type: type, model: userModel)
                inputCell.inputTextField.isSecureTextEntry = true
                inputCell.textChanged = { (text) in
                    self.userModel.password = text
                }
            }
            return inputCell
        case 4:
            let inputCell = tableView.dequeueReusableCell(withIdentifier: "InputTextCell", for: indexPath) as! InputTextCell
            if let type = InputCellType(rawValue: 4) {
                inputCell.setupCell(type: type, model: userModel)
                inputCell.inputTextField.isSecureTextEntry = true
                inputCell.textChanged = { (text) in
                    self.userModel.rePassword = text
                }
            }
            return inputCell
            
        case 5:
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
            buttonCell.delegate = self
            return buttonCell
        default:
            return UITableViewCell()
        }
    }
}
enum InputCellType: Int {
    case username = 1, email, password, rePassWord
    var textPlaceHolder: String {
        switch self {
        case .username:
            return "Username"
        case .email:
            return "Email"
        case .password:
            return "Password"
        case . rePassWord:
            return "Repeat password"
        }
    }
}
extension RegisterViewController: ButtonCellDelegate {
    func onNext() {
        print("Model:", userModel)
        let vc = CitiesViewController.instantiate()
        vc.model.userName = userModel.username
        vc.model.email = userModel.email
        validate(model: userModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func validate( model: UserRegisterModel) {
        guard let usernameChar = model.username?.count else {
            return
        }
        guard let emailChar = model.email else {return}
        guard let passwordChar = model.password?.count else {return}
        if usernameChar < 8 {
            model.isShowWarning = false
            model.warningMess = "username phải lớn hơn 8 kí tự"
        }
        if validateEmail(YourEMailAddress: emailChar) {
            
            model.isShowWarning = false
            model.warningMess = "email không hợp lệ"
            
            
        }
        if passwordChar < 8 {
            model.isShowWarning = false
            model.warningMess = "password phải lớn hơn 8 kí tự"
            
        }
        if (model.password != model.rePassword){
            model.isShowWarning = false
            model.warningMess = "repeat password phải trùng với password"
            
        }
    }
    func validateEmail(YourEMailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
}
