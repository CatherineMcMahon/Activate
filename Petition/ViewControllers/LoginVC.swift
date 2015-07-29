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

    @IBOutlet weak var eml: UITextField!
    @IBOutlet weak var pswd: UITextField!

    var actInd: UIActivityIndicatorView    = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView

    override func viewDidLoad() {
        super.viewDidLoad()

    self.actInd.center                     = self.view.center

    self.actInd.hidesWhenStopped           = true

    self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray

        view.addSubview(self.actInd)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
