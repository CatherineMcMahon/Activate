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

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBOutlet weak var backButton: UIButton!

    @IBAction func back () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func done() {
        var userEmail                 = email.text
        userEmail                     = userEmail.lowercaseString

        var userPassword          = password.text

        PFUser.logInWithUsernameInBackground(userEmail, password:userPassword) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("loginToTimeline", sender: self)
                }
            } else {
                    println("**login ERROR**")
                }
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
