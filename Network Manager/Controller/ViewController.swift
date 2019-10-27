//
//  ViewController.swift
//  Network Manager
//
//  Created by macbook on 2019-08-27.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        WebService.shared.invokeApi(stringURL: URLs.companyInfoURL,
//                                    requestType: .get,
//                                    headers: Utils.getDefaultHeader(),
//                                    isSaveData: true,
//                                    dataModel: BaseModel<CompanyInfo>.self) { (result) in
//
//                                        if result.isSecussful(){
//                                            print(result.Data?.AddressAr)
//                                        }else{
//                                            print(result.StatusMessage!)
//                                        }
//        }

        
//        let param = ["period":"year",
//                     "limit":"15"]
//
//        WebService.shared.invokeApi(stringURL: "InvestorsRelation/GetFinancialStatementsWithHistory",
//                                    requestType: .get,
//                                    headers: Utils.getDefaultHeader(),
//                                    params: param,
//                                    BaseModel<FinancialStatementsWithHistory>.self) { (data) in
//                                        if data.isSecussful(){
//                                            print(data.Data?.Years)
//                                        }else{
//                                            print("Error")
//                                        }
//        }
        
//        let body: [String: Any] = [
//            "EmailAddress": "mullah04@mailinator.com",
//            "UserName": "Jack03",
//            "Password": "danat",
//            "FirstName": "jj",
//            "LastName": "khan",
//            "MobileNo": "090078601",
//            "CountryID": "",
//            "IsGuest": "false"
//        ]
//
//        WebService.shared.invokeApi(stringURL: "http://argaamv2mobileapis.argaamnews.com/V2.2/json/register-user",
//                                    requestType: .post,
//                                    headers: Utils.getHeaderPost(),
//                                    body: body as Dictionary<String, AnyObject>,
//                                    isSaveData : false,
//                                    BaseModel<RigisterUser>.self) { (reslt) in
//
//                                        if reslt.isSecussful() {
//                                            print(reslt.Data!)
//                                        }else{
//                                            print(reslt.StatusMessage!)
//                                        }
//        }
//
//
        
        
        //MARK :- facting data back from p list
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("BaseModel<CompanyInfo>.plist")
//
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do{
//                let model :BaseModel<CompanyInfo> = try decoder.decode(BaseModel<CompanyInfo>.self, from: data)
//                print(model.Data?.AddressAr)
//            }catch{
//                print("Error while fatching data ")
//            }
//        }
        
        //that how call the fatch method 
        let data = WebService.shared.fatchDataFromPlist(dataModel: BaseModel<CompanyInfo>.self)
        print(data?.Data?.AddressEn)
        
    }



}

