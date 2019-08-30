//
//  BaseModel.swift
//  Network Manager
//
//  Created by macbook on 2019-08-30.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation


struct BaseModel<T : Decodable>: Decodable {
    var StatusCode : Int?
    var StatusMessage : String?
    var Data : T?
    var ErrorMessage : String?
    
    
    func isSecussful() -> Bool {
        if StatusCode == 200 {
            return true
        }
        return false
    }
    
}
