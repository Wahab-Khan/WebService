//
//  URLs.swift
//  Network Manager
//
//  Created by macbook on 2019-08-30.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation


class URLs {
 
    static var baseUrl : String = "http://irapi.argaam.com/v1.0/json/" //BaseURL IR
    
    static let companyInfoURL = "InvestorsRelation/CompanyInfo"
    
}

extension URLs{
    
//    func appending(_ queryItem: String, value: String?) -> URL {
//
//        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
//
//        // Create array of existing query items
//        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
//
//        // Create query item
//        let queryItem = URLQueryItem(name: queryItem, value: value)
//
//        // Append the new query item in the existing query items array
//        queryItems.append(queryItem)
//
//        // Append updated query items array in the url component object
//        urlComponents.queryItems = queryItems
//
//        // Returns the url from new url components
//        return urlComponents.url!
//    }
    
}

