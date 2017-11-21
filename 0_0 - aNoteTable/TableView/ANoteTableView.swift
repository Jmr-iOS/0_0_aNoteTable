/************************************************************************************************************************************/
/** @file       ANoteTableView.swift
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


class ANoteTableView : UICustomTableView {        //...
    
    var rows : [aNoteDemoApp.Row];
    var items : [String]!;
    
    
    /********************************************************************************************************************************/
    /** @fcn        init(frame: CGRect, style: UITableViewStyle, items: [String])
     *  @brief      init table with items contents
     *  @details    table sized to items.count & populated with items values
     *
     *  @param      [in] (CGRect) frame - view frame for insertion
     *  @param      [in] (UITableViewStyle) style - style to apply to table
     *
     *  @section    Opens
     *      x
     */
    /********************************************************************************************************************************/
    init(frame: CGRect, style: UITableViewStyle, i : Int) {
        
        print("ANoteTableView.init():              Currently Configured to UITableViewCell usage");

        //Store the table-values
        rows = aNoteDemoApp().getRows();
        
        
        /****************************************************************************************************************************/
        /*                                                  UITableView                                                             */
        /****************************************************************************************************************************/
        super.init(frame: frame, style: style, items: getItems(rows: rows));
        items = getItems(rows: rows);
        
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

    
    
    /********************************************************************************************************************************/
    /** @fcn        func getItems(rows :[Row]) -> [String]
     *  @brief      x
     *
     *  @param  [in] ([Row]) row - rows for table
     *
     *  @return     ([String]) items - items to se in tableview initialization
     */
    /********************************************************************************************************************************/
    func getItems(rows :[aNoteDemoApp.Row]) -> [String]{
        
        var  items : [String] = [String]();
        
        for r in rows {
            items.append(r.main);
        }
        
        return items;
    }
}

