//
//  PeopleListTVC.swift
//  People
//
//  Created by Nishant Taneja on 06/01/21.
//

import UIKit

class PeopleListTVC: UITableViewController {}

//MARK:- Override UITableView Delegate
extension PeopleListTVC {}

//MARK:- Override UITableView DataSource
extension PeopleListTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

//MARK:- Override View
extension PeopleListTVC {}

//MARK:- Static Members
extension PeopleListTVC {
    static let storyboardID = "PeopleListController"
}
