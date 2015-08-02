//
//  ContentVC.swift
//  Petition
//
//  Created by Catherine on 7/30/15.
//  Copyright (c) 2015 Catherine McMahon. All rights reserved.

import Foundation
import ParseUI
import Parse
import ASOAnimatedButton



class ContentVC: UIViewController {
    
    var petition: Petition?
    var petitionId: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var zipcode: String?
    
    
    @IBOutlet var menuItemView: BounceButtonView!
    
    //    @IBOutlet var menuButton2: ASOTwoStateButton!
    
    @IBOutlet weak var menuButton: ASOTwoStateButton!
    
    @IBAction func moreButtonPressed (sender: ASOTwoStateButton) {
        //self.view.addSubview(BounceButtonView())
        //self.theView.hidden = false
        
        if (!sender.isOn) {
            self.menuButton.addCustomView(self.menuItemView)
            self.menuItemView!.expandWithAnimationStyle(ASOAnimationStyleRiseConcurrently)
        }
        else {
            self.menuItemView!.collapseWithAnimationStyle(ASOAnimationStyleRiseConcurrently)
            self.menuButton.removeCustomView(self.menuItemView, interval: self.menuItemView!.collapsedViewDuration.doubleValue)
       }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailBody: UILabel!
    
    @IBAction func back () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func petitionDetail() {
        if(detailTitle != nil && detailBody != nil) {
            detailTitle.text          = petition!.title
            detailBody.text           = petition!.body
            petitionId                = petition!.petitionId
        }
    }
    
    @IBOutlet var tableView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.menuItemView.hidden = true
        
//        tableView.backgroundColor = RandomColor.color
        
        self.menuButton.initAnimationWithFadeEffectEnabled(true)
        petitionDetail()
        
        var arrMenuItemButtons = [UIButton]()
        
        // arrMenuItemButtons.append(self.menuItemView!.share)
        
        arrMenuItemButtons.append(self.menuItemView!.sign)
        
        self.menuItemView!.addBounceButtons(arrMenuItemButtons)

    }
}