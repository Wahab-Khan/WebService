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
    
    //MARK: -  URL + Model
    func invokeApi<T:Decodable>(stringURL : String,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        invokeApi(stringURL: stringURL,
                  requestType: .get,
                  headers: nil,
                  params: nil,
                  body: nil,
                  dataModel,
                  Completerion: Completerion)
        
    }
    
      //MARK: - URL + Request method + Model
    func invokeApi<T:Decodable>(stringURL : String,
                                requestType: RequestMethod,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        invokeApi(stringURL: stringURL,
                  requestType: requestType,
                  headers: nil,
                  params: nil,
                  body : nil,
                  dataModel,
                  Completerion: Completerion)
        
    }
    
    //MARK: - URL + header + model
    func invokeApi<T:Decodable>(stringURL : String,
                                headers headerParams: Dictionary<String,String>?,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        invokeApi(stringURL: stringURL,
                  requestType: .get,
                  headers: headerParams,
                  params: nil,
                  body: nil,
                  dataModel,
                  Completerion: Completerion)
        
    }
    
    
    //MARK: - URL + request type + header + model
    func invokeApi<T:Decodable>(stringURL : String,
                                requestType: RequestMethod,
                                headers headerParams: Dictionary<String,String>?,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        invokeApi(stringURL: stringURL,
                  requestType: requestType,
                  headers: headerParams,
                  params: nil,
                  body: nil,
                  dataModel,
                  Completerion: Completerion)
        
    }
    
    
     //MARK: - URL + request type + header + Params + model
    func invokeApi<T:Decodable>(stringURL : String,
                                requestType: RequestMethod,
                                headers headerParams: Dictionary<String,String>?,
                                params queryParams: Dictionary<String,String>?,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        invokeApi(stringURL: stringURL,
                  requestType: requestType,
                  headers: headerParams,
                  params: queryParams,
                  body: nil,
                  dataModel,
                  Completerion: Completerion)
        
    }
    
    
    //MARK: - URL + request type + header + body + model
    func invokeApi<T:Decodable>(stringURL : String,
                                requestType: RequestMethod,
                                headers headerParams: Dictionary<String,String>?,
                                body postBodyParams: Dictionary<String,AnyObject>?,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        invokeApi(stringURL: stringURL,
                  requestType: requestType,
                  headers: headerParams,
                  params: nil,
                  body: postBodyParams,
                  dataModel,
                  Completerion: Completerion)
        
    }

     //MARK: - URL + request type + header + param + body + model
    func invokeApi<T:Decodable>(stringURL : String,
                                requestType: RequestMethod,
                                headers headerParams: Dictionary<String,String>?,
                                params queryParams: Dictionary<String,String>?,
                                body postBodyParams: Dictionary<String,AnyObject>?,
                                _ dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        
        sendRequest(urlInString: stringURL,
                    requestType: requestType,
                    headers: headerParams,
                    params: queryParams,
                    body: postBodyParams) { (res) in
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
    
    
    
    //MARK: - make request
    
    func sendRequest(urlInString : String,
                            requestType: RequestMethod,
                            headers headerParams: Dictionary<String,String>?,
                            params queryParams: Dictionary<String,String>?,
                            body postBodyParams: Dictionary<String,AnyObject>?,
                            completion: @escaping (Result<Data,Error>) -> ()){
        
    
        var apiURL : String
        apiURL = URLs.baseUrl + urlInString
        if let query = queryParams {
            apiURL = queryString(apiURL, params: query)!
        }
        
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
        
        if let params = postBodyParams{
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

    
    func queryString(_ value: String, params: [String: String]) -> String? {
        var components = URLComponents(string: value)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        
        return components?.url?.absoluteString
    }
    
    
    
}
