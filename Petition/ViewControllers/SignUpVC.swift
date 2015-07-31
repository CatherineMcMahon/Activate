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

class SignUpVC: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func done(sender: AnyObject) {
        var user = PFUser()
        user.password = password.text
        user.email = email.text
        // other fields can be set just like with PFObject
        user["firstName"] = firstName.text
        user["lastName"] = lastName.text
        user["address"] = address.text
        user["city"] = city.text
        user["state"] = state.text
        user["country"] = country.text
        user["zipcode"] = zipcode.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // use the app!
            }
        }
    }

    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}