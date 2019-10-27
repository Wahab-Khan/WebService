//
//  FinancialStatementsWithHistory.swift
//  Network Manager
//
//  Created by macbook on 2019-09-01.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation


class FinancialStatementsWithHistory :Decodable {
    
    var Period : String = ""
    var Year : Int = 0
    var Years : [Year]
}

class Year : Decodable {
    var Year : String = ""
}
