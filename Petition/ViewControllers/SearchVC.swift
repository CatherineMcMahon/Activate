
//  SearchVC.swift
//  Petition
//
//  Created by Catherine on 8/3/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation
import UIKit
import ConvenienceKit
import Mixpanel

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var data                     = [Petition]()
    
    var searchText               = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate           = self
        
        tableView.delegate           = self
        tableView.dataSource         = self
        
        search()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "searchToContentVC") {
            
            // MARK: Mixpanel 'Search to ContentVC'
            Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("Search to ContentVC")
            
            var something                    = segue.destinationViewController as! ContentVC
            
            if let cell                      = sender as? UITableViewCell {
                if let indexPath                 = tableView.indexPathForCell(cell) {
                    let petition                     = data[indexPath.row]
                    something.petition               = petition
                }
            }
        }
    }
    

    
    func search() {
        println(searchBar.text)
        
        if !searchBar.text.isEmpty {
            
            let urlPath                  = "https://api.whitehouse.gov/v1/petitions.json?limit=10&offset=0&body=\(searchText)"
            let url                      = NSURL(string: urlPath)
            let session                  = NSURLSession.sharedSession()
            
            if let url                   = url {
                let task                     = session.dataTaskWithURL(url, completionHandler:
                    {data, response, error -> Void in
                        println("Task completed")
                        
                        if(error != nil) {
                            println(error.localizedDescription)
                        }
                        var err: NSError?
                        
                        if let jsonResult            = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                            if(err != nil) {
                                println("JSON Error \(err!.localizedDescription)")
                            }
                            
                            var newData                    = [Petition]()
                            println(jsonResult)
                            if let results: NSArray      = jsonResult["results"] as? NSArray {
                                var color = UIColor.redColor()
                                for result in results {
                                    
                                    if let title                 = result["title"] as? String, body = result["body"] as?  String {
                                        
                                        let id: String
                                        if let stringId = result["id"] as? String {
                                            id = stringId
                                        } else {
                                            id = String((result["id"] as! Int))
                                        }
                                        let search                   = Petition(title: title, body: body, petitionId: id, color: color)
                                        newData.append(search)
                                    }
                                }
                                
                            }
                            dispatch_async(dispatch_get_main_queue(),{
                                self.data = newData
                                self.tableView.reloadData()
                            })
                            
                        }
                })
                task.resume()
            }
        }
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText              = searchText
        
        search()
        
        // MARK: Mixpanel 'User searches'
        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("User searches")
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell                     = tableView.dequeueReusableCellWithIdentifier("SearchViewCell", forIndexPath: indexPath) as! SearchViewCell
        
        let item                     = data[indexPath.row]
        
        cell.title.text              = item.title
        cell.desc.text               = item.body
        //    cell.created.text            = item.created
        //            cell.signatures.text         = item.signatures
        //    cell.signaturesNeeded.text   = item.signaturesNeeded
        //    cell.signatureThreshold.text = item.signatureThreshold
        
        return cell
    }
}