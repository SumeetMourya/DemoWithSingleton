//
//  ListOfOfficesItem.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation

import Foundation
import CoreData


struct ListOfOfficesItem: Decodable {
    
    let idOfOffice: String?
    let typeOfOffice: String?
    let kzOfOffice: String?
    let nameOfOffice: String?
    let bIdOffice: String?
    let zipCodeOfOffice: Int?
    let cityOfOffice: String?
    let addressOfOffice: String?
    let teleNetworkOfOffice: String?
    let telephoneNumberOfOffice: String?
    let faxNumberOfOffice: String?
    let bLZOfOffice: String?
    let bankBezOfOffice: String?
    let giroOfOffice: String?
    let bicOfOffice: String?
    let ibanOfOffice: String?
    let dvrOfOffice: String?
    let openingTimeOfOffice: String?
    let imageURLOfOffice: String?
    let latitudeOfOffice: Double?
    let longitudeOfOffice: Double?
    
    
    enum CodingKeys: String, CodingKey {
        
        case DisTyp
        case DisId
        case DisKz
        case DisNameLang
        case DisBld
        case DisPlz
        case DisOrt
        case DisStrasse
        case DiSTelvw
        case DisTel
        case DisFax
        case DisBlz
        case DisBankbez
        case DisGiro
        case DisBic
        case DisIban
        case DisDVR
        case DisOeffnung
        case DisFotoUrl
        case DisLatitude
        case DisLongitude
        
        func getKeyOfData() -> String {
            
            switch self {
            case .DisTyp:
                return "typeOfOffice"
            case .DisId:
                return "idOfOffice"
            case .DisKz:
                return "kzOfOffice"
            case .DisNameLang:
                return "nameOfOffice"
            case .DisBld:
                return "bIdOffice"
            case .DisPlz:
                return "zipCodeOfOffice"
            case .DisOrt:
                return "cityOfOffice"
            case .DisStrasse:
                return "addressOfOffice"
            case .DiSTelvw:
                return "teleNetworkOfOffice"
            case .DisTel:
                return "telephoneNumberOfOffice"
            case .DisFax:
                return "faxNumberOfOffice"
            case .DisBlz:
                return "bLZOfOffice"
            case .DisBankbez:
                return "bankBezOfOffice"
            case .DisGiro:
                return "giroOfOffice"
            case .DisBic:
                return "bicOfOffice"
            case .DisIban:
                return "ibanOfOffice"
            case .DisDVR:
                return "dvrOfOffice"
            case .DisOeffnung:
                return "openingTimeOfOffice"
            case .DisFotoUrl:
                return "imageURLOfOffice"
            case .DisLatitude:
                return "latitudeOfOffice"
            case .DisLongitude:
                return "longitudeOfOffice"
            }
        }
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.typeOfOffice = try? container.decode(String.self, forKey: .DisTyp)
        self.idOfOffice = try? container.decode(String.self, forKey: .DisId)
        self.kzOfOffice = try? container.decode(String.self, forKey: .DisKz)
        self.nameOfOffice = try? container.decode(String.self, forKey: .DisNameLang)
        self.bIdOffice = try? container.decode(String.self, forKey: .DisBld)
        if let zipCodeValue = try? container.decode(String.self, forKey: .DisPlz) {
            self.zipCodeOfOffice = Int(zipCodeValue)
        } else {
            self.zipCodeOfOffice = nil
        }
        self.cityOfOffice = try? container.decode(String.self, forKey: .DisOrt)
        self.addressOfOffice = try? container.decode(String.self, forKey: .DisStrasse)
        self.teleNetworkOfOffice = try? container.decode(String.self, forKey: .DiSTelvw)
        self.telephoneNumberOfOffice = try? container.decode(String.self, forKey: .DisTel)
        self.faxNumberOfOffice = try? container.decode(String.self, forKey: .DisFax)
        self.bLZOfOffice = try? container.decode(String.self, forKey: .DisBlz)
        self.bankBezOfOffice = try? container.decode(String.self, forKey: .DisBankbez)
        self.giroOfOffice = try? container.decode(String.self, forKey: .DisGiro)
        self.bicOfOffice = try? container.decode(String.self, forKey: .DisBic)
        self.ibanOfOffice = try? container.decode(String.self, forKey: .DisIban)
        self.dvrOfOffice = try? container.decode(String.self, forKey: .DisDVR)
        self.openingTimeOfOffice = try? container.decode(String.self, forKey: .DisOeffnung)
        self.imageURLOfOffice = try? container.decode(String.self, forKey: .DisFotoUrl)
        if let latitudeValue = try? container.decode(String.self, forKey: .DisLatitude) {
            self.latitudeOfOffice = Double(latitudeValue)
        } else {
            self.latitudeOfOffice = nil
        }
        if let longitudeValue = try? container.decode(String.self, forKey: .DisLongitude) {
            self.longitudeOfOffice = Double(longitudeValue)
        } else {
            self.longitudeOfOffice = nil
        }
    }
    
