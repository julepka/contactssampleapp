//
//  DataManager.swift
//  SampleApplication
//
//  Created by Julia Potapenko on 5.07.2017.
//  Copyright © 2017 Julia Potapenko. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataManager {
    
    static let sharedInstance = DataManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let defaults = UserDefaults.standard
    private let loadedInitialDataKey = "LoadedInitialData"
    
    private var loadedInitialData: Bool {
        return defaults.bool(forKey: loadedInitialDataKey)
    }
    
    private init() {
        if !loadedInitialData {
            loadInitialData()
            defaults.set(true, forKey: loadedInitialDataKey)
        }
    }
    
    private func loadInitialData() {
        JsonParser().parseContacts(file: "InitialData", context: context)
        saveContext()        
    }
    
    func createNewContact() -> ContactMO {
        return ContactMO(context: context)
    }
    
    func deleteContact(contact:ContactMO) {
        context.delete(contact)
        saveContext()
    }
    
    func saveContext() {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func getContacts() -> [ContactMO] {
        do {
            let fetchRequest: NSFetchRequest<ContactMO> = ContactMO.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            return try context.fetch(fetchRequest)
        } catch {
            print("Fetching contacts failed")
            print(error.localizedDescription)
        }
        return []
    }
}
