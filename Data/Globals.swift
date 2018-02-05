/************************************************************************************************************************************/
/** @file       Globals.swift
 *  @brief      x
 *  @details    x
 *
 *  @section    Opens
 *      none listed
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

var g : Globals!;                                               /* global constructor acces                                         */
let verbose : Bool = true;                                      /* global verbosity                                                 */
let numRows : Int  = 4;


//**********************************************************************************************************************************//
//                                                       Data Types                                                                 //
//**********************************************************************************************************************************//
enum CellType {                                                 /* For table cells                                                  */
    case list                                                   /* standard list item                                               */
    case todo                                                   /* item that is checked off on completion                           */
}


//**********************************************************************************************************************************//
//                                                      App State                                                                   //
//**********************************************************************************************************************************//
var viewOpen : Bool = false;                                    /* main view is available to insert popups into                     */


//**********************************************************************************************************************************//
//                                                      Main View                                                                   //
//**********************************************************************************************************************************//
let cellXOffs  : CGFloat = 55;                                  /* all vals emperically chosen to match                             */
let cellFont   : String = "Arial";
let cellHeight : CGFloat = 85;

//**********************************************************************************************************************************//
//                                                      Colors                                                                      //
//**********************************************************************************************************************************//
//Main screen
let bottBarColor  = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha:1);       /* #f8f8f8                                 */
let tableBakColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha:1);       /* #fafafa                                 */
let tableSepColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha:1);       /* #e6e6e6                                 */

//Time colors
let stdTimeColor  = UIColor(red: 255/255, green:  60/255, blue:  60/255, alpha: 1);      /* #ff3c3c                                 */
let normTimeColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1);      /* #d2d2d2                                 */

//Cell colors
let cellSubjColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0);                 /* #4e4e4e                                 */


//**********************************************************************************************************************************//
//                                                     Dimensions                                                                   //
//**********************************************************************************************************************************//

//Cell Subview
//<none>

//Search Bar
let srch_dflt   : String = "2:00 Shopping";                     /* ('srch' - Upper Search Text Bar)                                 */

//Checkbox
let check_dim   : CGFloat = 20;
let check_xOffs : CGFloat = 16;
let check_yOffs : CGFloat = 15;
let check_dur_s : TimeInterval = TimeInterval(0.070);

//Time View
let tv_xOffs  : CGFloat = (UIScreen.main.bounds.width - 62);    /* ('tv' - Time View)                                               */
let tv_yOffs  : CGFloat = 14;
let tv_width  : CGFloat = 52;
let tv_height : CGFloat = 18;
let tv_corner : CGFloat = 10;


//Subject Text
let subj_height : CGFloat = 25;
let subj_xOffs  : CGFloat = 46;
let subj_yOffs  : CGFloat = 25;

//Description Text
let descr_xOffs  : CGFloat = cellXOffs-10;
let descr_yOffs  : CGFloat = g.descripYOffs()-10;
let descr_height : CGFloat = 20;

//Main Text
let mt_size  : CGFloat = 16;                                    /* ('mt' - Main Text)                                               */
let mt_xOffs : CGFloat = 46;
let mt_yOffs : CGFloat = 2;

//Description Text
let descr_size  : CGFloat = 12;
let descr_color : UIColor = UIColor.gray;

//Bottom Text
let bott_size   : CGFloat = 12;
let bott_color  : UIColor = UIColor.gray;
let bott_xOffs  : CGFloat = cellXOffs+7;
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

//Launch Values
let launch_del_s = TimeInterval(0.10);
let launch_dur_s = TimeInterval(0.25);

//Misc. Dimensions
let upper_bar_height : CGFloat = 64;
let text_bar_height  : CGFloat = 40;
let lower_bar_height : CGFloat = 50;


//**********************************************************************************************************************************//
//                                                      GLOBALS CLASS                                                               //
//**********************************************************************************************************************************//
class Globals : NSObject {

    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      init globals
     *  @details    initialize the table of rows
     */
    /********************************************************************************************************************************/
    override init() {        
        
        //Init vars
        viewOpen = false;                                           /* not available till vc loading complete                       */
        
        //Super
        super.init();
        
        if(verbose) { print("Globals.init():                     globals initialized"); }
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        descripYOffs() -> CGFloat
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func descripYOffs() -> CGFloat {
        return (subj_yOffs + subj_height);
    }

    
    /********************************************************************************************************************************/
    /** @fcn        bottYOffs() -> CGFloat
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func bottYOffs() -> CGFloat {
        return (descripYOffs() + descr_height);
    }
}


/************************************************************************************************************************************/
/** @fcn        getCSFrame(onscreen : Bool) -> CGRect
 *  @brief      get cell subview's active location
 *  @details    offscreen starts to the right of screen
 *
 *  @param      [in] (Bool) onscreen - if subview is displayed onscreen
 *
 *  @return     (CGRect) frame to use for Cell Subview
 */
/************************************************************************************************************************************/
func getCSFrame(onscreen : Bool) -> CGRect {
    
    //send requested location
    if(onscreen) {
        return CGRect(x: 0,                                             /* on                                                       */
                      y: 0,
                      width: UIScreen.main.bounds.width,
                      height: UIScreen.main.bounds.height);
    } else {
        return CGRect(x: Int(UIScreen.main.bounds.width),               /* off                                                      */
                      y: 0,
                      width: Int(UIScreen.main.bounds.width),
                      height: Int(UIScreen.main.bounds.height));
    }
}

