//
//  PeopleListTVC.swift
//  People
//
//  Created by Nishant Taneja on 06/01/21.
//

import UIKit

class PeopleListTVC: UITableViewController {
    private var people = [Person]()
    private var sortedPeople: [Person] {
        people.sorted(by: { $0.id > $1.id })
    }
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

//MARK:- PersonCell Delegate
extension PeopleListTVC: PersonCellDelegate {
    func didSelectRemoveOption(for person: Person) {
            ApplicationManager.databaseReference.child("\(person.phone_number)").removeValue()
        ApplicationManager.storageReference.child(person.phone_number).delete()
    }
}

//MARK:- Override UITableView Delegate
extension PeopleListTVC {}

//MARK:- Override UITableView DataSource
extension PeopleListTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPeople.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.cellID, for: indexPath) as? PersonCell
        else { return UITableViewCell() }
        cell.delegate = self
        cell.person = sortedPeople[indexPath.row]
        return cell
    }
}

//MARK:- Override View
extension PeopleListTVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PersonCell.cellNib, forCellReuseIdentifier: PersonCell.cellID)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeChanges = true
    }
}

//MARK:- Static Members
extension PeopleListTVC {
    static let storyboardID = "PeopleListController"
}
