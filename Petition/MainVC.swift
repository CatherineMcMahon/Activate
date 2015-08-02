//
//  ViewController.swift
//  Petition
//
//  Created by Catherine on 7/15/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.
// test:
//
// PFUser.logout -> sets user to nil (log out button) Later

import UIKit
import Parse
import MediaPlayer

class MainVC: UIViewController {

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var guest: UIButton!
    
    var moviePlayer: MPMoviePlayerController?
    
    func playVideo() -> Bool {
        let path = NSBundle.mainBundle().pathForResource("stars", ofType: "gif")
        
        let url = NSURL.fileURLWithPath(path!)
        
        moviePlayer = MPMoviePlayerController(contentURL: url)
        
        if let player = moviePlayer {
            player.view.frame = self.view.bounds
            
            player.controlStyle = MPMovieControlStyle.None
            
            player.prepareToPlay()
            
            player.repeatMode = .One
            
            player.scalingMode = .AspectFill
            
            self.view.addSubview(player.view)
            return true
        }
        return false
    }
    
    // MARK: Stars bg animation

    
//    var filePath = NSBundle.mainBundle().pathForResource(“railway”, ofType: “gif”)
//    var gif = NSData(contentsOfFile: filePath)
//
//    var webViewBG = UIWebView(frame: self.view.frame)
//    webViewBG.loadData(gif, MIMEType: “image/gif”, textEncodingName: nil, baseURL: nil)
//    webViewBG.userInteractionEnabled = false;
//    self.view.addSubview(webViewBG)
//    
//    var filter = UIView()
//    filter.frame = self.view.frame
//    filter.backgroundColor = UIColor.blackColor()
//    filter.alpha = 0.05
//    self.view.addSubview(filter)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        playVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        }
}