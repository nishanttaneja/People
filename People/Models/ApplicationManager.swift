//
//  ApplicationManager.swift
//  People
//
//  Created by Nishant Taneja on 06/01/21.
//

import Foundation
import Firebase
import FirebaseStorage

struct ApplicationManager {
    static let databaseReference = Database.database().reference()
    static let storageReference = Storage.storage().reference()
    
    static var imageWithName = [String : UIImage?]()
    
    static func enroll(_ person: Person) {
        didReadPeople(onCompletion: { (people) in
            if !people.contains(where: { $0.phone_number == person.phone_number }) {
                setValues(for: person)
            }
        })
    }
        
    static func setValues(for person: Person) {
        databaseReference.child("\(person.phone_number)/first_name").setValue(person.first_name)
        databaseReference.child("\(person.phone_number)/last_name").setValue(person.last_name)
        databaseReference.child("\(person.phone_number)/date_of_birth").setValue(person.date_of_birth)
        databaseReference.child("\(person.phone_number)/gender").setValue(person.gender)
        databaseReference.child("\(person.phone_number)/country").setValue(person.country)
        databaseReference.child("\(person.phone_number)/state").setValue(person.state)
        databaseReference.child("\(person.phone_number)/hometown").setValue(person.hometown)
        databaseReference.child("\(person.phone_number)/phone_number").setValue(person.phone_number)
        databaseReference.child("\(person.phone_number)/telephone_number").setValue(person.telephone_number)
    }
    
    static func didReadPeople(onCompletion: @escaping (_ people: [Person]) -> Void) {
        var people = [Person]()
        databaseReference.observeSingleEvent(of: .value) { (snapshot) in
            guard let data = snapshot.value as? [String : Any] else { return onCompletion(people) }
            data.forEach { (_, value) in
                if let decodedPerson = try? decodePerson(form: value) {
                    people.append(decodedPerson)
                }
            }
            onCompletion(people)
        }
    }
    
    static func decodePerson(form snapshotValue: Any) throws -> Person? {
        return try JSONDecoder().decode(
            Person.self,
            from: try JSONSerialization.data(withJSONObject: snapshotValue, options: [])
        )
    }
    
    
    static func uploadImage(_ image: UIImage, at path: String) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            storageReference.child(path).putData(data, metadata: metadata)
        }
    }
    
    static func didFetchImage(for person: Person, executeAfterCompletion onCompletion: @escaping (_ image: UIImage?) -> Void) {
        print("looking for image...")
        if let image = imageWithName[person.phone_number] {
            print("found image")
            onCompletion(image)
            return
        }
        print("downloading image...")
        storageReference.child(person.phone_number).getData(maxSize: 1*1024*1024) { (data, error) in
            if let data = data {
                print("downloaded image")
                let image = UIImage(data: data)
                imageWithName.updateValue(image, forKey: person.phone_number)
                onCompletion(image)
            }
        }
    }

}
