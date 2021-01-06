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
    private let datePicker = UIDatePicker()
    private let pickerView = UIPickerView()
    
    private var genders: [String] {
        ["Male", "Female"]
    }
    private var countries: [String] {
        ["India", "UK", "US", "Canada", "Brazil", "France", "Germany"]
    }
    private var states: [String] {
        ["Delhi", "Haryana", "Punjab", "Himachal Pradesh", "Uttar Pradesh", "Maharashtra"]
    }
    
    // IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
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
    @IBAction func selectProfilePhotoButtonPressed(_ sender: UIButton) {
        present(imagePicketController, animated: true, completion: nil)
    }
    @IBAction func addUserButtonPressed(_ sender: UIButton) {
        enroll()
    }
}

//MARK:- Supporting Methods
extension EnrollPersonVC {
    private func enroll() {
        guard profileImageView.image != nil,
              profileImageView.image != UIImage(systemName: "person.fill"),
              firstNameTextField.text != nil,
              !firstNameTextField.text!.isEmpty,
              lastNameTextField.text != nil,
              !lastNameTextField.text!.isEmpty,
              dateOfBirthTextField.text != nil,
              !dateOfBirthTextField.text!.isEmpty,
              genderTextField.text != nil,
              !genderTextField.text!.isEmpty,
              countryTextField.text != nil,
              !countryTextField.text!.isEmpty,
              stateTextField.text != nil,
              !stateTextField.text!.isEmpty,
              hometownTextField.text != nil,
              !hometownTextField.text!.isEmpty,
              phoneNumberTextField.text != nil,
              !phoneNumberTextField.text!.isEmpty,
              telephoneNumberTextField.text != nil,
              !telephoneNumberTextField.text!.isEmpty
        else {
            print("insufficient data")
            return
        }
        ApplicationManager.enrollPersonWith(image: profileImageView.image!, first_name: firstNameTextField.text!, last_name: lastNameTextField.text!, date_of_birth: dateOfBirthTextField.text!, gender: genderTextField.text!, country: countryTextField.text!, state: stateTextField.text!, hometown: hometownTextField.text!, phone_number: phoneNumberTextField.text!, telephone_number: telephoneNumberTextField.text!)
    }
    private func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
        genderTextField.inputView = pickerView
        genderTextField.inputAccessoryView = getToolbar()
    }
    @objc func doneButtonPressed() {
        view.endEditing(true)
    }
    private func getToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: datePicker.frame.width, height: 40))
        toolbar.setItems([
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        ], animated: true)
        return toolbar
    }
    private func updateDOBTextField() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        dateOfBirthTextField.text = dateFormatter.string(from: datePicker.date)
    }
    @objc func datePickerValueDidChange() {
        updateDOBTextField()
    }
    
    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange), for: .valueChanged)
        dateOfBirthTextField.inputView = datePicker
        dateOfBirthTextField.inputAccessoryView = getToolbar()
    }
    private func updateLayers() {
        profileImageView.layer.cornerRadius = 25
    }
    private func configureImagePickerController() {
        imagePicketController.sourceType = .photoLibrary
        imagePicketController.allowsEditing = true
        imagePicketController.delegate = self
    }
    private func configureKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK:- UIPickerView Delegate
extension EnrollPersonVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if genderTextField.isFirstResponder {
            return genders[row]
        } else if countryTextField.isFirstResponder {
            return countries[row]
        } else if stateTextField.isFirstResponder {
            return states[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if genderTextField.isFirstResponder {
            genderTextField.text = genders[row]
        } else if countryTextField.isFirstResponder {
            countryTextField.text = countries[row]
        } else if stateTextField.isFirstResponder {
            stateTextField.text = states[row]
        }
    }
}

//MARK:- UIPickerView DataSource
extension EnrollPersonVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if genderTextField.isFirstResponder {
            return 2
        } else if countryTextField.isFirstResponder {
            return countries.count
        } else if stateTextField.isFirstResponder {
            return states.count
        }
        return 0
    }
}

//MARK:- UIImagePickerControllerDelegate | UINavigationControllerDelegate
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


//MARK:- UITextFieldDelegate
extension EnrollPersonVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == genderTextField {
            genderTextField.inputView = pickerView
            genderTextField.inputAccessoryView = getToolbar()
        } else if textField == countryTextField {
            countryTextField.inputView = pickerView
            countryTextField.inputAccessoryView = getToolbar()
        } else if textField == stateTextField {
            stateTextField.inputView = pickerView
            stateTextField.inputAccessoryView = getToolbar()
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != nil,
           textField.text!.replacingOccurrences(of: " ", with: "").count > 0 {
            textField.layer.borderWidth = 0
            textField.layer.borderColor = .none
            textField.layer.cornerRadius = 0
            return true
        }
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 5
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("didEndEditing")
        if textField == dateOfBirthTextField {
            updateDOBTextField()
        } else if textField == genderTextField,
                  textField.text == "" {
            genderTextField.text = genders[0]
        } else if textField == countryTextField,
                  textField.text == "" {
            countryTextField.text = countries[0]
        } else if textField == stateTextField,
                  textField.text == "" {
            stateTextField.text = states[0]
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("shouldReturn")
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            dateOfBirthTextField.becomeFirstResponder()
        } else if textField == phoneNumberTextField {
            telephoneNumberTextField.becomeFirstResponder()
        } else if textField == telephoneNumberTextField {
            enroll()
        }
        return true
    }
}

//MARK:- Keyboard Will Hide/Show
extension EnrollPersonVC {
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}

//MARK:- Override View
extension EnrollPersonVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayers()
        configureImagePickerController()
        configureDatePicker()
        configurePickerView()
        configureKeyboardObservers()
    }
}

//MARK:- Static Members
extension EnrollPersonVC {
    static let storyboardID = "EnrollPersonController"
}
