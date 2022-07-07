//
//  Environment.swift
//  Network Manager
//
//  Created by MacBook Pro on 06/07/2022.
//  Copyright © 2022 macbook. All rights reserved.
//

import Foundation

public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    var purchaseServiceBaseUrl: String {
        switch self {
        case .development:
            return "https://dev-combine.com/purchaseService"
        case .staging:
            return "https://stg-combine.com/purchaseService"
        case .production:
            return "https://combine.com/purchaseService"
        }
    }
}
