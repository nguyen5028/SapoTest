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
}
extension ShowInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoCell
        switch indexPath.row {
        case 0:
            cell.setupCell(title: "Tên đăng nhập", content: model.userName)
        case 1:
            cell.setupCell(title: "Email", content: model.email)
        case 2:
            cell.setupCell(title: "Giới tính", content: model.sex)
        case 3:
            cell.setupCell(title: "Tuổi", content: model.age)
        case 4:
            cell.setupCell(title: "Thành phố", content: model.city.name)
        case 5:
            cell.setupCell(title: "Quận huyện", content: model.district.name)
        default:
            return UITableViewCell()
        }
        return cell
        
    }
    
    
}
