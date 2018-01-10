/************************************************************************************************************************************/
/** @file       ANoteTimeSelect.swift
 *  @project    x
 *  @brief      x
 *  @details    x
 *
 *  @notes      x
 *
 *  @section    Opens
 *      none current
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ANoteTimeSelect : UIView, UITableViewDataSource, UITableViewDelegate  {
    
    let numRows   : CGFloat = 6;
    let width     : CGFloat = UIScreen.main.bounds.width;
    let height    : CGFloat = 450;                                      /* expand as needed to fit                                  */
    let rowHeight : CGFloat;
    
    var isRaised   : Bool;
    
    //UI
    var tableView : UITableView!;
    
    //Constants
    let verbose : Bool = true;
    
    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    init(_ vc : ViewController) {

        //Init Constants
        rowHeight = (height/numRows);
        
        if(verbose){ print("ANoteTimeSelect.init():             adding a standard table"); }
        
        //Init below screen
        let frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: width, height: height);
        
        //Init Vars
        isRaised   = false;

        //Super
        super.init(frame: frame);
        
        //Init UI
        //@todo     table
        //@todo     table.row[0]: Button | UILabel | Button
        //@todo     table.row[1]: Empty
        //@todo     table.row[2]: DatePicker
        //@todo     table.row[3]: Empty
        //@todo     table.row[4]: Empty
        //@todo     table.row[5]: Empty
        //@todo     table.row[6]: Empty

        
        //Init
        tableView = UITableView(frame:CGRect(x: 0, y: 0, width: frame.width, height: frame.height));

        
        tableView.delegate = self;                                                  /* Set both to handle clicks & provide data     */
        tableView.dataSource = self;
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");   /* I have no idea why we do this                */
        tableView.translatesAutoresizingMaskIntoConstraints = false;                /* Std                                          */
        
        tableView.separatorColor = UIColor.gray;
        tableView.separatorStyle = .singleLine;
        
        //Safety
        tableView.backgroundColor = UIColor.black;
        
        //Set the row height
        tableView.rowHeight = rowHeight;
        
        //Disable scrolling & selection
        tableView.allowsSelection = false;
        tableView.isScrollEnabled = false;
        
        if(verbose){ print("ANoteTimeSelect.show():             table initialization complete"); }
        
        //Add it!
        self.addSubview(tableView);
//<END>
        self.backgroundColor = UIColor.darkGray;
        
        if(verbose){ print("ANoteTimeSelect.show():             initialization complete"); }
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        show()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func show(_ vc : ViewController) {
        
        //@todo     slide up
        loadPopup(vc, dir: true, height: height);
        
        print("ANoteTimeSelect.show():             shown");
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        loadPopup(_ dir : Bool)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func loadPopup(_ vc : ViewController, dir : Bool, height : CGFloat) {
        
        if(dir == true) {
            vc.view.addSubview(self);

            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                print("ANoteTimeSelect.loadPopup():        sliding popup in!");
                self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-height, width: vc.view.frame.width, height: height);
                self.isRaised = false;
            }, completion: { (finished: Bool) -> Void in
                print("ANoteTimeSelect.loadPopup():         sliding popup in completion!");
                self.isRaised = true;
            });
        } else {
            print("ANoteTimeSelect.loadPopup():        off!");
            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                print("ANoteTimeSelect.loadPopup():        sliding popup out");
                self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: vc.view.frame.width, height: height);
                self.isRaised = true;
                
            }, completion: { (finished: Bool) -> Void in
                print("ANoteTimeSelect.loadPopup():        sliding popup out completion");
                self.isRaised = false;
            });
        }
        
        return;
    }
    
//!!!
/************************************************************************************************************************************/
/*                                    UITableViewDataSource, UITableViewDelegate Interfaces                                         */
/************************************************************************************************************************************/
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        if(verbose){ print("ViewController.tableView(NRS):       the table will now have \(numRows), cause I just said so..."); }
        
        return Int(numRows);                                                /* return how many rows you want printed....!           */
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(verbose){ print("ANoteTimeSelect.tableView(cFR):      adding a cell"); }
        
        //Grab
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;

        //Config
        cell?.textLabel?.text = "row \((indexPath as NSIndexPath).row)";                        /* text                             */
        cell?.textLabel?.font = UIFont(name: (cell?.textLabel!.font.fontName)!, size: 20);      /* font                             */
        cell?.textLabel?.textAlignment = NSTextAlignment.center;                                /* alignment                        */
        cell?.selectionStyle = UITableViewCellSelectionStyle.none;                              /* tap ui response                  */
        
        if(verbose){ print("ANoteTimeSelect.tableView(cFR):      adding a cell complete"); }
        
        return cell!;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(verbose){ print("ANoteTimeSelect.tableView(DSR):      handling a cell tap of \((indexPath as NSIndexPath).item)"); }
        
        tableView.deselectRow(at: indexPath, animated:true);
        
        let _/*currCell*/ : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        if(verbose){ print("ANoteTimeSelect.tableView(DSR):      hello standard cell at index \(indexPath)- '\("currCell.textLabel!.text!")'"); }
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
   
        if(verbose){ print("ANoteTimeSelect.tableView(MRA):       called"); }
        
        //you'll have to move it yourself as well
//!        let moved : String = self.items.remove(at: (sourceIndexPath as NSIndexPath).item);
//!        self.items.insert(moved, at: (destinationIndexPath as NSIndexPath).item);
        
        self.tableView.setEditing(false, animated: true);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(verbose){ print("ANoteTimeSelect.tableView(CER):      called"); }
        return true;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if(verbose){ print("ANoteTimeSelect.tableView(ESR):       called"); }
        return UITableViewCellEditingStyle.none;            //If you say .Delete here it lets you delete too. .None is just reorder
    }
//!!!
    
    
    /********************************************************************************************************************************/
    /* @fcn        required init?(coder aDecoder: NSCoder)                                                                          */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }

}

