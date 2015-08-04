
//  SearchVC.swift
//  Petition
//
//  Created by Catherine on 8/3/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
//

import Foundation
import UIKit
import ConvenienceKit
import SwiftyJSON

class SearchVC: UITableViewCell {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
        
    // MARK: Update Petiton List
    enum State {
        case DefaultMode
        case SearchMode
    }

    var state: State             = .DefaultMode {
        didSet {
            switch (state) {
            case .DefaultMode:
                searchPetitions("")

            case .SearchMode:
                let searchText = searchBar?.text ?? ""
                searchPetitions(searchText)
            }
        }
    }

    // MARK: View Lifecycle

    func viewWillAppear(animated: Bool) {
        viewWillAppear(animated)
        state = .DefaultMode
    }

    func searchPetitions(userInput: String?) {
        
    let url                      = NSURL(string: "https://api.whitehouse.gov/v1/petitions.json?limit=5&offset=5?title=\(userInput)/tENvi3GKDSyP1CVV4uVX4iDdxXj5eNMtkbFMFFqM.json")
    var request                  = NSURLRequest(URL: url!)
    var data                     = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        if data != nil {

    var results                  = JSON(data: data!)
    var arr : [Petition]         = [Petition]()
            for result in results.arrayValue {
    let title                    = result["title"].stringValue
    let body                     = result["body"].stringValue
                println(title)
                
//                arr.append(title:title, body:body)
            }
        }
    }
}

//    let urlPath                 = "https://api.whitehouse.gov/v1/petitions.json?limit=5&offset=5&title=\(userSearchInput)/tENvi3GKDSyP1CVV4uVX4iDdxXj5eNMtkbFMFFqM.json"
//    let url                     = NSURL(string: urlPath)
//    let session                 = NSURLSession.sharedSession()
//    let task                    = session.dataTaskWithURL(url!, completionHandler:
//            {data, response, error -> Void in
//                println("Task completed")
//
//                if(error != nil) {
//                    println(error.localizedDescription)
//                }
//                var err: NSError?
//
//    if let jsonResult           = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
//                    if(err != nil) {
//                        println("JSON Error \(err!.localizedDescription)")
//                    }
//    var arr : [Search]          = [Search]()
//
//    if let results: NSArray     = jsonResult["results"] as? NSArray {
//                        for result in results {
//    if let title                = result["title"] as? String, body = result["body"] as? String
//    let petition                = Search(title: title, body: body)
//
//                                arr.append(petition)
//                                completionBlock(arr)
//                            }
//                        }
//                    }
//        })
//        task.resume()
//    }
//}