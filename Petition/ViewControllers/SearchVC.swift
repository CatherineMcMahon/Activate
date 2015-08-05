
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search()
    }
    
    func search() {
        
        println(searchBar.text)
        
    let urlPath                 = "https://api.whitehouse.gov/v1/petitions.json?limit=5&offset=5&title=\(searchBar.text)/tENvi3GKDSyP1CVV4uVX4iDdxXj5eNMtkbFMFFqM.json"
    let url                     = NSURL(string: urlPath)
    let session                 = NSURLSession.sharedSession()
    let task                    = session.dataTaskWithURL(url!, completionHandler:
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
        
    var arr : [Search]          = [Search]()

    if let results: NSArray     = jsonResult["results"] as? NSArray {
                        for result in results {
                            if let title                = result["title"] as? String, body = result["body"] as? String, petitionId = result["id"] as? String, dateCreated = result["dateCreated"] as? String, signatures = result["signatures"] as? String, signaturesNeeded = result["signaturesNeeded"] as? String, signatureThreshold = result["signatureThreshold"] as? String {
                                let search                = Search(petitionId: petitionId, title: title, body: body, dateCreated: dateCreated, signatures: signatures, signaturesNeeded: signaturesNeeded, signatureThreshold: signatureThreshold)
                                arr.append(search)
                            }
                        }
                    }
                }
        })
        task.resume()
    }
}