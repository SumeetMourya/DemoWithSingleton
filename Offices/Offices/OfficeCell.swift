//
//  OfficeCell.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 26/01/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class OfficeCell: UITableViewCell {
    
    static let identifier = "OfficeCellID"
    
    @IBOutlet var nameOfOffice: UILabel!
    @IBOutlet var addressOfOffice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func bindDataToUI(data: ListOfOfficesItem) {
        nameOfOffice.text = data.nameOfOffice
        var valueOfAddress: String = ""
        
        if let zipCode = data.zipCodeOfOffice {
            valueOfAddress.append("\(zipCode) ")
        }
        
        if let city = data.cityOfOffice {
            valueOfAddress.append("\(city), ")
        }
        
        if let address = data.addressOfOffice {
            valueOfAddress.append(address)
        }
        
        addressOfOffice.text = valueOfAddress
    }
    
}
