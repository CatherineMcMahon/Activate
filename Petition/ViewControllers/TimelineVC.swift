// PFUser.logout -> sets user to nil (log out button) Later
//  api_key=FaJcrs2u4kZcKf0lnYgY0WYTEhfek8qBBxjOyUzQ


import UIKit
import Parse
import ConvenienceKit

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
        println(timelineComponent.content.count)
        return timelineComponent.content.count

    }

    // MARK: Tap Cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //    if let rowData              = self.tableData[indexPath.row] as? NSDictionary,
        //    title                       = rowData["title"] as? String,
        //    desc                        = rowData["body"] as? String
        //            // sigs = rowData["signatureCount"] as? String
        //
        //             {
        //        }
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        println("hi")
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("hello")


    let cell                         = tableView.dequeueReusableCellWithIdentifier("ContentViewCell") as! ContentViewCell

    let petition                     = timelineComponent.content[indexPath.row]
    cell.postTitle.text              = petition.title
    cell.postDesc.text               = petition.body
        timelineComponent.targetWillDisplayEntry(indexPath.row)

    var r                 = CGFloat(( CGFloat(arc4random()) % 100 + 155) / 255)
    var g               = CGFloat(( CGFloat(arc4random()) % 100 + 155) / 255)
    var b                = CGFloat(( CGFloat(arc4random()) % 100 + 155) / 255)

        if(r == b && r == g && g == b) {
            r = CGFloat( CGFloat(arc4random()) % 256 / 255.0)
        }
        
        cell.contentView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
        
        cell.contentView.backgroundColor = UIColor(hue: 1.0, saturation: 0.3, brightness: 0.5, alpha: 1.0)

        return cell
    }

    func loadInRange(range: Range<Int>, completionBlock: ([Petition]?) -> Void) {

    let urlPath                      = "https://api.whitehouse.gov/v1/petitions.json?limit=\(range.endIndex-range.startIndex)&offset=\(range.startIndex)&createdAfter=1104581532/FaJcrs2u4kZcKf0lnYgY0WYTEhfek8qBBxjOyUzQ.json"
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
                    // offset                          = offset + 5;
    var arr : [Petition]             = [Petition]()

    if let results: NSArray          = jsonResult["results"] as? NSArray {
                        for result in results {
    if let title                     = result["title"] as? String, body = result["body"] as? String {
    let petition                     = Petition(title: title, body: body, signature: "")
                                println("Success")
                                arr.append(petition)
                                completionBlock(arr)

//                            NSTimer.scheduledTimerWithTimeInterval(0.6, target: self.tableView, selector: "reloadData", userInfo: nil, repeats: false)

                            }
                            //            let petition = Petition(title: result["title"]?, body: result["body"]?, signature: result["signature"]?)
                            //            arr.append(petition)
                            //            self.tableData.append(petition)
                        }
//                        dispatch_async(dispatch_get_main_queue(), {
                            //    self.tableData              = results
//                        })
                    }
                }
        })
        task.resume()
    }
}
