//
//  LoginVC.swift
//  Petition
//
//  Created by Catherine on 7/21/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation
import UIKit
import Parse

class LoginVC: UIViewController {
    
    @IBOutlet weak var email: UITextField! // username = email
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    @IBAction func done() {
        var userEmail                 = email.text
        var userPassword          = password.text
        
        PFUser.logInWithUsernameInBackground(userEmail, password:userPassword) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("loginToTimeline", sender: self)
                //                    println(PFUser.object()
                
            } else {
                println("**login ERROR**") //Alert Controller to user
            }
        }
    }
}
