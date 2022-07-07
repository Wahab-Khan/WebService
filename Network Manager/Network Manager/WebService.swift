//
//  WebService.swift
//  Network Manager
//
//  Created by macbook on 2019-08-27.
//  Copyright © 2019 macbook. All rights reserved.
//


import Combine
import Foundation

public protocol Requestable {
    
    var requestTimeOut: Float { get }
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}

public class NativeRequestable: Requestable {
    public var requestTimeOut: Float = 30

    public func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
     where T: Decodable, T: Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)
        
        guard let url = URL(string: req.url) else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL("Invalid Url"))
            )
        }
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
//            .debounce(for: 0.8, scheduler: RunLoop.main) // uncomment this when using search
            .tryMap { output in
                     // throw an error if response is nil
//                guard output.response is HTTPURLResponse else {
//                    throw NetworkError.serverError(code: 0, error: "Server error")
//                }
                return output.data
            }
//            .switchToLatest()
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                       // return error if json decoding fails
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}
