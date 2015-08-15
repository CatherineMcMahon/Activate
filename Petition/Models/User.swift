//
//  User.swift
//  Petition
//
//  Created by Catherine on 8/5/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation

struct User {
    
    var password: String?
    var email:    String?
    var firstName: String?
    var lastName: String?
    var zipcode: String?
    var objectId: String?
    
    init(password: String?, email: String?, firstName: String?, lastName: String?, zipcode: String?, objectId: String?) {

        self.password = password
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.zipcode = zipcode
        self.objectId = objectId

    }
}