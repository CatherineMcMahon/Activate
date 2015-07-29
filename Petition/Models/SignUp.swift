//
//  signUp.swift
//  Petition
//
//  Created by Catherine on 7/27/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//


import Foundation

struct SignUp
{
    var firstName: String?
    var lastName: String?
    var address: String?
    var city: String?
    var state: String?
    var country: String?
    var zipcode: String?
    var email: String?
    var password: String?

    
    init(firstName: String, lastName: String?) {
        self.firstName = firstName
        self.lastName = lastName
    }
}