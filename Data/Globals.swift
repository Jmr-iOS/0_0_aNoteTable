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

var g : Globals = Globals();

let verbose      : Bool = true;
let cellFont_val : String = "Arial";                        /* todo: apply to all three and confirm                             */

let aNoteRowHeight_val : CGFloat = 85;                      /* all vals emperically chosen to match                             */
let checkBoxDim_val    : CGFloat = 20;
let checkBox_xOffs_val : CGFloat = 16;
var checkBox_yOffs_val : CGFloat = 15;

let cellOffs_Left_val  : CGFloat = 55;

let timeView_xOffs_val  : CGFloat = 258;
let timeView_yOffs_val  : CGFloat = 14;
let timeView_Width_val  : CGFloat = 52;
let timeView_Height_val : CGFloat = 18;

let subjHeight_val : CGFloat = 25;
let subjYOffs_val  : CGFloat = 25;

let descripHeight_val  : CGFloat = 20;
let subjFieldYOffs_val : CGFloat = 3;

let nearColor_val:UIColor = UIColor(red: 255/255, green:  60/255, blue:  60/255, alpha: 1);
let farColor_val :UIColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1);

let upper_bar_height : CGFloat = 64;
let text_bar_height  : CGFloat = 40;
let lower_bar_height : CGFloat = 50;

//**********************************************************************************************************************************//
//                                           Cell Subview (cs - 'Cell Subview')                                                     //
//**********************************************************************************************************************************//
let csXOffs  : Int = 10;
let csYOffs  : Int = 350;
let csWidth  : Int = 360;
let csHeight : Int = 150;


class Globals {
    
    init() {
        if(verbose) { print("Globals.init():                     Globals initialized"); }
        return;
    }

    func descripYOffs() -> CGFloat {
        return subjYOffs_val + subjHeight_val;
    }
    
    func bottYOffs() -> CGFloat {
        return descripYOffs() + descripHeight_val;
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
