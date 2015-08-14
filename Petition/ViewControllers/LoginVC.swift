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

    override func viewDidAppear(animated: Bool) {
    let tapRecognizer                          = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
    tapRecognizer.numberOfTapsRequired         = 1
    self.view.addGestureRecognizer(tapRecognizer)
}

func handleSingleTap(recognizer: UITapGestureRecognizer) {
    self.view.endEditing(true)
}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    navigationController?.navigationBar.hidden = false
    }


    @IBAction func done() {
    var userEmail                              = email.text
    var userPassword                           = password.text

        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()

    let storyboard                             = UIStoryboard(name: "Main", bundle: nil)
    let vc                                     = storyboard.instantiateViewControllerWithIdentifier("TimelineVC") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)

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
