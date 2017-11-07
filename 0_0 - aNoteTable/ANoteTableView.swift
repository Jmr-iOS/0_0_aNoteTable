//
//  ANoteTableView.swift
//  0_0 - newNoteTable
//
//

import UIKit


class ANoteTableView : UITableView {
    
    var items : [String]!;      //Table Main-text contents (note - this grows in complexity later. for now, just a string)
    
    
    init(frame: CGRect, style: UITableViewStyle, items: [String]) {
        
        print("ANoteTableView.init():              Currently Configured to UITableViewCell usage");

        //Store the table-values
        self.items = items;
        
        
        /****************************************************/
        /*                  UITableView                     */
        /****************************************************/
        super.init(frame: frame, style: style);
        
        self.register(ANoteTableViewCell.self, forCellReuseIdentifier: "cell");
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        self.backgroundColor = UIColor.black;   //cleanliness
        
        
        /****************************************************/
        /*                  aNote cell-styles               */
        /****************************************************/
        self.separatorColor = .gray;
        self.separatorStyle = .singleLine;
        
        self.separatorInset = UIEdgeInsetsMake(0, globals.cellOffs_Left(), 0, 0);

        //Set the row height
        self.rowHeight = (globals.aNoteRowHeight());
        
        
        //Exit
        if(verbose){print("ANoteTableView.init():              initialized"); }
        
        return;
    }
    
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
