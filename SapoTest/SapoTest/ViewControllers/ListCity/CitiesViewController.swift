//
//  CitiesViewController.swift
//  SapoTest
//
//  Created by AgileTech on 1/3/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit
class CitiesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var listCity = [City]()
    var model = InfoModel()
    static func instantiate() -> CitiesViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CitiesViewController") as! CitiesViewController
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Thành Phố"
        self.navigationItem.setHidesBackButton(true, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CityCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CityCell")
        listCity.removeAll()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIHelper.shared.checkFileExits(fileName: "Cities.json")
        getData()
    }
//    func getData() {
//        let urlString = "https://raw.githubusercontent.com/sapo-tech/home_test_mobile/master/Cities.json"
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if error == nil && data != nil {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
//                    // Access specific key with value of type String
//                    let cities = json["Cities"] as! [Dictionary<String, Any>]
//                    for city in cities {
//                        let aCity = City(dictionary: city)
//                        self.listCity.append(aCity)
//                    }
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                } catch {
//                    print("Error download file")
//                }
//            }
//        }.resume()
//    }
    func getData() {
        let urlString = "https://raw.githubusercontent.com/sapo-tech/home_test_mobile/master/Cities.json"
        APIHelper.shared.getCities(urlString: urlString) { response in
            print("Rs:", response)
            switch response.result {
            case .success(let json):
                let value = json as! [String: Any]
                let cities = value["Cities"] as! [[String: Any]]
                for city in cities {
                    let aCity = City(dictionary: city)
                    self.listCity.append(aCity)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
            
        }
    }
}
extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        return cell
    }
    
    
}
extension CitiesViewController: CityCellDelegate {
    func onClick(index: Int) {
        let vc = DistrictsViewController.instantiate()
        let city = listCity[index]
        model.city = city
        vc.infoModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
