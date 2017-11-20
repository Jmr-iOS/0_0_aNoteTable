/************************************************************************************************************************************/
/** @file       ANoteTableViewHandler.swift
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


class ANoteTableViewHandler : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var aNoteTable : ANoteTableView!;
    
    var items : [String]!;
    
    let nearColor:UIColor = UIColor(red: 255/255, green:  60/255, blue:  60/255, alpha: 1);
    let farColor :UIColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1);


    /********************************************************************************************************************************/
    /* @fcn       init()                                                                                                            */
    /* @details                                                                                                                     */
    /********************************************************************************************************************************/
    init(items: [String], ANoteTable : ANoteTableView) {

        self.items = items;
        
        self.aNoteTable = ANoteTable;
        
        if(verbose){ print("ANoteTableViewHandler.init():       initialized"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int                                      */
    /* @details   get how many rows in specified section                                                                            */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(verbose){ print("ANoteTableViewHandler.tableView():  The table will now have \(items.count), cause I just said so..."); }
        
        return items.count;                                                     /* return how many rows you want printed....!       */
    }

    
    /********************************************************************************************************************************/
    /* @fcn       tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ANoteTableViewCell             */
    /* @details   add a cell to the table                                                                                           */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let  cellId  :String = "Cell"+String(indexPath.row);
        
        var cell : ANoteTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as! ANoteTableViewCell?;
        
        if (cell == nil){
            cell = ANoteTableViewCell(style: .default, reuseIdentifier:cellId);
        }

        cell?.initialize(indexPath, aNoteTable: aNoteTable);
        
        return cell! as UITableViewCell;
    }


    
    /********************************************************************************************************************************/
    /* @fcn       tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)                                 */
    /* @details   handle cell tap                                                                                                   */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated:true);
        
        let cell : ANoteTableViewCell = self.getCell(indexPath);

        if(verbose){ print("ANoteTableViewHandler.tableView():         handling a cell tap of \(cell.tableIndex)"); }
        
        /****************************************************************************************************************************/
        /* scroll to the top or change the bar color                                                                                */
        /****************************************************************************************************************************/
        switch(indexPath.row) {
        case (0):
            print("    top selected. Scrolling to the bottom!");
            tableView.scrollToRow(at: IndexPath(row: items.count-1, section: 0), at: UITableViewScrollPosition.bottom, animated: true);
            break;
        case (items.count-5):
            print("    swapped the seperator color to red");
            tableView.separatorColor = UIColor.red;
            break;
        case (items.count-4):
            print("    swapped the seperator color to blue");
            tableView.separatorColor = UIColor.blue;
            break;
        case (items.count-3):
            print("    scrolling to the top with a Rect and fade");
            tableView.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated:true);           //slow scroll to top
            break;
        case (items.count-2):
            print("    scrolling to the top with a Rect and no fade");
            tableView.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated:false);          //immediate scroll to top
            break;
        case (items.count-1):
            print("    scrolling to the top with scrollToRowAtIndexPath");
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true);
            break;
        default:
            print("    no response");
            break;
        }
        
        return;
    }
    

    /********************************************************************************************************************************/
    /* @fcn       getCell(indexPath: NSIndexPath) -> aNoteTableViewCell                                                             */
    /* @details   acquire a cell from the table                                                                                     */
    /********************************************************************************************************************************/
    func getCell(_ indexPath: IndexPath) -> ANoteTableViewCell {
        
        if(verbose){ print("ANoteTableViewHandler.getCell():       returning cell \(indexPath.item)"); }
        
        return aNoteTable.cellForRow(at: indexPath) as! ANoteTableViewCell!;
    }
}

