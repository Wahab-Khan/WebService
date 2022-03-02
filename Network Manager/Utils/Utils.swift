//
//  Utils.swift
//  Network Manager
//
//  Created by macbook on 2019-08-27.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    
    static func getDefaultHeader() -> Dictionary<String,String>{
        return ["Device-Token":"asdf",
                "App-Secret":"63CB056B7AE5CF544C1FAE872E9A7453"]
    }
    
    static func getHeaderPost() -> Dictionary<String,String>{
        return ["DeviceToken":"asdasda",
                "LangID":"2",
                "Content-Type":"application/json"]
    }
}


func getHeaders() -> Dictionary<String, String> {
    var userID : String = "3"
    var token :String = ""
    let appVersion = "1.8"
    let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String
    let deviceName  = UIDevice.current.name
    let deviceID = UIDevice.current.identifierForVendor?.uuidString
    let osVersion = UIDevice.current.systemVersion
    let deviceModel  = UIDevice.current.model
    let systemName  = UIDevice.current.systemName
    let strIPAddress : String = getIPAddress()
    let userAgent = "\(appName ?? "oyah B")/\(deviceName)/\(osVersion)/\(appVersion ?? "")/\(deviceID ?? "")/\(deviceModel)"
    
    token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJUb2tlbiI6IiIsIlVzZXJJRCI6MjQxNSwiRnVsbE5hbWUiOiJqb2hubnkga2hhbiIsIkVtYWlsIjoiam9obm55QG1haWxpbmF0b3IuY29tIiwiUGFzc3dvcmQiOiIrYWJVcUE4eURoSGdRK09sUUN5Zi9RPT0iLCJNb2JpbGVObyI6Iis5MiAzMzEgMjM0OTQ3MiIsIkRhdGVPZkJpcnRoIjoiMjAwNi0wMi0xOVQwMDowMDowMCIsIlByb2ZpbGVVcmwiOiIiLCJTdGF0dXNJRCI6MSwiQ3JlYXRlZE9uIjoiMjAyMi0wMi0xOVQxNDoxMDo1MS4yNzciLCJNb2RpZmllZE9uIjpudWxsLCJDcmVhdGVkQnkiOm51bGwsIk1vZGlmaWVkQnkiOm51bGwsIkNvdmVyVXJsIjpudWxsLCJJc1B1YmxpYyI6dHJ1ZSwiQmFzZUxhbmd1YWdlSUQiOm51bGwsIkJ1c2luZXNzSUQiOm51bGwsIkJ1c2luZXNzQnJhbmNoSUQiOm51bGwsIlByb3ZpZGVyTmFtZSI6IiIsIlByb3ZpZGVyVXNlcklEIjoiIiwiR2VuZGVyIjoiIiwiVmlzaWJsZUZvbGxvd2VycyI6dHJ1ZSwiVmlzaWJsZUZvbGxvd2luZyI6dHJ1ZSwiSXNWZXJpZmllZCI6ZmFsc2UsIkhhc0V2ZXJFbmFibGVkTG9jYXRpb24iOnRydWUsIklzQmlydGhkYXlVcGRhdGVkIjpmYWxzZX0.JV2q25KmlV2ttaDn9SmJpk-Avi_QGEgWe_3qRQByGbs"
    return [
        "DeviceToken" :"EmptyToken",
        "UserID" : userID,
        "LangID" : "2",
        "Latitude" : "0.0",
        "Longitude" : "0.0",
        "CountryID" : "1",
        "Version" : "1",
        //"DeviceType": "ios",
        "Authorization" : token,
        "Content-Type" : "application/json",
        "DeviceType" : systemName,
        "IPDetail" : strIPAddress,
        "UserAgent" : userAgent,
        "PhoneModel" : deviceModel]
}


func getIPAddress() -> String {
    var address: String?
    var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next }
            
            guard let interface = ptr?.pointee else { return "" }
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // wifi = ["en0"]
                // wired = ["en2", "en3", "en4"]
                // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
                
                let name: String = String(cString: (interface.ifa_name))
                if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
    }
    return address ?? ""
}
