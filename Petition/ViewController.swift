//
//  ViewController.swift
//  Petition
//
//  Created by Catherine on 7/15/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var GuestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("View did load")
        loadAPI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadAPI() {
        var url : String = "https://api.change.org/v1/petitions/get_id?api_key=14775dc2fb91747b998e5c812d5a81dfae7667867cd58bb1258cc95f172fa5bc&petition_url=https://www.change.org/p/tell-ben-jerry-s-you-want-non-dairy-ice-cream-options"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil) {
                println(jsonResult)
                if let id = jsonResult["petition_id"] as? Int {
                    println(id)
                }
                // process jsonResult
            } else {
                println(error)
                // couldn't load JSON, look at error
            }
            
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
    // Create the log in view controller
    PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
    [logInViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Create the sign up view controller
    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
    [signUpViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    
    // Present the log in view controller
    [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    } */
    
    override func viewWillAppear(animated: Bool) {
        // if()
    }
}

