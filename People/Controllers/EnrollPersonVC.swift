//
//  EnrollPersonVC.swift
//  People
//
//  Created by Nishant Taneja on 06/01/21.
//

import UIKit

class EnrollPersonVC: UIViewController {
    // Constant
    private let imagePicketController = UIImagePickerController()
    
    // IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var selectProfilePhotoButton: UIButton!
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
    @IBAction func profilePhotoButtonPressed(_ sender: UIButton) {
        present(imagePicketController, animated: true, completion: nil)
    }
    @IBAction func selectProfilePhotoButtonPressed(_ sender: UIButton) {
        present(imagePicketController, animated: true, completion: nil)
    }
    @IBAction func addUserButtonPressed(_ sender: UIButton) {
        ApplicationManager.enrollPersonWith(image: profileImageView.image!, first_name: firstNameTextField.text!, last_name: lastNameTextField.text!, date_of_birth: dateOfBirthTextField.text!, gender: genderTextField.text!, country: countryTextField.text!, state: stateTextField.text!, hometown: hometownTextField.text!, phone_number: phoneNumberTextField.text!, telephone_number: telephoneNumberTextField.text!)
    }
}

//MARK:- UIImagePickerController
extension EnrollPersonVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            profileImageView.image = selectedImage
            selectProfilePhotoButton.setTitle("Update Profile Photo?", for: .normal)
            selectProfilePhotoButton.setTitleColor(.green, for: .normal)
            dismiss(animated: true, completion: nil)
        }
    }
}

//MARK:- Override View
extension EnrollPersonVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 25
        imagePicketController.sourceType = .photoLibrary
        imagePicketController.allowsEditing = true
        imagePicketController.delegate = self
    }
}

//MARK:- Static Members
extension EnrollPersonVC {
    static let storyboardID = "EnrollPersonController"
}
