//
//  ShowInfoViewController.swift
//  SapoTest
//
//  Created by AgileTech on 1/4/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit

class ShowInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var model = InfoModel()
    static func instantiate() -> ShowInfoViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ShowInfoViewController") as! ShowInfoViewController
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func registerAction(_ sender: Any) {
        let vc = WelcomViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ShowInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoCell
        switch indexPath.row {
        case 0:
            let username = UserDefaults.standard.string(forKey: "Username") ?? ""
            cell.setupCell(title: "Tên đăng nhập", content: username)
        case 1:
            let email = UserDefaults.standard.string(forKey: "Email") ?? ""
            cell.setupCell(title: "Email", content: email)
        case 2:
            let sex = UserDefaults.standard.string(forKey: "Gender") ?? ""
            cell.setupCell(title: "Giới tính", content: sex)
        case 3:
            let age = UserDefaults.standard.string(forKey: "Age") ?? ""
            cell.setupCell(title: "Tuổi", content: age)
        case 4:
            let cityName = UserDefaults.standard.string(forKey: "City Name") ?? ""
            cell.setupCell(title: "Thành phố", content: cityName)
        case 5:
            let districtName = UserDefaults.standard.string(forKey: "District name") ?? ""
            cell.setupCell(title: "Quận huyện", content: districtName)
        default:
            return UITableViewCell()
        }
        return cell
        
    }
    
    
}
