//
//  ContentVC.swift
//  Petition
//
//  Created by Catherine on 7/30/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.

import Foundation
import ParseUI
import Parse
import Mixpanel
//import ASOAnimatedButton

class ContentVC: UITableViewController {
    
    var petition: Petition?
    var petitionId: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var zipcode: String?
    var color: UIColor?

    @IBOutlet weak var sign: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailBody: UILabel!

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func petitionDetail() {
        if(detailTitle != nil && detailBody != nil) {
            detailTitle.text          = petition!.title
            detailBody.text           = petition!.body
            petitionId                = petition!.petitionId
            color = petition!.color
            self.tableView.backgroundColor = color
        }
    }
    
//    @IBOutlet var tableView: UIView!
    
    // MARK: Sign Petition
    @IBAction func sign(sender: UIButton) {
        if let currentUser        = PFUser.currentUser() {
            signPetition()
            
            // MARK: Mixpanel 'Signed Petition'
//            Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//            mixpanel.track("Sign Success")

        
        } else {
            //prompt user to sign up or login
            let alert = UIAlertController(title: "Error", message: "You need to sign up or login before you can sign a petition!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)

//            // MARK: Mixpanel 'Sign Error'
//            Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//            mixpanel.track("Sign Error")
            
           print("user is not signed in; cannot sign petition")
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
        
        var params                = ["petition_id": petitionId!, "email": email!, "first_name": firstName!, "last_name": lastName!, "zip": zipcode! ] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPBody          = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task                  = session.dataTaskWithRequest(request, completionHandler:
            {data, response, error -> Void in
                print("Response: \(response)")
                var strData               = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                var err: NSError?
                var json                  = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
                
                if(err != nil) {
                   print(err!.localizedDescription)
                    let jsonStr               = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: '\(jsonStr)'")
                    let alert = UIAlertController(title: "Error", message: "Oops! Something went wrong.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else {
                    
                    if let parseJSON          = json {
                        var status                = parseJSON["developerMessage"] as? Int
                        println("Success: \(status)")
                        
                        let alert = UIAlertController(title: "Successfully Signed", message: "Thanks for signing this petition! You will recieve an email shortly to confirm your signature.", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Error", message: "Oops! Something went wrong.", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
        })
        
        task.resume()
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        petitionDetail()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
