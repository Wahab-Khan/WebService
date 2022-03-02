//
//  RigisterUser.swift
//  Network Manager
//
//  Created by macbook on 2019-08-30.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation


class RigisterUser : Codable {
    var WasSuccessful : String = ""
    var ErrorMessage : String = ""
    var Key : String = ""
    var UserName : String = ""
    var UserID : Int = 0
    var PhotoURL : String = ""
    var EmailAddress : String = ""
    var userRank : Int = 0
}
