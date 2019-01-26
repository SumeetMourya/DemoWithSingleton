//
//  CoreDataManager.swift
//  Offices
//
//  Created by sumeet mourya on 26/01/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import CoreData


class CoreDataManager {
    
    static let sharedDatabaseManager = CoreDataManager()
    typealias VoidCompletion = () -> ()
    
    var entityNameOffice: String = "Office"

//    var appDelegate: UIApplicationDelegate?
    
    lazy var persistentContainer: NSPersistentContainer? = {
        let persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return persistentContainer
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        return persistentContainer?.viewContext
    }()
    
    lazy var backgroundManagedObjectContext: NSManagedObjectContext? = {
        return persistentContainer?.newBackgroundContext()
    }()
    
    
    // MARK: - Convenience Init
    private var modelName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    

    convenience init(modelName model: String) {
        self.init()
        modelName = model
//        DispatchQueue.main.async() {
//            self.appDelegate = UIApplication.shared.delegate as! AppDelegate
//        }
    }
    
    func save() {
        
        guard let context = managedObjectContext else {
            return
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteAllRecords(withEntityName: String) {
        
        guard let context = managedObjectContext else {
            return
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: withEntityName)
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            // Error Handling
        }
        
    }
    
    func saveData(officesData: [ListOfOfficesItem]) {
        
        //Instead of delete all records first then insert all data get from API
        //If we first check which office data is available then only update that.
        //Then we need to apply any one of the algorythm (e.g. bubble).
        //check one office data is present in in core data and then either update it or delete it.
        self.deleteAllRecords(withEntityName: self.entityNameOffice)
        self.save()
        
        for data: ListOfOfficesItem in officesData {
            
            if let managedOBJ = CoreDataManager.sharedDatabaseManager.managedObjectContext, let entity = NSEntityDescription.entity(forEntityName: self.entityNameOffice, in: managedOBJ) {
                
                let officeData = NSManagedObject(entity: entity, insertInto: managedOBJ)
                
                officeData.setValue(data.typeOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisTyp.getKeyOfData())
                officeData.setValue(data.idOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisId.getKeyOfData())
                officeData.setValue(data.kzOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisKz.getKeyOfData())
                officeData.setValue(data.nameOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisNameLang.getKeyOfData())
                officeData.setValue(data.bIdOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisBld.getKeyOfData())
                officeData.setValue(data.zipCodeOfOffice, forKey: ListOfOfficesItem.CodingKeys.DisPlz.getKeyOfData())
                officeData.setValue(data.cityOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisOrt.getKeyOfData())
                officeData.setValue(data.addressOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisStrasse.getKeyOfData())
                officeData.setValue(data.teleNetworkOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DiSTelvw.getKeyOfData())
                officeData.setValue(data.telephoneNumberOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisTel.getKeyOfData())
                officeData.setValue(data.faxNumberOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisFax.getKeyOfData())
                officeData.setValue(data.bLZOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisBlz.getKeyOfData())
                officeData.setValue(data.bankBezOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisBankbez.getKeyOfData())
                officeData.setValue(data.giroOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisGiro.getKeyOfData())
                officeData.setValue(data.bicOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisBic.getKeyOfData())
                officeData.setValue(data.ibanOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisIban.getKeyOfData())
                officeData.setValue(data.dvrOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisDVR.getKeyOfData())
                officeData.setValue(data.openingTimeOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisOeffnung.getKeyOfData())
                officeData.setValue(data.imageURLOfOffice ?? "", forKey: ListOfOfficesItem.CodingKeys.DisFotoUrl.getKeyOfData())
                officeData.setValue(data.latitudeOfOffice, forKey: ListOfOfficesItem.CodingKeys.DisLatitude.getKeyOfData())
                officeData.setValue(data.longitudeOfOffice, forKey: ListOfOfficesItem.CodingKeys.DisLongitude.getKeyOfData())
            }
        }
        
        CoreDataManager.sharedDatabaseManager.save()
        
        
    }
    
    func getOfficeDataFromLocal() -> [ListOfOfficesItem] {
        
        var offices = [ListOfOfficesItem] ()
        
        guard let context = CoreDataManager.sharedDatabaseManager.managedObjectContext else {
            return offices
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityNameOffice)
        
        request.sortDescriptors = [NSSortDescriptor(key: "\(ListOfOfficesItem.CodingKeys.DisPlz.getKeyOfData())", ascending: true)]
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let officeValue: ListOfOfficesItem = try? ListOfOfficesItem(from: data) {
                    offices.append(officeValue)
                }
            }
            
            return offices
            
        } catch {
            print("Failed")
            return offices
        }
    }

    
}

