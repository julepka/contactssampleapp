//
//  ViewController.swift
//  SampleApplication
//
//  Created by Julia Potapenko on 5.07.2017.
//  Copyright © 2017 Julia Potapenko. All rights reserved.
//

import UIKit

class ContactsListTableViewController: UITableViewController {
    
    let dataManager = DataManager.sharedInstance
    var contacts: [ContactMO] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contacts = dataManager.getContacts()
        self.tableView.reloadData()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contacts = dataManager.getContacts()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        if let firstName = contacts[indexPath.row].firstName {
            if let lastName = contacts[indexPath.row].lastName {
                cell.textLabel?.text = "\(firstName) \(lastName)"
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as? ContactViewController {
            controller.contact = contacts[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            tableView.beginUpdates()
            dataManager.deleteContact(contact: self.contacts[indexPath.row])
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

