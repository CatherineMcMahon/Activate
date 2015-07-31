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
    
//    func ==(lhs: Self, rhs: Self) -> Bool {
    
//        return (lhs.title==rhs.title && lhs.body==rhs.body && lhs.signature==rhs.signature)
//    }
//    
//    func ==(lhs: Petition, rhs: Petition) -> Bool {
//        return lhs.title == rhs.title && lhs.body == rhs.body
//    }
}