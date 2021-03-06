/************************************************************************************************************************************/
/** @file       Globals.swift
 *  @brief      x
 *  @details    x
 *
 *  @section    Opens
 *      move all variables outside of class (one, at a time...
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

var g : Globals!;
var rows : [Row] = [Row]();

let verbose : Bool = true;
let numRows : Int = 15;


//**********************************************************************************************************************************//
//                                                               PROTOTYPES                                                         //
//**********************************************************************************************************************************//
struct Row {
    var main : String!;                                         /* primary text to display                                          */
    var body : String!;                                         /* sub text displayed below main and smaller                        */
    var bott : String!;                                         /* text for time label                                              */
    var time : Int!;                                            /* minutes of day since 12:00 am                                    */
}


//**********************************************************************************************************************************//
//                                                      Main View                                                                   //
//**********************************************************************************************************************************//

let cell_xOffs   : CGFloat = 55;
let cellFont : String = "Arial";                                /* @todo    apply to all three and confirm                          */
let row_height  : CGFloat = 85;                                 /* all vals emperically chosen to match                             */


//Cell Subview
let csXOffs  : Int = 10;                                        /* ('cs' - Cell Subview)                                            */
let csYOffs  : Int = 350;
let csWidth  : Int = 360;
let csHeight : Int = 150;
let cs_borderSize : CGFloat = 2;
let cs_borderColor : CGColor = UIColor(red:   140/255, green: 140/255, blue:  140/255, alpha: 1.0).cgColor; //Apple Border Color

//Search Bar
let srch_dflt   : String = "2:00 Shopping";                     /* ('srch' - Upper Search Text Bar)                                 */

//Checkbox
let check_dim   : CGFloat = 20;
let check_xOffs : CGFloat = 16;
let check_yOffs : CGFloat = 15;
let check_dur_s : TimeInterval = TimeInterval(0.070);

//Time View
let tv_xOffs  : CGFloat = 258;                              /* ('tv' - Time View)                                                   */
let tv_yOffs  : CGFloat = 14;
let tv_width  : CGFloat = 52;
let tv_height : CGFloat = 18;
let tv_corner : CGFloat = 10;


//Subject Text
let subj_height : CGFloat = 25;
let subj_xOffs    : CGFloat = 46;
let subj_yOffs  : CGFloat = 25;

//Description Text
let descr_xOffs  : CGFloat = cell_xOffs-10;
let descr_yOffs  : CGFloat = g.descripYOffs()-10;
let descr_height  : CGFloat = 20;

//Main Text
let mt_size : CGFloat = 16;                                     /* ('mt' - Main Text)                                               */
let mt_xOffs : CGFloat = 46;
let mt_yOffs : CGFloat = 2;

//Description Text
let descr_size  : CGFloat = 12;
let descr_color : UIColor = UIColor.gray;

//Bottom Text
let bott_size   : CGFloat = 12;
let bott_color  : UIColor = UIColor.gray;
let bott_xOffs  : CGFloat = cell_xOffs+7;
let bott_yOffs  : CGFloat = g.bottYOffs()-10;
let bott_width  : CGFloat = 12;
let bott_height : CGFloat = 20;

//Bell Image
let bell_xOffs  : CGFloat = 45;
let bell_yOffs  : CGFloat = 62;
let bell_width  : CGFloat = 13.2;
let bell_height : CGFloat = 15;

//Time Label
let tl_xOffs : CGFloat = 9;
let tl_yOffs : CGFloat = 0;
let tl_width : CGFloat = tv_width;                                  /* ('tl' - Time Label)                                          */
let tl_height : CGFloat = tv_height;
let tl_size   : CGFloat = 9;

//Return Button
let ret_yOffs : CGFloat = 50;                                       /* ('ret - Return Button)                                       */

//Launch Values
let launch_dur_s : TimeInterval = TimeInterval(1.0);
let launch_del_s : TimeInterval = TimeInterval(0.5);

//Misc. Colors
let nearColor_val:UIColor = UIColor(red: 255/255, green:  60/255, blue:  60/255, alpha: 1);
let farColor_val :UIColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1);

//Misc. Dimensions
let upper_bar_height : CGFloat = 64;
let text_bar_height  : CGFloat = 40;
let lower_bar_height : CGFloat = 50;


class Globals {
    

    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      init globals
     *  @details    initialize the table of rows
     */
    /********************************************************************************************************************************/
    init() {
        
        //@pre  items init
        if(ViewController.items.count == 0) {
            for _ in 0...(numRows-1) {
                    ViewController.items.append("");
            }
        }
        
        //**************************************************************************************************************************//
        //                                                Initialize Rows of Table                                                  //
        //  @targ   Nice and simple, make rows to match Images/Ref:aNoteRef.jpg                                                     //
        //**************************************************************************************************************************//
        for i in 0...(numRows-1) {
            
            var mainText : String;
            var bodyText : String;
            var bottText : String;
            
            
            //Main Text
            mainText = String(format: "Item #%i", (i+1));                               /* e.g "Item #1"                            */
            
            //Body Text
            if(i == 0) {
                bodyText = "Some text below that is short";
            } else {
                bodyText = "Some misc. text";
            }
            
            if(i < 2) {
                bottText = "Today \(i+2):00 PM";                                        /* e.g. "2:00 PM"                           */
            } else {
                bottText = "Today \(i+3):00 PM";                                        /* e.g. "3:00 PM"                           */
            }
            
            //Time Val
            let newTime : Int = ((i+3+12)*60);                      /* minutes since 12:00am today                                  */
            
            rows.append(Row(main: mainText, body: bodyText, bott: bottText, time: newTime));
        }
//</NEW>
        
        if(verbose) { print("Globals.init():                     Globals initialized"); }
        return;
    }

    func descripYOffs() -> CGFloat {
        return subj_yOffs + subj_height;
    }
    
    func bottYOffs() -> CGFloat {
        return descripYOffs() + descr_height;
    }


    /********************************************************************************************************************************/
    /** @fcn        getCSFrame(onscreen : Bool) -> CGRect
     *  @brief      get cell subview's active location
     *  @details    x
     *
     *  @param      [in] (Bool) onscreen - if subview is displayed onscreen
     *
     *  @return     (CGRect) frame to use for Cell Subview
     */
    /********************************************************************************************************************************/
    func getCSFrame(onscreen : Bool) -> CGRect {
        
        var frame : CGRect = CGRect(x: csXOffs, y: Int(UIScreen.main.bounds.height), width: csWidth, height: csHeight);

        //onscreen check
        if(onscreen) {
            frame = CGRect(x: frame.origin.x, y: CGFloat(csYOffs), width: frame.width, height: frame.height);
        }
      
        return frame;
    }
}

