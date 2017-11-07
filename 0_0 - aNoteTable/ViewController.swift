//
//  ViewController.swift
//  0_0 - newNoteTable
//
//  /------OLD TODOS-----/
//  @todo   pass delegate
//  @todo   pass datasource
//  @todo   make it be able to input N rows
//  @todo   set a row's background
//  @todo   set a row's text
//  @todo   make the clickability to a larger area!!! add 50% in -x, +x, -y, +y!
//  @todo   add a fade to the toggle of row text(s)!
//  @todo   toggle cell content on time or tap (color, text, etc). Takes a bit of work... :)
//  @todo   handle clicks! (e.g. UICheckBox.buttonClicked())
//              *You're going to need to store var access by fcn call
//

import UIKit

class ViewController: UIViewController {

    
    var aNoteTable        : ANoteTableView!;
    var aNoteTableHandler : ANoteTableViewHandler!;
    
    var items : [String] = ["0", " 1", "  2", "   3", "    4", "     5", "      6", "       7", "        8", "          9", "           A"];

    //options
    var cellBordersVisible:Bool = true;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();

        /****************************************************/
        /*                 Table                            */
        /****************************************************/
        self.view.translatesAutoresizingMaskIntoConstraints = false;
    
        let tableFrame : CGRect = self.getANoteFrame();
        
        aNoteTable = ANoteTableView(frame:tableFrame, style:UITableViewStyle.Plain, items:items);

        
        /****************************************************/
        /*                 Handler                          */
        /****************************************************/
        aNoteTableHandler = ANoteTableViewHandler(items: items, ANoteTable: aNoteTable);
        
        aNoteTable.delegate   = aNoteTableHandler;                                            //Set both to handle clicks & provide data
        aNoteTable.dataSource = aNoteTableHandler;        
        
        //Add it!
        self.view.addSubview(aNoteTable);
        
        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }

    
    func getANoteFrame() -> CGRect {

        var tableFrame : CGRect = self.view.frame;
        
        tableFrame.origin.y = tableFrame.origin.y + 15;     //@todo why???

        return tableFrame;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        return;
    }

}

