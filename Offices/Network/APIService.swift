//
//  APIService.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 26/01/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Reachability

enum ApiStatusType: Int {
    
    case apiSucceed
    case netWorkIssue
    case apiIssue
    case apiParsingIssue
    case apiEncodingIssue
    case none
    
}


class APIService {
    
    let reachability = Reachability()
    
    init() { }
    
    func loadDataWith(urlString: String, onSuccess success: @escaping (_ data: Data, _ apiStatusCode: ApiStatusType) -> Void, onFailure failure: @escaping (_ error: Error?, _ apiStatusCode: ApiStatusType) -> Void) {
        
        if (reachability?.connection == .cellular || reachability?.connection == .wifi) {
            
            guard let url = URL(string: urlString) else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let errorValue = error {
                    failure(errorValue, ApiStatusType.apiIssue)
                } else if let data = data {
                    success(data, ApiStatusType.apiSucceed)
                } else {
                    failure(nil, ApiStatusType.netWorkIssue)
                }
                
            }
            task.resume()
            
        } else {
            failure(nil, ApiStatusType.netWorkIssue)
        }
        
    }
    
}

