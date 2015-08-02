// PFUser.logout -> sets user to nil (log out button) Later

import UIKit
import Parse
import ConvenienceKit

class TimelineVC: UIViewController, UITableViewDelegate, UITableViewDataSource, TimelineComponentTarget {
    
    var cache                        = [String: UILabel]()
    let kCellIdentifier: String      = "ContentViewCell"
    var timelineComponent: TimelineComponents<Petition, TimelineVC>!
    
    var pId:String?
    
    func randColor() -> UIColor {
        var r                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        var g                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        var b                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
    
        if(r == b && r == g && g == b) {
            r                                = CGFloat( CGFloat(arc4random()) % 256 / 255.0)
        }
    
        var cellColor: UIColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
        return cellColor
        }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "timelineCellToTimelineContentVC") {
            var something                    = segue.destinationViewController as! ContentVC
            
            if let cell                      = sender as? UITableViewCell {
                if let indexPath                 = tableView.indexPathForCell(cell) {
                    let petition                     = timelineComponent.content[indexPath.row]
                    something.petition               = petition
                }
            }
        }
    }
    
    // MARK: Scroll to top
    @IBOutlet weak var scrollToTop: UIButton!
    
    @IBAction func toTop() {
        if (timelineComponent.content.count > 0 ) {
            var top = NSIndexPath(forRow: Foundation.NSNotFound, inSection: 0);
            self.tableView.scrollToRowAtIndexPath(top, atScrollPosition: UITableViewScrollPosition.Top, animated: true);
        }
    }
    
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
        timelineComponent.targetWillDisplayEntry(indexPath.row)
        
        var r                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        var g                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        var b                            = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        
        if(r == b && r == g && g == b) {
            r                                = CGFloat( CGFloat(arc4random()) % 256 / 255.0)
        }
        
        var cellColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
        cell.contentView.backgroundColor = cellColor
        
        
        //        cell.contentView.backgroundColor = UIColor(hue: 1.0, saturation: 0.3, brightness: 0.5, alpha: 1.0)
        
        return cell
    }
    
    func loadInRange(range: Range<Int>, completionBlock: ([Petition]?) -> Void) {
        
        let urlPath                      = "https://api.whitehouse.gov/v1/petitions.json?limit=\(range.endIndex-range.startIndex)&offset=\(range.startIndex)"
        
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
                            if let title                     = result["title"] as? String, body = result["body"] as? String {
                                let id: String
                                if let stringId = result["id"] as? String {
                                    id = stringId
                                } else {
                                    id = String((result["id"] as! Int))
                                }
                                println("----" + title)
                                let petition                     = Petition(title: title, body: body, petitionId: id)
                                arr.append(petition)
                            }
                        }
                        completionBlock(arr)
                    }
                }
        })
        task.resume()
    }
}