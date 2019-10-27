//
//  Menu.swift
//  Network Manager
//
//  Created by Abdul Wahab on 27/10/2019.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation

class Menu: Codable {
    var FooterMenu : [FMenu]?
    var ListMenu : [FMenu]?
    
    var FooterMenuEn : [FMenu]?
    var ListMenuEn : [FMenu]?

}


class FMenu: Codable {
    var AppMenuNavigationID : Int?
    var Title : String?
    var Name : String?
    var UpdatedOn : String?
    var SeqNo : Int?
    var IsMainMenu: Bool?
    var Markets : [Market]?
    var IsFixed : Bool?
    var LanguageID : Int?
}


class Market: Codable {
    var MarketID : Int?
    var MarketName : String?
    var GeneralIndexSymbol : String?
    var CountryID : Int?
    var FlagFileName : String?
    var Symbol : String?
    var CloseValue : String?
    var High : String?
    var Low : String?
    var ChangeValue : String?
    var ChangePercentage : String?
    var Volume : String?
    var IndexValue : String?
    var NumberOfTrans : Int?
    var Amount : String?
    var TickerMappingID : Int?
    var TickerAssociatedCompanyID : Int?
    var CompaniesCount : Int?
    var Sequance : Int?
}
