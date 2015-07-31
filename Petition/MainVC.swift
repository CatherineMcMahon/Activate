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

class MainVC: UIViewController {
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var guest: UIButton!
    
//    var LoginVC: PFLogInViewController! = PFLogInViewController()
//    var SignUpVC: PFSignUpViewController! = PFSignUpViewController()
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
}