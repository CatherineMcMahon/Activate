//
//  ContentVC.swift
//  Petition
//
//  Created by Catherine on 7/30/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.

import Foundation

class ContentVC: UIViewController {

    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailBody: UILabel!
    
    @IBOutlet var tableView: UIView!
    
    var courseName = [String]()
        
    @IBAction func back () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sign(sender: UIButton) {
        signPetition()
    }
    
    // White House API 'sign' 
    func signPetition() -> Bool {
        
        var request        = NSMutableURLRequest(URL: NSURL(string: "https://api.whitehouse.gov/v1/signatures.json?api_key=tENvi3GKDSyP1CVV4uVX4iDdxXj5eNMtkbFMFFqM")!)
        var session        = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"

        var params         = ["petition_id": "test", "email":"thisIsAnEmail", "first_name":"Catherine", "last_name":"McMahon", "zip":"ziiiiipycode"] as Dictionary<String, String>
        // CHANGE values to parse User info.

        var err: NSError?
        request.HTTPBody   = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        var task           = session.dataTaskWithRequest(request, completionHandler:
            {data, response, error -> Void in
            println("Response: \(response)")
        var strData        = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
        var json           = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary

            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
        let jsonStr        = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
        if let parseJSON   = json {
                    // parsedJSON is here, let's get the value for 'success' out of it
        var status        = parseJSON["developerMessage"] as? Int
                    println("Success: \(status)")
                }
                else {
                    // json object = nil
        let jsonStr        = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })

        task.resume()
        return true
    }
}