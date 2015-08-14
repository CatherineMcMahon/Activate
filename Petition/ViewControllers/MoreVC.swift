
//  MoreVC.swift
//  Petition
//
//  Created by Catherine on 8/3/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

class MoreVC: UIViewController {
    
    var currentUser = PFUser.currentUser()
    
    @IBAction func logout(sender: AnyObject) {
        
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if let error    = error {
//                showAlert()
                println("log out did not work")
            } else {
                self.performSegueWithIdentifier("logOut", sender: nil)
            }
        }
    }
}