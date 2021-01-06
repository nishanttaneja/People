//
//  EnrollPersonVC.swift
//  People
//
//  Created by Nishant Taneja on 06/01/21.
//

import UIKit

class EnrollPersonVC: UIViewController {
    // IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var hometownTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var telephoneNumberTextField: UITextField!
    
    // IBActions
    @IBAction func selectProfilePhotoButtonPressed(_ sender: UIButton) {}
    @IBAction func addUserButtonPressed(_ sender: UIButton) {}
}

//MARK:- Override View
extension EnrollPersonVC {}

//MARK:- Static Members
extension EnrollPersonVC {
    static let storyboardID = "EnrollPersonController"
}
