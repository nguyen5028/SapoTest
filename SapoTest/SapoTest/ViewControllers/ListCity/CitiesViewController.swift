//
//  CitiesViewController.swift
//  SapoTest
//
//  Created by AgileTech on 1/3/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit
import SVProgressHUD
class CitiesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentDescription: UILabel!
    var listCity = [City]()
    var listDistrict = [District]()
    var isDistrict = false
    var model = InfoModel()
    static func instantiate() -> CitiesViewController {
        let storyBoard = UIStoryboard(name: "ListCity", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CitiesViewController") as! CitiesViewController
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        listCity.removeAll()
        if isDistrict == true {
            self.title = "Quận huyện"
            self.contentDescription.text = "Bạn hãy chọn Quận / Huyện nơi bạn ở"
            self.navigationItem.setHidesBackButton(false, animated: true)
            listDistrict.removeAll()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData(isDistrict: isDistrict)
    }
    func getData(isDistrict: Bool) {
        SVProgressHUD.show()
        let urlString = "https://raw.githubusercontent.com/sapo-tech/home_test_mobile/master/Cities.json"
        APIHelper.shared.getCities(urlString: urlString) { cities in
            self.listCity = cities
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
        if isDistrict {
            SVProgressHUD.show()
            let urlString = "https://raw.githubusercontent.com/sapo-tech/home_test_mobile/master/Districts.json"
            APIHelper.shared.getDistricts(urlString: urlString) { districts in
                self.listDistrict.removeAll()
                self.listDistrict = districts.filter {
                    $0.cityCode == self.model.city.code
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushGender" {
            let destination = segue.destination as! AgeGenderViewController
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isDistrict {
            return true
        }
        return false
    }
    
}
extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDistrict {
            return listDistrict.count
        }
        return listCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell else {
            return UITableViewCell()
        }
        let city = listCity[indexPath.row]
        cell.cityButton.setTitle(city.name, for: .normal)
        
        model.city = city
        cell.setupCell(index: indexPath.row)
        cell.delegate = self
        if isDistrict {
            let dis = listDistrict[indexPath.row]
            cell.cityButton.setTitle(dis.name, for: .normal)
            cell.delegate = self
            cell.setupCell(index: indexPath.row)
        }
        return cell
    }
    
    
}
extension CitiesViewController: CityCellDelegate {
    func onClick(index: Int) {
        if !isDistrict {
            let vc = CitiesViewController.instantiate()
            let city = listCity[index]
            vc.isDistrict = true
            model.city = city
            vc.model = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
