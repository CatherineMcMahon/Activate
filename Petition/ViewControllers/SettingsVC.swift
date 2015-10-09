
//  SettingsVC.swift
//  Petition
//
//  Created by Catherine on 8/3/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI
import Mixpanel

class SettingsVC: UITableViewController {
    
    var currentUser = PFUser.currentUser()
    
    @IBAction func logout(sender: AnyObject) {
        
        // MARK: Mixpanel 'Logged out'
//        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//        mixpanel.track("Logged Out")
        

         func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.hidden = false
        }
        
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if let error    = error {
//                showAlert()
                print("log out did not work")
            } else {
                self.performSegueWithIdentifier("logOut", sender: nil)
            }
        }
    }
    
    
    @IBAction func twitter(sender: AnyObject) {
        
        // MARK: Mixpanel 'Setting: Twitter'
//        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//        mixpanel.track("Setting: Twitter")
        

        if let url = NSURL(string: "https://twitter.com/activateapp") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func facebook(sender: AnyObject) {
//        
//        // MARK: Mixpanel 'Setting: Facebook'
//        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//        mixpanel.track("Setting: Facebook")
        
        if let url = NSURL(string: "https://www.facebook.com/activateapp?_rdr=p") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func feedback(sender: AnyObject) {
        
        // MARK: Mixpanel 'Setting: Feedback'
//        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//        mixpanel.track("Setting: Feedback")
        
        if let url = NSURL(string: "http://goo.gl/forms/6Py5fOmVwF") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func privacy(sender: AnyObject) {
        
        // MARK: Mixpanel 'Setting: Privacy'
//        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//        mixpanel.track("Setting: Privacy")
        
        if let url = NSURL(string: "http://on.fb.me/1K1ruh5") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    @IBAction func rateApp(sender: AnyObject) {
        
        // MARK: Mixpanel 'Setting: rateApp'
//        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//        mixpanel.track("Setting: rateApp")
        
        if let url = NSURL(string: "https://t.co/zYmY7lheww") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    
}