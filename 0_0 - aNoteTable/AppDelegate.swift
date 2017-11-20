/************************************************************************************************************************************/
/** @file       AppDelegate.swift
 *  @brief      x
 *  @details    x
 *
 *  @section    Opens
 *      x
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Vioteq related source files are the explicit property on Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

let verbose      : Bool = false;
let coloredViews : Bool = false;


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /********************************************************************************************************************************/
    /** @fcn        int main(void)
     *  @brief      x
     *  @details    x
     *
     *  @section    Purpose
     *      x
     *
     *  @param      [in] name - descrip
     *
     *  @param      [out] name - descrip
     *
     *  @return     (type) descrip
     *
     *  @pre        x
     *
     *  @post       x
     *
     *  @section    Operation
     *      x
     *
     *  @section    Opens
     *      x
     *
     *  @section    Hazards & Risks
     *      x
     *
     *  @section    Todo
     *      x
     *
     *  @section    Timing
     *      x
     *
     *  @note        x
     */
    /********************************************************************************************************************************/
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds);
        
        self.window?.backgroundColor = UIColor.white;
        
        let viewController:ViewController = ViewController();
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false;
        
        self.window?.rootViewController = viewController;
        
        self.window?.makeKeyAndVisible();
        
        print("AppDelegate.application():          Application launch complete");
        print(" ");
        print(" ");
        
        return true;
    }

    func applicationWillResignActive(_ application: UIApplication)    { return; }
    func applicationDidEnterBackground(_ application: UIApplication)  { return; }
    func applicationWillEnterForeground(_ application: UIApplication) { return; }
    func applicationDidBecomeActive(_ application: UIApplication)     { return; }
    func applicationWillTerminate(_ application: UIApplication)       { return; }
}

