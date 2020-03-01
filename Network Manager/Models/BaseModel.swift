//
//  BaseModel.swift
//  Network Manager
//
//  Created by macbook on 2019-08-30.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation

class BaseModel<T : Codable>: Codable {
    dynamic var StatusCode : Int?
    dynamic var StatusMessage : String?
    dynamic var Data : T?
    dynamic var ErrorMessage : String?
    
    
    func isSecussful() -> Bool {
        if StatusCode == 200 {
            return true
        }
        return false
    }
    
}
