//
//  DistrictsViewController.swift
//  SapoTest
//
//  Created by AgileTech on 1/4/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit

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
        getData()
    }
    func getData() {
        let urlString = "https://raw.githubusercontent.com/sapo-tech/home_test_mobile/master/Districts.json"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil && data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
                    // Access specific key with value of type String
                    let districts = json["Districts"] as! [Dictionary<String, Any>]
                    for dis in districts {
                        let aDis = District(dict: dis)
                        self.listDistrict.append(aDis)
                    }
                    self.filerDis = self.listDistrict.filter {$0.cityCode == self.infoModel.city.code}
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error download file")
                }
            }
            }.resume()
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
