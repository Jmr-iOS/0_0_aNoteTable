/************************************************************************************************************************************/
/** @file       Globals.swift
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

var globals : Globals = Globals();


class Globals {
    let aNoteRowHeight_val : CGFloat = 175/2;  //all vals emperically chosen
    let checkBoxDim_val    : CGFloat = 40/2;   //why div-2?
    let checkBox_xOffs_val : CGFloat = 20;
    
    let cellOffs_Left_val  : CGFloat = 55;
    
    let timeView_xOffs_val  : CGFloat = 255;
    let timeView_yOffs_val  : CGFloat = 20;
    let timeView_Width_val  : CGFloat = 58;
    let timeView_Height_val : CGFloat = 20;
    
    let subjHeight_val : CGFloat = 25;
    let subjYOffs_val  : CGFloat = 25;
    let subjFont       : UIFont  = UIFont(name:"Helvetica", size: 14)!;
    
    let descripHeight_val  : CGFloat = 20;
    let subjFieldYOffs_val : CGFloat = 5;

    let nearColor_val:UIColor = UIColor(red: 255/255, green:  60/255, blue:  60/255, alpha: 1);
    let farColor_val :UIColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1);

    func subjFieldYOffs() -> CGFloat {
        return subjFieldYOffs_val;
    }
    func aNoteRowHeight() -> CGFloat {
        return aNoteRowHeight_val;
    }
    
    func checkBoxDim() -> CGFloat {
        return checkBoxDim_val;
    }

    func checkBox_xOffs() -> CGFloat {
        return checkBox_xOffs_val;
    }

    func cellOffs_Left() -> CGFloat {
        return cellOffs_Left_val;
    }

    func timeView_Width() -> CGFloat {
        return timeView_Width_val;
    }

    func timeView_Height() -> CGFloat {
        return timeView_Height_val;
    }

    func timeView_xOffs() -> CGFloat {
        return timeView_xOffs_val;
    }

    func timeView_yOffs() -> CGFloat {
        return timeView_yOffs_val;
    }

    func subjHeight() -> CGFloat {
        return subjHeight_val;
    }
    
    func subjYOffs() -> CGFloat {
        return subjYOffs_val;
    }
    
    func descripHeight() -> CGFloat {
        return descripHeight_val;
    }

    func descripYOffs() -> CGFloat {
        return subjYOffs_val + subjHeight_val;
    }
    
    func bottYOffs() -> CGFloat {
        return descripYOffs() + descripHeight_val;
    }

    func nearColor() -> UIColor {
        return UIColor(red: 255/255, green:  60/255, blue:  60/255, alpha: 1);
    }
    
    func farColor() -> UIColor {
        return UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1);
    }
}