    init(from mngObj: NSManagedObject) throws {
        
        self.typeOfOffice = mngObj.value(forKey: CodingKeys.DisTyp.getKeyOfData()) as? String
        self.idOfOffice = mngObj.value(forKey: CodingKeys.DisId.getKeyOfData()) as? String
        self.kzOfOffice = mngObj.value(forKey: CodingKeys.DisKz.getKeyOfData()) as? String
        self.nameOfOffice = mngObj.value(forKey: CodingKeys.DisNameLang.getKeyOfData()) as? String
        self.bIdOffice = mngObj.value(forKey: CodingKeys.DisBld.getKeyOfData()) as? String
        if let zipCodeValue = mngObj.value(forKey: CodingKeys.DisPlz.getKeyOfData()) as? Int {
            self.zipCodeOfOffice = zipCodeValue
        } else {
            self.zipCodeOfOffice = nil
        }
        self.cityOfOffice = mngObj.value(forKey: CodingKeys.DisOrt.getKeyOfData()) as? String
        self.addressOfOffice = mngObj.value(forKey: CodingKeys.DisStrasse.getKeyOfData()) as? String
        self.teleNetworkOfOffice = mngObj.value(forKey: CodingKeys.DiSTelvw.getKeyOfData()) as? String
        self.telephoneNumberOfOffice = mngObj.value(forKey: CodingKeys.DisTel.getKeyOfData()) as? String
        self.faxNumberOfOffice = mngObj.value(forKey: CodingKeys.DisFax.getKeyOfData()) as? String
        self.bLZOfOffice = mngObj.value(forKey: CodingKeys.DisBlz.getKeyOfData()) as? String
        self.bankBezOfOffice = mngObj.value(forKey: CodingKeys.DisBankbez.getKeyOfData()) as? String
        self.giroOfOffice = mngObj.value(forKey: CodingKeys.DisGiro.getKeyOfData()) as? String
        self.bicOfOffice = mngObj.value(forKey: CodingKeys.DisBic.getKeyOfData()) as? String
        self.ibanOfOffice = mngObj.value(forKey: CodingKeys.DisIban.getKeyOfData()) as? String
        self.dvrOfOffice = mngObj.value(forKey: CodingKeys.DisDVR.getKeyOfData()) as? String
        self.openingTimeOfOffice = mngObj.value(forKey: CodingKeys.DisOeffnung.getKeyOfData()) as? String
        self.imageURLOfOffice = mngObj.value(forKey: CodingKeys.DisFotoUrl.getKeyOfData()) as? String
        if let latitudeValue = mngObj.value(forKey: CodingKeys.DisLatitude.getKeyOfData()) as? Double {
            self.latitudeOfOffice = latitudeValue
        } else {
            self.latitudeOfOffice = nil
        }
        if let longitudeValue = mngObj.value(forKey: CodingKeys.DisLongitude.getKeyOfData()) as? Double {
            self.longitudeOfOffice = longitudeValue
        } else {
            self.longitudeOfOffice = nil
        }
    }

}



