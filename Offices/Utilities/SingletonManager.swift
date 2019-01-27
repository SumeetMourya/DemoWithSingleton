//
//  SingletonManager.swift
//  Offices
//
//  Created by sumeet mourya on 26/01/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation

class SingletonManager: NSObject {
    
    static let sharedInstance = SingletonManager()
    
    override init() {

    }
    
    func getOfficeList() -> [OfficeItemDM] {
        return CoreDataManager.sharedDatabaseManager.getOfficeDataFromLocal()
    }
    
    func updateData() {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
            
            APIManager.sharedInstance.loadDataForURL(url: "https://service.bmf.gv.at/Finanzamtsliste.json", onSuccess: { (officeList, succeedCode) in
                
                CoreDataManager.sharedDatabaseManager.saveData(officesData: officeList)
                DispatchQueue.main.async() {
                    NotificationCenter.default.post(name: Notification.Name("LISTUPDATE"), object: nil, userInfo: ["code" : succeedCode])
                }
                
            }) { (error, errorCode) in
                DispatchQueue.main.async() {
                    NotificationCenter.default.post(name: Notification.Name("LISTUPDATE"), object: nil, userInfo: ["code" : errorCode])
                }
                
            }
        }
        
    }
}


class APIManager {
    
    static let sharedInstance = APIManager()
    
    var apisServiceStart:APIService?
    
    init() {
        apisServiceStart = APIService()
    }
    
    func loadDataForURL(url: String, onSuccess success: @escaping (_ data: [OfficeItemDM], _ apiStatusCode: ApiStatusType) -> Void, onFailure failure: @escaping (_ error: Error?, _ apiStatusCode: ApiStatusType) -> Void) {
        
        apisServiceStart?.loadDataWith(urlString: url, onSuccess: { (parseData, succeedCode) in
            
            let responseStrInISOLatin = String(data: parseData, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                
                failure(nil, ApiStatusType.apiEncodingIssue)
                return
            }
            
            do {
                let offices = try JSONDecoder().decode([OfficeItemDM].self, from: modifiedDataInUTF8Format)
                let sortedOfficesData = offices.sorted(by: {
                    $0.zipCodeOfOffice! < $1.zipCodeOfOffice!
                })
                
                success(sortedOfficesData, ApiStatusType.apiSucceed)
                
            } catch let error as NSError {
                failure(error, ApiStatusType.apiParsingIssue)
            }
            
        }) { (error, errorData) in
            failure(error, errorData)
        }
        
    }
    
    
}
