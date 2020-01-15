//
//  DistrictsViewController.swift
//  SapoTest
//
//  Created by AgileTech on 1/4/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit
import SVProgressHUD
class DistrictsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var listDistrict = [District]()
    var filerDis = [District]()
    var infoModel = InfoModel()
    static func instantiate() -> DistrictsViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DistrictsViewController") as! DistrictsViewController
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Quận huyện"
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CityCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CityCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listDistrict.removeAll()
        filerDis.removeAll()
        //APIHelper.shared.checkFileExits(fileName: "Districts.json")
        SVProgressHUD.show()
        getData()
    }
    func getData() {
        let urlString = "https://raw.githubusercontent.com/sapo-tech/home_test_mobile/master/Districts.json"
        APIHelper.shared.getDistricts(urlString: urlString) { districts in
            self.listDistrict.removeAll()
            //self.filerDis = self.listDistrict.filter {$0.cityCode == self.infoModel.city.code}

            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }

}
extension DistrictsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
extension DistrictsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filerDis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell else {
            return UITableViewCell()
        }
        let dis = filerDis[indexPath.row]
        cell.cityButton.setTitle(dis.name, for: .normal)
        cell.delegate = self
        cell.setupCell(index: indexPath.row)
        return cell
    }
    
    
}
extension DistrictsViewController: CityCellDelegate {
    func onClick(index: Int) {
        let vc = AgeGenderViewController.instantiate()
        let dis = filerDis[index]
        infoModel.district = dis
        vc.infoModel = infoModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
