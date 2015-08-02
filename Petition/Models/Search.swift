//
//  Search.swift
//  Petition
//
//  Created by Catherine on 8/3/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation

struct Search {
    
    var petitionId: String?
    var title: String?
    var body: String?
    
    init(petitionId: String?, title: String?, body: String?) {
    self.petitionId = petitionId
    self.title = title
    self.body = body
    }
}