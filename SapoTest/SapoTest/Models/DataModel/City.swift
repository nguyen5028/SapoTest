//
//  CityModel.swift
//  SapoTest
//
//  Created by AgileTech on 1/4/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import Foundation
class City: NSObject {
    var name: String = ""
    var code: Int!
    init(dictionary: Dictionary<String, Any>) {
        self.name = dictionary["Name"] as! String
        self.code = dictionary["CityCode"] as? Int
    }
}
