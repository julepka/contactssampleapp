//
//  JsonParser.swift
//  SampleApplication
//
//  Created by Julia Potapenko on 5.07.2017.
//  Copyright © 2017 Julia Potapenko. All rights reserved.
//

import Foundation
import CoreData

class JsonParser {
    
    func parseContacts(file filename: String, context: NSManagedObjectContext) {
        do {
            if let file = Bundle.main.url(forResource: filename, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let contactList = json as? [[String: Any]] {
                    for contact in contactList {
                        let newContact = ContactMO(context: context)
                        newContact.contactID = contact["contactID"] as? String ?? ""
                        newContact.firstName = contact["firstName"] as? String ?? ""
                        newContact.lastName = contact["lastName"] as? String ?? ""
                        newContact.phoneNumber = contact["phoneNumber"] as? String ?? ""
                        newContact.streetAddress1 = contact["streetAddress1"] as? String ?? ""
                        newContact.streetAddress2 = contact["streetAddress2"] as? String ?? ""
                        newContact.city = contact["city"] as? String ?? ""
                        newContact.state = contact["state"] as? String ?? ""
                        newContact.zipCode = contact["zipCode"] as? String ?? ""
                    }
                } else {
                    print("Invalid JSON format. JSON Dictionary was expected.")
                }
            } else {
                print("JSON file not found")
            }
        } catch {
            print("Error parsing JSON file")
            print(error.localizedDescription)
        }
    }
    
}
