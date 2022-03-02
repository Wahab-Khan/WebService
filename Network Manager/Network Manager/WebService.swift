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
    
    private init() {}
    

     //MARK: - URL + request type + header + param + body + model
    func invokeApi<T:Codable>(stringURL : String,
                                requestType: RequestMethod = .get ,
                                headers headerParams: Dictionary<String?,String?>? = [nil:nil],
                                params queryParams: Dictionary<String?,String?>? = [nil:nil],
                                body postBodyParams: Dictionary<String?,AnyObject?>? = [nil:nil],
                                isSaveData saveData : Bool = false,
                                dataModel : BaseModel<T>.Type,
                                Completerion : @escaping (BaseModel<T>) -> ()){
        
        
        sendRequest(urlInString: stringURL,
                    requestType: requestType,
                    headers: headerParams as? Dictionary<String, String>,
                    params: queryParams as? Dictionary<String, String>,
                    body: postBodyParams as? Dictionary<String, AnyObject>) { (res) in
                        switch res {
                        case .success(let dataSet):
                            do{
                                //parce data with JSONDecoder
                                let data = try JSONDecoder().decode(dataModel.self, from: dataSet)
                                
                                /*if recponce is reived but status code of API is not 2oo
                                ie url is correnct but device token is missing */
                                if data.StatusCode != 200{
                                    print(data.StatusMessage ?? "This is default status message")
                                    return
                                }
                                //send recponce back
                                Completerion(data)
                                //save data in Plist
                                if saveData {
                                    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(dataModel).plist")
                                    print("\(String(describing: dataFilePath))")
                                    print("\(dataModel)")
                                    
                                    let encoder =  PropertyListEncoder()
                                    do{
                                        let data = try? encoder.encode(data)
                                        try data?.write(to: dataFilePath!)
                                    }catch{
                                        print("Error while saving data in Plist")
                                    }
                                }
                            
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
        
        //assign haeader params
        if let header = headerParams{
            for (key ,value) in header{
                request.addValue(value, forHTTPHeaderField: key)
            }
        }else{
            print("header is nill : URL is \(urlInString)")
        }
        //assign body params
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
            //if did'nt recive any data
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

    //assign the params
    func queryString(_ value: String, params: [String: String]) -> String? {
        var components = URLComponents(string: value)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        
        return components?.url?.absoluteString
    }
    
    
    //MARK: - FatchDataFromPList
    func fatchDataFromPlist<T:Codable>(dataModel:BaseModel<T>.Type) -> BaseModel<T>? {
        //show the path of Plist
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(dataModel).plist")
        
        //Decode and return data in Plist
        if let data = try? Data(contentsOf: dataFilePath!){
                 let decoder = PropertyListDecoder()
                 do{
                    let model = try decoder.decode(dataModel.self, from: data)
                    return model
                 }catch{
                     print("Error while fatching data ")
                 }
             }
        return nil
    }
    
    
    func deletePlist<T:Codable>(dataModel:BaseModel<T>.Type) {
        //get file path url
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(dataModel).plist")
        
        if dataFilePath != nil {
            let filePath : String = dataFilePath!.path
//            do{
                //convert path to string
//                filePath = try String(contentsOf: dataFilePath!)
                do {
                    //check if file exist with that path
                    if FileManager.default.fileExists(atPath: filePath) {
                        //delet file
                        try FileManager.default.removeItem(atPath: filePath)
                        print("file deleted form path : \(dataFilePath!)")
                    }else{
                        print("file doest exist")
                    }
                } catch {
                    print(error)
                }
                
//            }catch{
//                print(error)
//            }
        }
    }
    
    
}
