/************************************************************************************************************************************/
/** @file       ANoteTableView.swift
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


class ANoteTableView : UITableView {
    
    var items : [String]!;      //Table Main-text contents (note - this grows in complexity later. for now, just a string)
    
    
    /********************************************************************************************************************************/
    /** @fcn        init(frame: CGRect, style: UITableViewStyle, items: [String])
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (CGRect) frame - x
     *  @param      [in] (UITableViewStyle) style - x
     *  @param      [in] ([String]) items - x
     *
     *  @section    Opens
     *      x
     */
    /********************************************************************************************************************************/
    init(frame: CGRect, style: UITableViewStyle, items: [String]) {
        
        print("ANoteTableView.init():              Currently Configured to UITableViewCell usage");

        //Store the table-values
        self.items = items;
        
        
        /****************************************************************************************************************************/
        /*                                                  UITableView                                                             */
        /****************************************************************************************************************************/
        super.init(frame: frame, style: style);
        
        self.register(ANoteTableViewCell.self, forCellReuseIdentifier: "cell");
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        self.backgroundColor = UIColor.yellow;                          /* cleanliness                                              */
        
        
        /****************************************************************************************************************************/
        /*                                              aNote cell-styles                                                           */
        /****************************************************************************************************************************/
        self.separatorColor = .gray;
        self.separatorStyle = .singleLine;
        
        self.separatorInset = UIEdgeInsetsMake(0, globals.cellOffs_Left(), 0, 0);

        //Set the row height
        self.rowHeight = (globals.aNoteRowHeight());
        
        
        //Exit
        if(verbose){print("ANoteTableView.init():              initialized"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        required init?(coder aDecoder: NSCoder)
     *  @brief      x
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

