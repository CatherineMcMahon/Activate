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
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    
    var objectId: String?
    //    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidAppear(animated: Bool) {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
        
        var nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.whiteColor()
        
        let customFont = UIFont(name: "Avenir", size: 18.0)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
        
        UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: customFont!]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
    }
    
    private func setupBarStyle() {
        if let font = UIFont(name: "Avenir", size: 18) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
        }
        
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        var attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "Avenir", size: 20)!
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationItem
    }
    
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false
    }
    
    @IBAction func done(sender: AnyObject) {
        if(firstName.text != nil && lastName.text != nil && zipcode.text != nil && email.text != nil && password != nil) {
            signUp()
        } else {
            println("can't sign up. try again")
        }
    }
    
    func signUp() {
        
        if email.hasText() && password.hasText() && firstName.hasText() && lastName.hasText() && zipcode.hasText() {
        
        
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
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all the fields", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
