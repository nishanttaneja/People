//
//  PeopleListTVC.swift
//  People
//
//  Created by Nishant Taneja on 06/01/21.
//

import UIKit

class PeopleListTVC: UITableViewController {
    private var people = [Person]()
    
    private var observeChanges = false {
        willSet {
            if newValue {
                observeAddition()
                observeDeletion()
            }
        }
    }
}

//MARK:- Supporting Methods
extension PeopleListTVC {
    private func observeAddition() {
        ApplicationManager.databaseReference.observe(.childAdded) { (snapshot) in
            if let decodedPerson = try? ApplicationManager.decodePerson(form: snapshot.value!) {
                if !self.people.contains(where: { $0.phone_number == decodedPerson.phone_number }) {
                    self.people.insert(decodedPerson, at: 0)
                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                }
            }
        }
    }
    private func observeDeletion() {
        ApplicationManager.databaseReference.observe(.childRemoved) { (snapshot) in
            if let decodedPerson = try? ApplicationManager.decodePerson(form: snapshot.value!) {
                if let index = self.people.firstIndex(where: { $0.phone_number == decodedPerson.phone_number }) {
                    self.people.remove(at: index)
                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
        }
    }
}

//MARK:- Override UITableView Delegate
extension PeopleListTVC {}

//MARK:- Override UITableView DataSource
extension PeopleListTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

//MARK:- Override View
extension PeopleListTVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeChanges = true
    }
}

//MARK:- Static Members
extension PeopleListTVC {
    static let storyboardID = "PeopleListController"
}
