//
//  AuthResponce.swift
//  Network Manager
//
//  Created by MacBook Pro on 06/07/2022.
//  Copyright © 2022 macbook. All rights reserved.
//

import Foundation
import Combine

func getAuthResponce(){
    var subscriptions = Set<AnyCancellable>()
    let purchaseRequest = AuthRequest(products: ["chicken", "orange juice"], cost: 20)
    let service = PurchaseService(networkRequest: NativeRequestable(), environment: .development)
    service.purchaseProduct(request: purchaseRequest)
                .sink { (completion) in
                    switch completion {
                    case .failure(let error):
                        print("oops got an error \(error.localizedDescription)")
                    case .finished:
                        print("nothing much to do here")
                    }
                } receiveValue: { (response) in
                    print("got my response here \(response)")
                }
                .store(in: &subscriptions)
}
