//
//  LoginVC.swift
//  Petition
//
//  Created by Catherine on 7/21/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation
import UIKit
import Mixpanel
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
        
        if email.hasText() && password.hasText() {
            
            PFUser.logInWithUsernameInBackground(userEmail!, password:userPassword!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    
                    // MARK: Mixpanel 'Successful login'
//                    Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//                    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//                    mixpanel.track("Successful login")
                    
                    self.performSegueWithIdentifier("loginToTimeline", sender: self)
                    
                } else {
                    print("**login ERROR**")                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all the fields", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            // MARK: Mixpanel 'Unsuccessful login'
//            Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//            mixpanel.track("Unsuccessful login")

            
        }
    }
}
