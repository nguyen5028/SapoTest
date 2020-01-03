//
//  AgeGenderViewController.swift
//  SapoTest
//
//  Created by AgileTech on 1/4/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit

class AgeGenderViewController: UIViewController {
    
    @IBOutlet weak var picker: UIPickerView!
    var ageValues: [Int] = [Int](8...80)
    var infoModel = InfoModel()
    @IBOutlet weak var otherButton: KGRadioButton!
    
    @IBOutlet weak var maleButton: KGRadioButton!
    @IBOutlet weak var femaleButton: KGRadioButton!
    static func instantiate() -> AgeGenderViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AgeGenderViewController") as! AgeGenderViewController
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Giới tính"
        picker.delegate = self
        picker.dataSource = self
        femaleButton.isSelected = true
        picker.selectRow(17, inComponent: 0, animated: true)
        infoModel.age = "\(25)"
        // Do any additional setup after loading the view.
    }
    @IBAction func otherAction(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        infoModel.sex = Gender(rawValue: sender.tag)?.title
        femaleButton.isSelected = false
        maleButton.isSelected = false
    }
    @IBAction func maleAction(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        infoModel.sex = Gender(rawValue: sender.tag)?.title
        femaleButton.isSelected = false
        otherButton.isSelected = false
    }
    @IBAction func femaleAction(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        infoModel.sex = Gender(rawValue: sender.tag)?.title
        maleButton.isSelected = false
        otherButton.isSelected = false
    }
    @IBAction func nextAction(_ sender: Any) {
        let vc = ShowInfoViewController.instantiate()
        vc.model = infoModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension AgeGenderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return ageValues.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(ageValues[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let age = ageValues[row]
        infoModel.age = "\(age)"
        
    }
}
enum Gender: Int {
    case female = 0, male, other
    var title: String {
        switch self {
        case .female:
            return "Nữ"
        case .male:
            return "Nam"
        case .other:
            return "Khác"
        }
    }
}
