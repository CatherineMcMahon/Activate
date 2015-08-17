//
//  ViewController.swift
//  Petition
//
//  Created by Catherine on 7/15/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
// test:
//
// PFUser.logout -> sets user to nil (log out button) Later

import UIKit
import Parse
import Mixpanel

class MainVC: UIViewController {

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var guest: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        }
}