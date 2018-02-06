/************************************************************************************************************************************/
/** @file       AppDelegate.swift
 *  @brief      x
 *  @details    x
 *
 *  @section    Opens
 *      x
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?;
    var vc     : ViewController!;
    
    
    /********************************************************************************************************************************/
    /** @fcn        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
     *  @brief      x
     *  @details    x
     *
     *  @section    Purpose
     *      x
     *
     *  @param      [in] (UIApplication) application - descrip
     *  @param      [in] ([UIApplicationLaunchOptionsKey: Any]?) didFinishLaunchingWithOptions launchOptions - descrip
     *
     */
    /********************************************************************************************************************************/
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Globals
        g = Globals();
        
        //ViewController
        vc = ViewController();
        vc.view.translatesAutoresizingMaskIntoConstraints = false;
        
        //Window init
        self.window = UIWindow.init(frame: bS);
        self.window?.backgroundColor = UIColor.white;
        self.window?.rootViewController = vc;
        
        self.window?.makeKeyAndVisible();
        
        print("AppDelegate.application():          application launch complete");
        print(" ");
        
        return true;
    }

    func applicationWillResignActive(_ application: UIApplication)    { return; }
    func applicationDidEnterBackground(_ application: UIApplication)  { return; }
    func applicationWillEnterForeground(_ application: UIApplication) { return; }
    func applicationDidBecomeActive(_ application: UIApplication)     { return; }
    func applicationWillTerminate(_ application: UIApplication)       { return; }
}

