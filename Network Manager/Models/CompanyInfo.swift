//
//  CompanyInfo.swift
//  Network Manager
//
//  Created by macbook on 2019-08-30.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation
import RealmSwift

class CompanyInfo : Codable {
    var NameAr : String = ""
    var NameEn : String = ""
    var CityAr : String = ""
    var CityEn : String = ""
    var Website : String = ""
    var Email : String = ""
    var Phone : String = ""
    var Fax : String = ""
    var AddressAr : String = ""
    var AddressEn : String = ""
    var POBoxAr : String = ""
    var POBoxEn : String = ""
}
