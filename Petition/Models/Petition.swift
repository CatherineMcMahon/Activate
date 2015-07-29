//
//  Petition.swift
//  Petition
//
//  Created by Catherine on 7/24/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation

struct Petition
{
    var title: String?
    var body: String?
    var signature: String?
    
    init(title: String?, body: String?, signature: String?) {
        self.title = title
        self.body = body
        self.signature = signature
    }
}