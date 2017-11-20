/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @proj       0_0 - newNoteTable
 *  @brief      generation of aNote styled table of notes
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Vioteq
 *  @created    11/19/17
 *  @last rev   11/19/17
 *
 *  @section    Opens
 *      Fcn Headers (proj)
 *      Upper Bar to Match aNote        (in size)
 *      Upper Text bar to Match aNote   (in size)
 *      Lower Bar to Match aNote        (in size)
 *
 *  @section    Previous Opens
 *      pass delegate
 *      pass datasource
 *      make it be able to input N rows
 *      set a row's background
 *      set a row's text
 *      make the clickability to a larger area!!! add 50% in -x, +x, -y, +y!
 *      add a fade to the toggle of row text(s)!
 *      toggle cell content on time or tap (color, text, etc). Takes a bit of work... :)
 *      handle clicks! (e.g. UICheckBox.buttonClicked())
 *          *You're going to need to store var access by fcn call
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Vioteq related source files are the explicit property on Vioteq
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ViewController: UIViewController {

    
    var aNoteTable        : ANoteTableView!;
    var aNoteTableHandler : ANoteTableViewHandler!;
    
    var items : [String] = ["0", " 1", "  2", "   3", "    4", "     5", "      6","       7", "        8", "          9", "           A"];
    
    //options
    var cellBordersVisible:Bool = true;
    
    
    /********************************************************************************************************************************/
    /** @fcn        override func viewDidLoad()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad();

        /****************************************************************************************************************************/
        /*                                                      Table                                                               */
        /****************************************************************************************************************************/
        self.view.translatesAutoresizingMaskIntoConstraints = false;
    
        let tableFrame : CGRect = self.getANoteFrame();
        
        aNoteTable = ANoteTableView(frame:tableFrame, style:UITableViewStyle.plain, items:items);

        
        /****************************************************************************************************************************/
        /*                                                      Handler                                                             */
        /****************************************************************************************************************************/
        aNoteTableHandler = ANoteTableViewHandler(items: items, ANoteTable: aNoteTable);
        
        aNoteTable.delegate   = aNoteTableHandler;                                      /* Set both to handle clicks & provide data */
        aNoteTable.dataSource = aNoteTableHandler;        
        
        //Add it!
        self.view.addSubview(aNoteTable);
        
        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        func getANoteFrame() -> CGRect
     *  @brief      x
     *  @details    x
     *
     *  @return     (CGRect) frame
     *
     */
    /********************************************************************************************************************************/
    func getANoteFrame() -> CGRect {

        var tableFrame : CGRect = self.view.frame;
        
        tableFrame.origin.y = tableFrame.origin.y + 15;     //@todo why???

        return tableFrame;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        override func didReceiveMemoryWarning()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        return;
    }

}

