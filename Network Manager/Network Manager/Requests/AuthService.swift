//
//  AuthService.swift
//  Network Manager
//
//  Created by MacBook Pro on 06/07/2022.
//  Copyright © 2022 macbook. All rights reserved.
//

import Foundation
import Combine

let token = "12345"

protocol PurchaseServiceable {
    func purchaseProduct(request: AuthRequest) -> AnyPublisher<AuthResponse, NetworkError>
    
//    func getProduct(productId: Int) -> AnyPublisher<Product, NetworkError>
  //Instead of using Void I use NoReply for requests that might give 200 with empty response
//    func cancelOrder(_ orderId: Int) -> AnyPublisher<NoReply, NetworkError>
}

class PurchaseService: PurchaseServiceable {
    
    private var networkRequest: Requestable
    private var environment: Environment = .development
    
  // inject this for testability
    init(networkRequest: Requestable, environment: Environment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }

    func purchaseProduct(request: AuthRequest) -> AnyPublisher<AuthResponse, NetworkError> {
        
        let endpoint = AuthServiceEndpoints.purchaseProduct(request: request)
        let request = endpoint.createRequest(token: token,
                                             environment: self.environment)
        return self.networkRequest.request(request)
    }
  
}

public struct AuthRequest: Encodable {
    public let products: [String]
    public let cost: Int
}

public struct AuthResponse: Codable {
    public let id: Int
    public let productName: String
}

