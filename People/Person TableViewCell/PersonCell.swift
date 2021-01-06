//
//  PersonCell.swift
//  People
//
//  Created by Nishant Taneja on 06/01/21.
//

import UIKit

class PersonCell: UITableViewCell {
    // Variable
    var person: Person? {
        willSet {
            if newValue != nil {
                updateCell(with: newValue!)
            }
        }
    }
    
    // IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    // IBAction
    @IBAction func removeButtonPressed(_ sender: UIButton!) {}
}

//MARK:- Supporting Methods
extension PersonCell {
    private func updateCell(with person: Person) {
        nameLabel.text = "\(person.first_name) \(person.last_name)"
        genderLabel.text = person.gender
        stateLabel.text = person.state
    }
}

//MARK:- Static Members
extension PersonCell {
    static let cellID = "PersonCell"
    static let cellNib = UINib(nibName: "PersonCell", bundle: nil)
}
