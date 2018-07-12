//
//  PersonListTableViewController.swift
//  Unit6Test
//
//  Created by Seth Danner on 7/2/18.
//  Copyright © 2018 Seth Danner. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    @IBAction func addNewPersonButtonTapped(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add New Person", message: "Enter new person's name to add them to the list", preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter name..."
        }
        
        let addActionItem = UIAlertAction(title: "Save", style: .default) { (_) in
            
            guard let enteredPerson = alertController.textFields?.first?.text else { return }
            PersonController.shared.addPerson(with: enteredPerson)
            self.tableView.reloadData()
        }
        alertController.addAction(addActionItem)
        
        let cancelActionItem = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelActionItem)
        
        present(alertController, animated: true)
    }
    
    @IBAction func shuffleButtonTapped(_ sender: UIBarButtonItem) {
        
        PersonController.shared.randomizePeople()
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return PersonController.shared.arrayforSections.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        label.text = "Group \(section + 1)"
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if PersonController.shared.arrayforSections[section].count % 2 == 0 {
            return 2
        } else if PersonController.shared.arrayforSections[section].count % 2 == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let person = PersonController.shared.arrayforSections[indexPath.section][indexPath.row]
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removePerson = PersonController.shared.arrayforSections[indexPath.section][indexPath.row]
            PersonController.shared.deletePerson(person: removePerson)
            
            tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
