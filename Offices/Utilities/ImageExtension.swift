//
//  ImageExtension.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 25/01/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit


extension UIImageView {
    
    public func imageFromServerURL(urlString: String, placeHolder: UIImage) {
        
        self.image = nil
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                if error != nil {
                    self.image = placeHolder
                    return
                }
                
                if let imageData = data, let image = UIImage(data: imageData) {
                    self.image = image
                } else {
                    self.image = placeHolder
                }
                
            })
        }).resume()
    }
    
}
