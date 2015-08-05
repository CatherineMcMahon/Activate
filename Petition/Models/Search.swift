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
    var dateCreated: String?
    var signatures: String?
    var signaturesNeeded: String?
    var signatureThreshold: String?
    
    init(petitionId: String?, title: String?, body: String?, dateCreated: String?, signatures: String?, signaturesNeeded: String?, signatureThreshold: String?) {
    self.title = title
    self.body = body
    self.dateCreated = dateCreated
    self.signatures = signatures
    self.signaturesNeeded = signaturesNeeded
    self.signatureThreshold = signatureThreshold
    }
}