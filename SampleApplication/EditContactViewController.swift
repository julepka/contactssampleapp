//
//  EditContactViewController.swift
//  SampleApplication
//
//  Created by Julia Potapenko on 5.07.2017.
//  Copyright © 2017 Julia Potapenko. All rights reserved.
//

import Foundation
import UIKit

class EditContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var contact: ContactMO? = nil
    
    let dataManager = DataManager.sharedInstance
    
    let placeholders = ["First Name", "Last Name", "Phone Number", "Street Address Line 1", "Street Address Line 2", "City", "State", "Zip Code"]
    
    var filledFields: [String] = []
    
    @IBAction func trashButtonAction(sender: UIBarButtonItem) {
        if let currentContact = contact {
            self.dataManager.deleteContact(contact: currentContact)
            contact = nil
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TextFieldTableViewCell.classForCoder(), forCellReuseIdentifier: "TextFieldTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        if contact == nil {
            contact = dataManager.createNewContact()
        }
        
        filledFields.append(contact?.firstName ?? "")
        filledFields.append(contact?.lastName ?? "")
        filledFields.append(contact?.phoneNumber ?? "")
        filledFields.append(contact?.streetAddress1 ?? "")
        filledFields.append(contact?.streetAddress2 ?? "")
        filledFields.append(contact?.city ?? "")
        filledFields.append(contact?.state ?? "")
        filledFields.append(contact?.zipCode ?? "")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for index in 0..<placeholders.count {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! TextFieldTableViewCell
            switch index {
            case 0:
                contact?.firstName = cell.textField.text
                break
            case 1:
                contact?.lastName = cell.textField.text
                break
            case 2:
                contact?.phoneNumber = cell.textField.text
                break
            case 3:
                contact?.streetAddress1 = cell.textField.text
                break
            case 4:
                contact?.streetAddress2 = cell.textField.text
                break
            case 5:
                contact?.city = cell.textField.text
                break
            case 6:
                contact?.state = cell.textField.text
                break
            case 7:
                contact?.zipCode = cell.textField.text
                break
            default:
                break
            }
        }
        dataManager.saveContext()
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell") as! TextFieldTableViewCell
        cell.textField.placeholder = placeholders[indexPath.row]
        if filledFields.count == placeholders.count {
            cell.textField.text = filledFields[indexPath.row]
        }
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
    }
}
