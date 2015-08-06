//
//  ContentVC.swift
//  Petition
//
//  Created by Catherine on 7/30/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.

import Foundation
import ParseUI
import Parse

class ContentVC: UIViewController {

    var petition: Petition?
    var petitionId: String?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailBody: UILabel!

    func petitionDetail() {

        if(detailTitle != nil && detailBody != nil && petitionId != nil) {
detailTitle.text   = petition!.title
detailBody.text    = petition!.body
petitionId         = petition!.petitionId
        }
    }

    func userDetail() {

if let currentUser = PFUser.currentUser() {
var email          = currentUser.email
var firstName      = currentUser.objectForKey("firstName")
var lastName       = currentUser.objectForKey("lastName")
var zipcode        = currentUser.objectForKey("zipcode")

//            var firstName = user!.firstName
//            var lastName = user!.lastName
//            var zipcode = user!.zipcode
//            var objectId = user!.objectId
        }
    }

    @IBOutlet var tableView: UIView!

    @IBAction func back () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        petitionDetail()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sign(sender: UIButton) {
//        if (User.userIsAnonymous() == true) {
//            promptUserToSignUp()
//        } else {
        signPetition()
//    }
    }

    // MARK: - Sign Petition
    func signPetition() -> Bool {

var request        = NSMutableURLRequest(URL: NSURL(string: "https://api.whitehouse.gov/v1/signatures.json?api_key=tENvi3GKDSyP1CVV4uVX4iDdxXj5eNMtkbFMFFqM")!)
var session        = NSURLSession.sharedSession()
request.HTTPMethod = "POST"

//var params         = ["petition_id": petitionId!, "email":User.email,"firstName": User.firstName, "last_name": User.lastName, "zip": User.zipcode] as Dictionary<String, String>

//    var params         = ["petition_id": petitionId!, "email": email,"firstName": firstName, "last_name": lastName, "zip": zipcode] as Dictionary<String, String>

var params         = ["petition_id": petitionId!, "email": "cmcmahon@headroyce.org", "firstName": "Catherine", "last_name": "McMahon", "zip": "94502"] as Dictionary<String, String>
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
var status         = parseJSON["developerMessage"] as? Int
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