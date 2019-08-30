//
//  Utils.swift
//  Network Manager
//
//  Created by macbook on 2019-08-27.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation

class Utils {
    
    
    static func getDefaultHeader() -> Dictionary<String,String>{
        return ["Device-Token":"asdf",
                "App-Secret":"63CB056B7AE5CF544C1FAE872E9A7453"]
    }
    
    static func getHeaderPost() -> Dictionary<String,String>{
        return ["DeviceToken":"asdasda",
                "LangID":"2",
                "Content-Type":"application/json"]
    }
}
