//
//  WebService.swift
//  Network Manager
//
//  Created by macbook on 2019-08-27.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case none = "NONE"
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

class WebService {
    
    
    static let shared = WebService()
    
    
    private init() {
    }
    
    
    func invokeApi<T:Decodable>(stringURL : String,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        invokeApi(stringURL: stringURL,
                  requestType: .get,
                  headers: nil,
                  params: nil,
                  dataModel,
                  Completerion: Completerion)
        
    }
    
    
    func invokeApi<T:Decodable>(stringURL : String,
                                requestType: RequestMethod,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        invokeApi(stringURL: stringURL,
                  requestType: requestType,
                  headers: nil,
                  params: nil,
                  dataModel,
                  Completerion: Completerion)
        
    }
    
    func invokeApi<T:Decodable>(stringURL : String,
                                requestType: RequestMethod,
                                headers headerParams: Dictionary<String,String>?,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        invokeApi(stringURL: stringURL,
                  requestType: requestType,
                  headers: headerParams,
                  params: nil,
                  dataModel,
                  Completerion: Completerion)
        
    }
    

    func invokeApi<T:Decodable>(stringURL : String,
                                requestType: RequestMethod,
                                headers headerParams: Dictionary<String,String>?,
                                params postParams: Dictionary<String,AnyObject>?,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        
        sendRequest(urlInString: stringURL,
                    requestType: requestType,
                    headers: headerParams,
                    params: postParams) { (res) in
                        switch res {
                        case .success(let dataSet):
                            do{
                                let data = try JSONDecoder().decode(dataModel.self, from: dataSet)
                                Completerion(data)
                            }catch{
                                print("Error while parsing Data: " , error)
                            }
                        case .failure(let err):
                            print(err)
                        }
                        
        }
    }
        
    }
    
    
    
    
    func sendRequest(urlInString : String,
                            requestType: RequestMethod,
                            headers headerParams: Dictionary<String,String>?,
                            params postParams: Dictionary<String,AnyObject>?,
                            completion: @escaping (Result<Data,Error>) -> ()){
        
    
        let apiURL : String = URLs.baseUrl + urlInString
        
        print("API url string Complete : ",apiURL)
        
        let url = URL(string:apiURL)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = requestType.rawValue
        
        if let header = headerParams{
            for (key ,value) in header{
                request.addValue(value, forHTTPHeaderField: key)
            }
        }else{
            print("header is nill : URL is \(urlInString)")
        }
        
        if let params = postParams{
            do{
                let body = try JSONSerialization.data(withJSONObject: params, options: [])
                request.httpBody = body
            }catch{
                print("Error form params catch : " , error)
            }
        }
        
        URLSession.shared.dataTask(with: request) { (dataSet, responce, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            
            if let respo = responce as? HTTPURLResponse{
                print("Responce Code: \(String(describing: respo.statusCode))")
                if respo.statusCode != 200 {
                    print("You may check URL again : current URL : \(String(describing: respo.url!))")
                }
            }
            
            guard let data = dataSet else {
                return
            }
            completion(.success(data))
            }.resume()
        
    }

