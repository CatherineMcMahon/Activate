//  Copyright (c) 2015 Catherine McMahon. All rights reserved.

//import SpritzSDK
import UIKit
import Parse
import ParseUI
import Mixpanel


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

     func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        //SpritzSDK.setClientID("0c8814ed065425eb0", clientSecret: "c4b203b9-645e-42b8-a3eb-d2f4a92f5ba8")

//        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
//        let loggedIn: Bool = NSUserDefaults.standardUserDefaults().boolForKey("loggedIn")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//        let mainVC: AnyObject! = storyboard.instantiateViewControllerWithIdentifier("MainVC")
//        let signUp: AnyObject! = storyboard.instantiateViewControllerWithIdentifier("SignUpVC")
        
//        let window = self.window
        
   /*  if PFUser.currentUser() == nil {
            window!.rootViewController = MainVC() //user that hasn't made account
        } else {
            window!.rootViewController = TimelineVC() //user logged in + closed app, etc.
        } */
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        
        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("App launched")
        
        Parse.setApplicationId("ur7l8jOJEGaYnY5z9TOzEAr0M9eolCv7imLZqWNw", clientKey: "Fqy6Asqhc0dokvFVzIKhJmVTpn1UV8qsgq00rKVd")
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)

        return true;
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("applicationWillResignActive")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("applicationDidBecomeActive")
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        Mixpanel.sharedInstanceWithToken("03d88b8595c383af0bba420b4c054f41")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("applicationWillTerminate")
    }
}


