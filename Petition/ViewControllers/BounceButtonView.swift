//
//  BounceButtonView.swift
//  Petition
//
//  Created by Catherine on 8/1/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation
import ASOAnimatedButton
import UIKit
import Parse

class BounceButtonView: ASOBounceButtonView {
    
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var sign: UIButton!

    var petition: Petition?
    var petitionId: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var zipcode: String?
    
    
    // MARK: Sign Petition
    @IBAction func sign(sender: UIButton) {
        if let currentUser        = PFUser.currentUser() {
            signPetition()
        } else {
            //prompt user to sign up or login
            println("user is not signed in; cannot sign petition")
        }
    }
    
    func signPetition() -> Bool {
        
        if let currentUser        = PFUser.currentUser() {
            email                     = currentUser.email!
            firstName                 = (currentUser.objectForKey("firstName") as? String!)!
            lastName                  = (currentUser.objectForKey("lastName") as? String!)!
            zipcode                   = (currentUser.objectForKey("zipcode") as? String!)!
        }
        
        var request               = NSMutableURLRequest(URL: NSURL(string: "https://api.whitehouse.gov/v1/signatures.json?api_key=tENvi3GKDSyP1CVV4uVX4iDdxXj5eNMtkbFMFFqM")!)
        var session               = NSURLSession.sharedSession()
        request.HTTPMethod        = "POST"
        
        var params                = ["petition_id": petitionId!, "email": email!, "firstName": firstName!, "last_name": lastName!, "zip": zipcode! ] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPBody          = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task                  = session.dataTaskWithRequest(request, completionHandler:
            {data, response, error -> Void in
                println("Response: \(response)")
                var strData               = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)")
                var err: NSError?
                var json                  = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
                
                if(err != nil) {
                    println(err!.localizedDescription)
                    let jsonStr               = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: '\(jsonStr)'")
                }
                else {
                    
                    if let parseJSON          = json {
                        var status                = parseJSON["developerMessage"] as? Int
                        println("Success: \(status)")
                    }
                    else {
                        let jsonStr               = NSString(data: data, encoding: NSUTF8StringEncoding)
                        println("Error could not parse JSON: \(jsonStr)")
                    }
                }
        })
        
        task.resume()
        return true
    }
}