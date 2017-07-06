//
//  ContactViewController.swift
//  SampleApplication
//
//  Created by Julia Potapenko on 5.07.2017.
//  Copyright © 2017 Julia Potapenko. All rights reserved.
//

import Foundation
import UIKit

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTitle: UILabel!
    
    var contact: ContactMO? = nil
    
    let sections = ["Phone Number", "Address"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FieldCell")
        tableView.register(MultilineTableViewCell.classForCoder(), forCellReuseIdentifier: "MultilineTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nameString = "\(contact?.firstName ?? "") \(contact?.lastName ?? "")"
        nameTitle.text = nameString.characters.count > 1 ? nameString : "Contact"
        
        tableView.reloadData()
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FieldCell", for: indexPath)
            cell.textLabel?.text = "\(contact?.phoneNumber ?? "")"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MultilineTableViewCell") as! MultilineTableViewCell
            cell.multilineTextLabel.text = getAddressString()
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func getAddressString() -> String {
        var result = ""
        if let streetAddress1 = contact?.streetAddress1 {
            if streetAddress1 != "" {
                result.append(streetAddress1)
            }
        }
        if let streetAddress2 = contact?.streetAddress2 {
            if streetAddress2 != "" {
                result.append(" \(streetAddress2)")
            }
        }
        if let city = contact?.city {
            if city != "" {
                result.append("\n\(city)")
            }
        }
        if let state = contact?.state {
            if state != "" {
                result.append(" \(state)")
            }
        }
        if let zipCode = contact?.zipCode {
            if zipCode != "" {
                result.append("\n\(zipCode)")
            }
        }
        return result
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditContact") {
            let controller = segue.destination as! EditContactViewController
            controller.title = "Edit Contact"
            controller.contact = self.contact
        }
    }
    
}
