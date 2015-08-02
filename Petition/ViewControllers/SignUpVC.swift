//
//  SignUpVC.swift
//  Petition
//
//  Created by Catherine on 7/21/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//
import Foundation
import UIKit
import Parse
import ParseUI

class SignUpVC: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var objectId: String?
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func done(sender: AnyObject) {
        if(firstName.text != nil && lastName.text != nil && zipcode.text != nil && email.text != nil && password != nil) {
                signUp()
        } else {
            println("can't sign up. try again")
        }
    }
    
    
        func signUp() {
    var user                            = PFUser()
    user.username                       = email.text
    user.password                       = password.text
    user.email                          = email.text
    user["firstName"]                   = firstName.text
    user["lastName"]                    = lastName.text
    user["zipcode"]                     = zipcode.text
    user.objectId = objectId
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if(succeeded == true) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("signUpToTimeline", sender: self)
                }
            } else {
                    println("**sign up ERROR**")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                
    }
}
