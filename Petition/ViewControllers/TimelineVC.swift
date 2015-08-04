// PFUser.logout -> sets user to nil (log out button) Later

import UIKit
import Parse
import ConvenienceKit
import SwiftyJSON

class TimelineVC: UIViewController, UITableViewDelegate, UITableViewDataSource, TimelineComponentTarget {

    var cache                        = [String: UILabel]()
    let kCellIdentifier: String      = "ContentViewCell"
    var timelineComponent: TimelineComponents<Petition, TimelineVC>!


    @IBOutlet var tableView: UITableView!
    let defaultRange                 = 0...4
    let additionalRangeSize          = 5

    var tableData                    = []

    override func viewDidLoad() {
        super.viewDidLoad()

    timelineComponent                = TimelineComponents(target: self)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timelineComponent.loadInitialIfRequired()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.tableData.count
        // println(timelineComponent.content.count)
        return timelineComponent.content.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell                         = tableView.dequeueReusableCellWithIdentifier("ContentViewCell") as! ContentViewCell

    let petition                     = timelineComponent.content[indexPath.row]
    cell.postTitle.text              = petition.title
    cell.postDesc.text               = petition.body
    cell.postId.text                 = petition.id
    timelineComponent.targetWillDisplayEntry(indexPath.row)

    var r                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
    var g                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
    var b                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)

        if(r == b && r == g && g == b) {
    r                                = CGFloat( CGFloat(arc4random()) % 256 / 255.0)
        }

    cell.contentView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)


//        cell.contentView.backgroundColor = UIColor(hue: 1.0, saturation: 0.3, brightness: 0.5, alpha: 1.0)

        return cell
    }

    func loadInRange(range: Range<Int>, completionBlock: ([Petition]?) -> Void) {

    let urlPath                      = "https://api.whitehouse.gov/v1/petitions.json?limit=\(range.endIndex-range.startIndex)&offset=\(range.startIndex)/tENvi3GKDSyP1CVV4uVX4iDdxXj5eNMtkbFMFFqM.json"
    let url                          = NSURL(string: urlPath)
    let session                      = NSURLSession.sharedSession()
    let task                         = session.dataTaskWithURL(url!, completionHandler:
            {data, response, error -> Void in
                println("Task completed")

                if(error != nil) {
                    println(error.localizedDescription)
                }
                var err: NSError?
    if let jsonResult                = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                    if(err != nil) {
                        println("JSON Error \(err!.localizedDescription)")
                    }

    var arr : [Petition]             = [Petition]()

    if let results: NSArray          = jsonResult["results"] as? NSArray {
                        for result in results {
    if let title                     = result["title"] as? String, body = result["body"] as? String, id = result["id"] as? String {
    let petition                     = Petition(title: title, body: body, id: id)
        
                                arr.append(petition)
                                completionBlock(arr)
                            }
        }
        }
                }
        })
        task.resume()
    }


    // MARK: Sign Petition
    @IBAction func signPetition(sender: AnyObject) {

//    func signPetition() -> Void {

    var request                      = NSMutableURLRequest(URL: NSURL(string: "https://api.whitehouse.gov/v1/signatures.json?api_key=tENvi3GKDSyP1CVV4uVX4iDdxXj5eNMtkbFMFFqM")!)
    var session                      = NSURLSession.sharedSession()
    request.HTTPMethod               = "POST"

    var params                       = ["petition_id":"2076561", "email":"cmcmahon@headroyce.org", "first_name":"Catherine", "last_name":"McMahon", "zip":"94502"] as Dictionary<String, String>
        // CHANGE to user info saved to Parse
        var err: NSError?
    request.HTTPBody                 = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

    var task                         = session.dataTaskWithRequest(request, completionHandler:
            {data, response, error -> Void in
                println("Response: \(response)")
    var strData                      = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)")
                var err: NSError?
    var json                         = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary

                // error checks
                if(err != nil) {
                    println(err!.localizedDescription)
    let jsonStr                      = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: '\(jsonStr)'")
                }
                else {
    if let parseJSON                 = json {
                        println("Success! Petition signed")
                    }
                    else {
    let jsonStr                      = NSString(data: data, encoding: NSUTF8StringEncoding)
                        println("Error could not parse JSON: \(jsonStr)")
                    }
                }
        })

        task.resume()
    }
}