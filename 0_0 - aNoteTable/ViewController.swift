/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @proj       0_0 - newNoteTable
 *  @brief      generation of aNote styled table of notes
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/19/17
 *  @last rev   12/19/17
 *
 *  @section    Current Opens
 *      Bug - When offscreen, checkbox selection crosses out main text and changes color works unexpectedlyß∑
 *      Add Data Struct or Org to Cell
 *      Able to select same cell twice
 *      ...
 *      Populate SubView
 *      Make SubView match aNote
 *      Make Parent View match aNote
 *      ...
 *      Table Cell correct
 *      placement of upper icons (loc & size)
 *      upper bar color
 *      text bar to white with border
 *      font sizes matching
 *      font colors matching
 *      font locations matching
 *      remove cross-out of selected text in cell 
 *
 *  @section    Opens
 *      make it's aesthetic equal to aNote
 *          move number text a little upwards
 *          subview for each row (lists all contents and fields of aNote row subview)
 *          make cells match the example aNote screen
 *              text sizing
 *              text layout
 *              number sizing
 *      pass delegate
 *      pass datasource
 *      set a row's background
 *      set a row's text
 *      make the clickability to a larger area!!! add 50% in -x, +x, -y, +y!
 *      add a fade to the toggle of row text(s)!
 *      toggle cell content on time or tap (color, text, etc). Takes a bit of work... :)
 *      handle clicks! (e.g. UICheckBox.buttonClicked())
 *          *You're going to need to store var access by fcn call
 *      resolve Globals.swift (clean this up)
 *      Cell height changes when description text &/or time is added
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property of Jaostech
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
    
    var items : [String] = ["0", " 1", "  2", "   3", "    4", "     5", "      6","       7", "        8", "          9"];
    
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
        upperBar.backgroundColor = UIColor.blue;            //<todo!>
        upperBar.frame = CGRect(x: 0, y: yOffs, width: view.frame.width, height: upper_bar_height);
        
        //Load Icon
        //<todo>
        
        view.addSubview(upperBar);
        
        //Store offset
        yOffs += upperBar.frame.height;

        
        /****************************************************************************************************************************/
        /*                                                     Text Bar                                                             */
        /****************************************************************************************************************************/
        textBar = UIView();
        textBar.backgroundColor = UIColor.gray;
        textBar.frame = CGRect(x: 0, y: yOffs, width: view.frame.width, height:  text_bar_height);

        //Load Icon
        var textIcon : UIImageView;
        textIcon  = UIImageView();
        textIcon.frame = CGRect(x: 5, y: 5, width: 30, height: 30);
        textIcon.image = UIImage(named:"clock");
        textBar.addSubview(textIcon);

        //<todo>
        
        view.addSubview(textBar);
       
        //Store offset
        yOffs += text_bar_height;

        
        /****************************************************************************************************************************/
        /*                                                      Table                                                               */
        /*  @open       replace items with aNoteDemoApp().getRows()                                                                 */
        /*  @note       table supports >5 rows                                                                                      */
        /****************************************************************************************************************************/
        view.translatesAutoresizingMaskIntoConstraints = false;
        let tableFrame : CGRect = getANoteFrame(y: yOffs, bottHeight: lower_bar_height);
        aNoteTable = ANoteTableView(frame:tableFrame, style:UITableViewStyle.plain, i: 1);
        view.addSubview(aNoteTable);
        
        //Store offset
        yOffs += aNoteTable.frame.height;
        
        
        /****************************************************************************************************************************/
        /*                                                    Bottom Bar                                                            */
        /****************************************************************************************************************************/
        bottBar = UIView();
        bottBar.backgroundColor = UIColor.gray;
        bottBar.frame = CGRect(x: 0,
                               y: (view.frame.height - lower_bar_height),
                               width: view.frame.width,
                               height: lower_bar_height);
        view.addSubview(bottBar);

        
        /****************************************************************************************************************************/
        /*                                                      Handler                                                             */
        /****************************************************************************************************************************/
        aNoteTableHandler = ANoteTableViewHandler(items: items, mainView: self.view, ANoteTable: aNoteTable);
        
        aNoteTable.delegate   = aNoteTableHandler;                                      /* Set both to handle clicks & provide data */
        aNoteTable.dataSource = aNoteTableHandler;        
        
        //<temp>
        let rows : [aNoteDemoApp.Row] = aNoteDemoApp().getRows();
        for _ in rows {
            //print(r.main);
        }
        //</temp>
        
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
        
        //Get Data
        let rows : [aNoteDemoApp.Row] = aNoteDemoApp().getRows();
        
        tableFrame.origin.y = y;

        let numRows   : CGFloat = CGFloat(rows.count);
        let rowHeight : CGFloat = aNoteRowHeight_val;
        
        //Max Height
        let maxHeight   : CGFloat = (view.frame.height - y - bottHeight);
        let tableHeight : CGFloat = (numRows * rowHeight);

        if(tableHeight < maxHeight) {
            tableFrame.size.height = tableHeight;
        } else {
            tableFrame.size.height = maxHeight;
        }
        
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

