//
//  CompanyInfo.swift
//  Network Manager
//
//  Created by macbook on 2019-08-30.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation
import RealmSwift

class CompanyInfo : Object,Decodable {
    dynamic var NameAr : String = ""
    dynamic var NameEn : String = ""
    dynamic var CityAr : String = ""
    dynamic var CityEn : String = ""
    dynamic var Website : String = ""
    dynamic var Email : String = ""
    dynamic var Phone : String = ""
    dynamic var Fax : String = ""
    dynamic var AddressAr : String = ""
    dynamic var AddressEn : String = ""
    dynamic var POBoxAr : String = ""
    dynamic var POBoxEn : String = ""
}
