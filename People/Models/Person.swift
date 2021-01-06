//
//  Person.swift
//  People
//
//  Created by Nishant Taneja on 06/01/21.
//

import UIKit

struct Person: Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let date_of_birth: String
    let gender: String
    let country: String
    let state: String
    let hometown: String
    let phone_number: String
    let telephone_number: String
}
