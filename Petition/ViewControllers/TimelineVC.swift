// PFUser.logout -> sets user to nil (log out button) Later

import UIKit
import Parse
import ConvenienceKit

class TimelineVC: UIViewController, UITableViewDelegate, UITableViewDataSource, TimelineComponentTarget {

    var timelineComponent: TimelineComponentTarget<ContentViewCell, TimelineVC>!

    var cache                       = [String: UILabel]()
    let kCellIdentifier: String     = "ContentViewCell"

    @IBOutlet var tableView: UITableView!

    let defaultRange                = 0...4
    let additionalRangeSize         = 5

    var tableData                   = []

        override func viewDidLoad() {
        super.viewDidLoad()

    timelineComponent               = TimelineComponent(target: self)
    // self.UIViewController?.delegate = self

        getPetitionInfo("title")
        getPetitionInfo("body")
    }

    func loadInRange(range: Range<Int>, completionBlock: ([ContentViewCell]?) -> Void) {

        var offset: Int = 5
        
        getPetitionInfo(offset) {
            if let error                    = error { ErrorHandling.defaultErrorHandler(error) }
        }
        ParseHelper.timelineRequestForCurrentUser(range) {
            (result: [AnyObject]?, error: NSError?) -> () in

    let posts                       = result as? ContentViewCell ?? ""
            completionBlock(posts)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        timelineComponent.loadInitialIfRequired()
        }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    // MARK: Tap Cell

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let rowData                  = self.tableData[indexPath.row] as? NSDictionary,
    title                           = rowData["title"] as? String,
    desc                            = rowData["body"] as? String
            // sigs = rowData["signatureCount"] as? String

             {
        }
    }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCellWithIdentifier("ContentViewCell") as! ContentViewCell

    let cell                        = tableView.dequeueReusableCellWithIdentifier("ContentViewCell", forIndexPath: indexPath) as! ContentViewCell

    let petition                    = self.tableData[indexPath.row] as! [NSString : AnyObject]

    cell.postTitle.text             = petition["title"] as? String
    cell.postDesc.text              = petition["body"] as? String

       // randRGBColor: UIColor = [[UIColor alloc] initWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1.0];

       // cell.contentView.backgroundColor = randColor

        return cell
    }

    func getPetitionInfo(searchTerm: String, offset: Int) {

    let urlPath                     = "https://api.whitehouse.gov/v1/petitions.json?limit=5&offset=\(offset)&createdAfter=1104581532/FaJcrs2u4kZcKf0lnYgY0WYTEhfek8qBBxjOyUzQ.json"
    let url                         = NSURL(string: urlPath)
    let session                     = NSURLSession.sharedSession()
    let task                        = session.dataTaskWithURL(url!, completionHandler:
            {data, response, error -> Void in
                println("Task completed")

                if(error != nil) {
                    println(error.localizedDescription)
                }
                var err: NSError?
    if let jsonResult               = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                    if(err != nil) {
                        println("JSON Error \(err!.localizedDescription)")
                    }
    // offset                          = offset + 5;
    if let results: NSArray         = jsonResult["results"] as? NSArray {
                        dispatch_async(dispatch_get_main_queue(), {
    self.tableData                  = results
                            self.tableView.reloadData()
                        })
                    }
                }
        })
        task.resume()
    }
}

/*extension TimelineVC: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.timelineComponent.content.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell                        = tableView.dequeueReusableCellWithIdentifier("ContentViewCell") as! PostTableViewCell
    let post                        = timelineComponent.content[indexPath.section]

    cell.post                       = post

        return cell
    }
} */