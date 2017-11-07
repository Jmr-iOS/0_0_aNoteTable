//
//  aNoteTableViewHandler.swift
//  0_0 - newNoteTable
//
//

import UIKit

class ANoteTableViewHandler : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var aNoteTable : ANoteTableView!;
    
    var items : [String]!;
    
    let nearColor:UIColor = UIColor(red: 255/255, green:  60/255, blue:  60/255, alpha: 1);
    let farColor :UIColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1);


    /************************************************************************************************************************************/
    /* @fcn       init()                                                                                                                */
    /* @details                                                                                                                         */
    /************************************************************************************************************************************/
    init(items: [String], ANoteTable : ANoteTableView) {

        self.items = items;
        
        self.aNoteTable = ANoteTable;
        
        if(verbose){ print("ANoteTableViewHandler.init():       initialized"); }
        
        return;
    }
    
    
    /************************************************************************************************************************************/
    /* @fcn       tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int                                          */
    /* @details   get how many rows in specified section                                                                                */
    /************************************************************************************************************************************/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(verbose){ print("ANoteTableViewHandler.tableView():  The table will now have \(items.count), cause I just said so..."); }
        
        return items.count;                                                                 //return how many rows you want printed....!
    }

    
    /************************************************************************************************************************************/
    /* @fcn       tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ANoteTableViewCell                 */
    /* @details   add a cell to the table                                                                                               */
    /************************************************************************************************************************************/
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let  cellId  :String = "Cell"+String(indexPath.row);
        
        var cell : ANoteTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as! ANoteTableViewCell?;
        
        if (cell == nil){
            cell = ANoteTableViewCell(style: .Default, reuseIdentifier:cellId);
        }

        cell?.initialize(indexPath, aNoteTable: aNoteTable);
        
        return cell! as UITableViewCell;
    }


    
    /************************************************************************************************************************************/
    /* @fcn       tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)                                     */
    /* @details   handle cell tap                                                                                                       */
    /************************************************************************************************************************************/
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated:true);
        
        let cell : ANoteTableViewCell = self.getCell(indexPath);

        if(verbose){ print("ANoteTableViewHandler.tableView():         handling a cell tap of \(cell.tableIndex)"); }
        
        /********************************************************************************************************************************/
        /* scroll to the top or change the bar color                                                                                    */
        /********************************************************************************************************************************/
        switch(indexPath.row) {
        case (0):
            print("    top selected. Scrolling to the bottom!");
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: items.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true);
            break;
        case (items.count-5):
            print("    swapped the seperator color to red");
            tableView.separatorColor = UIColor.redColor();
            break;
        case (items.count-4):
            print("    swapped the seperator color to blue");
            tableView.separatorColor = UIColor.blueColor();
            break;
        case (items.count-3):
            print("    scrolling to the top with a Rect and fade");
            tableView.scrollRectToVisible(CGRectMake(0,0,1,1), animated:true);           //slow scroll to top
            break;
        case (items.count-2):
            print("    scrolling to the top with a Rect and no fade");
            tableView.scrollRectToVisible(CGRectMake(0,0,1,1), animated:false);          //immediate scroll to top
            break;
        case (items.count-1):
            print("    scrolling to the top with scrollToRowAtIndexPath");
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true);
            break;
        default:
            print("    no response");
            break;
        }
        
        return;
    }
    

    /************************************************************************************************************************************/
    /* @fcn       getCell(indexPath: NSIndexPath) -> aNoteTableViewCell                                                                 */
    /* @details   acquire a cell from the table                                                                                         */
    /************************************************************************************************************************************/
    func getCell(indexPath: NSIndexPath) -> ANoteTableViewCell {
        
        if(verbose){ print("ANoteTableViewHandler.getCell():       returning cell \(indexPath.item)"); }
        
        return aNoteTable.cellForRowAtIndexPath(indexPath) as! ANoteTableViewCell!;
    }
}

