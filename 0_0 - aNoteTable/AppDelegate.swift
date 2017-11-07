//
//  AppDelegate.swift
//  0_0 - newNoteTable
//
//

import UIKit

let verbose      : Bool = false;
let coloredViews : Bool = false;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds);
        
        self.window?.backgroundColor = UIColor.whiteColor();
        
        let viewController:ViewController = ViewController();
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false;
        
        self.window?.rootViewController = viewController;
        
        self.window?.makeKeyAndVisible();
        
        print("AppDelegate.application():          Application launch complete");
        print(" ");
        print(" ");
        
        return true;
    }

    func applicationWillResignActive(application: UIApplication)    { return; }
    func applicationDidEnterBackground(application: UIApplication)  { return; }
    func applicationWillEnterForeground(application: UIApplication) { return; }
    func applicationDidBecomeActive(application: UIApplication)     { return; }
    func applicationWillTerminate(application: UIApplication)       { return; }
}

