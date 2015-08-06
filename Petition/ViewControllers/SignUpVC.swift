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

    @IBOutlet weak var backButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done(sender: AnyObject) {

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
            if error == nil {
                
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
