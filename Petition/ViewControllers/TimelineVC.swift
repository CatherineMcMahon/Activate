//
//  TimelineVC.swift
//  Petition
//
//  Created by Catherine on 7/21/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit
import Mixpanel

class TimelineVC: UIViewController, UITableViewDelegate, UITableViewDataSource, TimelineComponentTarget {
    
    var cache                                  = [String: UILabel]()
    let kCellIdentifier: String                = "TimelineViewCell"
    var timelineComponent: TimelineComponents<Petition, TimelineVC>!
    var color: UIColor?
    @IBOutlet var tableView: UITableView!
    let defaultRange                           = 0...4
    let additionalRangeSize                    = 5
    var tableData                              = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false
    }
    
    
    func bgColor()->UIColor {
        var r                                      = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        var g                                      = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        var b                                      = CGFloat(( CGFloat(arc4random()) % 100 + 30) / 255)
        if(r == b && r == g && g == b) {
            r                                          = CGFloat( CGFloat(arc4random()) % 256 / 255.0)
        }
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "timelineCellToTimelineContentVC") {
            var something                              = segue.destinationViewController as! ContentVC
            
            if let cell                                = sender as? UITableViewCell {
                if let indexPath                           = tableView.indexPathForCell(cell) {
                    let petition                               = timelineComponent.content[indexPath.row]
                    something.petition                         = petition
                    
                    // MARK: Mixpanel 'Content Tapped'
//                    Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
//                    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//                    mixpanel.track("Content Tapped")

                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timelineComponent                          = TimelineComponents(target: self)
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
        let cell                                   = tableView.dequeueReusableCellWithIdentifier("TimelineViewCell") as! TimelineViewCell
        
        let petition                               = timelineComponent.content[indexPath.row]
        cell.postTitle.text                        = petition.title
        cell.postDesc.text                         = petition.body
        timelineComponent.targetWillDisplayEntry(indexPath.row)
        cell.contentView.backgroundColor           = petition.color
        return cell
    }
    
    
    func loadInRange(range: Range<Int>, completionBlock: ([Petition]?) -> Void) {
        
        let urlPath                                = "https://api.whitehouse.gov/v1/petitions.json?isPublic=1&isSignable=1&limit=\(range.endIndex-range.startIndex)&offset=\(range.startIndex)"
        
        let url                                    = NSURL(string: urlPath)
        let session                                = NSURLSession.sharedSession()
        let task                                   = session.dataTaskWithURL(url!, completionHandler:
            {data, response, error -> Void in
                
                if(error != nil) {
                    print(error!.localizedDescription)
                }
                var err: NSError?
                if let jsonResult                          = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                    if(err != nil) {
                        print("JSON Error \(err!.localizedDescription)")
                    }
                    
                    var arr : [Petition]                       = [Petition]()
                    
                    if let results: NSArray                    = jsonResult["results"] as? NSArray {
                        for result in results {
                            if let title                               = result["title"] as? String, body = result["body"] as? String {
                                let id: String
                                if let stringId                            = result["id"] as? String {
                                    id                                         = stringId
                                } else {
                                    id                                         = String((result["id"] as! Int))
                                }
                                let petition                               = Petition(title: title, body: body, petitionId: id, color: self.bgColor())
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