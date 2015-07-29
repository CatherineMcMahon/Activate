//
//  ViewController.swift
//  Petition
//
//  Created by Catherine on 7/15/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//
// PFUser.logout -> sets user to nil (log out button) Later

import UIKit
import Parse
import ParseUI

class MainVC: UIViewController {
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var guest: UIButton!
    
    var LoginVC: PFLogInViewController! = PFLogInViewController()
    var SignUpVC: PFSignUpViewController! = PFSignUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
       
    /*func getPetitionID() {
        var url : String = "https://api.whitehouse.gov/v1/petitions.json?limit=5&createdAfter=1104581532/FaJcrs2u4kZcKf0lnYgY0WYTEhfek8qBBxjOyUzQ.json"
        
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary!                          = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if(jsonResult != nil) {
                let pList: AnyObject? = jsonResult["results"]
                println(pList)
            } else {
                println(error)
            }
        })
    }*/
}