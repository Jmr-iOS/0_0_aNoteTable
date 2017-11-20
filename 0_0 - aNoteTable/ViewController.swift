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
 *      Upper Bar to Match aNote        (in size)
 *      Upper Text bar to Match aNote   (in size)
 *      Lower Bar to Match aNote        (in size)
 *      all are to header
 *      use lib
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

    var upperBar : UIView!;
    var textBar  : UIView!;
    var bottBar  : UIView!;
    
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

        var yOffs : CGFloat = 0;                                        /* y-offset to place next ui item                           */
        
        /****************************************************************************************************************************/
        /*                                                     Upper Bar                                                            */
        /****************************************************************************************************************************/
        upperBar = UIView();
        upperBar.backgroundColor = UIColor.blue;
        upperBar.frame = CGRect(x: 0, y: yOffs, width: view.frame.width, height:globals.upper_bar_height);
        view.addSubview(upperBar);
        
        //Store offset
        yOffs += upperBar.frame.height;

        
        /****************************************************************************************************************************/
        /*                                                     Text Bar                                                             */
        /****************************************************************************************************************************/
        textBar = UIView();
        textBar.backgroundColor = UIColor.gray;
        textBar.frame = CGRect(x: 0, y: yOffs, width: view.frame.width, height: globals.text_bar_height);
        view.addSubview(textBar);
       
        //Store offset
        yOffs += globals.text_bar_height;

        
        /****************************************************************************************************************************/
        /*                                                      Table                                                               */
        /****************************************************************************************************************************/
        view.translatesAutoresizingMaskIntoConstraints = false;
        let tableFrame : CGRect = getANoteFrame(y: yOffs, bottHeight: globals.lower_bar_height);
        aNoteTable = ANoteTableView(frame:tableFrame, style:UITableViewStyle.plain, items:items);
        view.addSubview(aNoteTable);
        
        //Store offset
        yOffs += aNoteTable.frame.height;
        
        
        /****************************************************************************************************************************/
        /*                                                    Bottom Bar                                                            */
        /****************************************************************************************************************************/
        bottBar = UIView();
        bottBar.backgroundColor = UIColor.gray;
        bottBar.frame = CGRect(x: 0,
                               y: (view.frame.height - globals.lower_bar_height),
                               width: view.frame.width,
                               height: globals.lower_bar_height);
        view.addSubview(bottBar);
        
        print(yOffs);
        print(tableFrame.height);
        print(aNoteTable.frame.height);
        print(bottBar.frame.origin.y);
        print(" ");
        print(view.frame.height);
        
        
        /****************************************************************************************************************************/
        /*                                                      Handler                                                             */
        /****************************************************************************************************************************/
        aNoteTableHandler = ANoteTableViewHandler(items: items, ANoteTable: aNoteTable);
        
        aNoteTable.delegate   = aNoteTableHandler;                                      /* Set both to handle clicks & provide data */
        aNoteTable.dataSource = aNoteTableHandler;        
        
        
        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        func getANoteFrame() -> CGRect
     *  @brief      x
     *  @details    x
     *
     *  @param  [in] (CGFloat) y - x
     *  @param  [in] (CGFloat) bottHeight - x
     *
     *  @return     (CGRect) frame
     *
     */
    /********************************************************************************************************************************/
    func getANoteFrame(y : CGFloat, bottHeight : CGFloat) -> CGRect {

        var tableFrame : CGRect = self.view.frame;
        
        tableFrame.origin.y = y;
        
        tableFrame.size.height = view.frame.height - y - bottHeight;

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

