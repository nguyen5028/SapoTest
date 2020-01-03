//
//  District.swift
//  SapoTest
//
//  Created by AgileTech on 1/4/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import Foundation
class District: NSObject {
    var cityCode: Int!
    var name: String!
    var districtCode: Int!
    init(dict: [String: Any]) {
        self.cityCode = dict["CityCode"] as? Int
        self.name = dict["Name"] as? String
        self.districtCode = dict["DistrictCode"] as? Int
    }
}
