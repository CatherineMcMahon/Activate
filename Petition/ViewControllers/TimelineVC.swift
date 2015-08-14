// PFUser.logout -> sets user to nil (log out button) Later

import UIKit
import Parse
import ConvenienceKit

class TimelineVC: UIViewController, UITableViewDelegate, UITableViewDataSource, TimelineComponentTarget {
    
    var cache                                        = [String: UILabel]()
    let kCellIdentifier: String                      = "ContentViewCell"
    var timelineComponent: TimelineComponents<Petition, TimelineVC>!
    
    @IBOutlet var tableView: UITableView!
    let defaultRange                                 = 0...4
    let additionalRangeSize                          = 5
    
    var tableData                                    = []
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "timelineCellToTimelineContentVC") {
            var something                                    = segue.destinationViewController as! ContentVC
            
//            var color                                        = tableView.backgroundColor
            
            if let cell                                      = sender as? UITableViewCell {
                if let indexPath                                 = tableView.indexPathForCell(cell) {
                    let petition                                     = timelineComponent.content[indexPath.row]
                    something.petition                               = petition
//                    something.color                                  = color
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timelineComponent                                = TimelineComponents(target: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timelineComponent.loadInitialIfRequired()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineComponent.content.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell                                         = tableView.dequeueReusableCellWithIdentifier("ContentViewCell") as! ContentViewCell
        
        let petition                                     = timelineComponent.content[indexPath.row]
        cell.postTitle.text                              = petition.title
        cell.postDesc.text                               = petition.body
        timelineComponent.targetWillDisplayEntry(indexPath.row)
        
        var r                                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        var g                                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        var b                                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        
        if(r == b && r == g && g == b) {
            r                                                = CGFloat( CGFloat(arc4random()) % 256 / 255.0)
        }
        
        var color                                        = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
        
        cell.contentView.backgroundColor                 = color
        
        //        cellColor = RandomColor.randColor
        
        //        cell.contentView.backgroundColor = UIColor(hue: 1.0, saturation: 0.3, brightness: 0.5, alpha: 1.0)
        
        return cell
    }
    
    
    func loadInRange(range: Range<Int>, completionBlock: ([Petition]?) -> Void) {
        
        let urlPath                                      = "https://api.whitehouse.gov/v1/petitions.json?isPublic=1&isSignable=1&limit=\(range.endIndex-range.startIndex)&offset=\(range.startIndex)"
        
        let url                                          = NSURL(string: urlPath)
        let session                                      = NSURLSession.sharedSession()
        let task                                         = session.dataTaskWithURL(url!, completionHandler:
            {data, response, error -> Void in
                
                if(error != nil) {
                    println(error.localizedDescription)
                }
                var err: NSError?
                if let jsonResult                                = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                    if(err != nil) {
                        println("JSON Error \(err!.localizedDescription)")
                    }
                    
                    var arr : [Petition]                             = [Petition]()
                    
                    if let results: NSArray                          = jsonResult["results"] as? NSArray {
                        for result in results {
                            if let title                                     = result["title"] as? String, body = result["body"] as? String {
                                let id: String
                                if let stringId                                  = result["id"] as? String {
                                    id                                               = stringId
                                } else {
                                    id                                               = String((result["id"] as! Int))
                                }
                                let petition                                     = Petition(title: title, body: body, petitionId: id)
                                arr.append(petition)
                            }
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            completionBlock(arr)
                        })
                    }
                }
        })
        task.resume()
    }
}