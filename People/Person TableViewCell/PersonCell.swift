//
//  PersonCell.swift
//  People
//
//  Created by Nishant Taneja on 06/01/21.
//

import UIKit

class PersonCell: UITableViewCell {
    // Variable
    var delegate: PersonCellDelegate?
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
    @IBAction func removeButtonPressed(_ sender: UIButton!) {
        if person != nil {
            delegate?.didSelectRemoveOption(for: person!)
        }
    }
}

//MARK:- Supporting Methods
extension PersonCell {
    private func updateCell(with person: Person) {
        DispatchQueue.main.async {
            self.profileImageView.image = UIImage(systemName: "person.fill")
            ApplicationManager.didFetchImage(for: person) { (image) in
                if person.phone_number == self.person?.phone_number {
                    self.profileImageView.image = image
                }
            }
            self.nameLabel.text = "\(person.first_name) \(person.last_name)"
            self.genderLabel.text = person.gender
            self.stateLabel.text = person.state
            self.ageLabel.text = String(Date.age(from: person.date_of_birth, with: "MM-dd-yyyy"))
        }
    }
}

//MARK:- Override Nib
extension PersonCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 25
    }
}

//MARK:- Static Members
extension PersonCell {
    static let cellID = "PersonCell"
    static let cellNib = UINib(nibName: "PersonCell", bundle: nil)
}
