//
//  Petition.swift
//  Petition
//
//  Created by Catherine on 7/24/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation

struct Petition {
    
    var title: String?
    var body: String?
    var petitionId:    String?
    var color: UIColor?
    
    init(title: String?, body: String?, petitionId: String?, color: UIColor?) {
        self.title = title
        self.body = body
        self.petitionId = petitionId
        self.color = color
    }
}