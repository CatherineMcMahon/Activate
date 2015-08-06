
//  SearchVC.swift
//  Petition
//
//  Created by Catherine on 8/3/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation
import UIKit
import ConvenienceKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var data = [Search]()
    
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        search()
    }
    
    func search() {
        println(searchBar.text)
        
        let urlPath                 = "https://api.whitehouse.gov/v1/petitions.json?limit=10&offset=0&title=\(searchText)"
        let url                     = NSURL(string: urlPath)
        let session                 = NSURLSession.sharedSession()
        
        if let url = url {
            let task                    = session.dataTaskWithURL(url, completionHandler:
                {data, response, error -> Void in
                    println("Task completed")
                    
                    if(error != nil) {
                        println(error.localizedDescription)
                    }
                    var err: NSError?
                    
                    if let jsonResult           = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                        if(err != nil) {
                            println("JSON Error \(err!.localizedDescription)")
                        }
                        
                        self.data = []
                        println(jsonResult)
                        if let results: NSArray     = jsonResult["results"] as? NSArray {
                            
                            for result in results {
                                
                                //                            if let title                = result["title"] as? String, body = result["body"] as?  String, petitionId = result["id"] as? String, dateCreated = result["created"] as? String, signatures = result["signatureCount"] as? String, signaturesNeeded = result["signaturesNeeded"] as? String, signatureThreshold = result["signatureThreshold"] as? String {
                                if let title                = result["title"] as? String {
                                    let search                = Search(petitionId: "", title: title, body: "", dateCreated: "", signatures: "", signaturesNeeded: "", signatureThreshold: "")
                                    self.data.append(search)
                                }
                            }
                        }
                        dispatch_async(dispatch_get_main_queue(),{
                            self.tableView.reloadData()
                        })
                        
                    }
            })
            task.resume()
        }
    }
    
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        
        search()
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchViewCell", forIndexPath: indexPath) as! SearchViewCell
        
        let item = data[indexPath.row]
        
        cell.postTitle.text = item.title
        
        return cell
    }
}