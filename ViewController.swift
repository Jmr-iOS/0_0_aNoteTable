/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @proj       0_0 - aNoteTable
 *  @brief      generation of aNote styled table of notes
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/19/17
 *  @last rev   1/7/17
 *
 *  @section    Opens
 *      TimeField represented & stored with DatePicker
 *      TimeField modifiable & retained in backups
 *      Cell SubView, full screen and date field!
 *          Subview to full screen
 *          Subview ui layout matches aNote
 *      ...
 *      Populate SubView, make match aNote
 *      Add Features (tbl)
 *      make it's aesthetic equal to aNote
 *      make the clickability to a larger area
 *      add a fade to the toggle of row text(s)
 *      toggle cell content on time or tap
 *      Make Parent View match aNote
 *      cell height changes when description text &/or time is added
 *
 *  @section    Pending Opens
 *      selectable upper bar color
 *      Add cross-out time addition to crossed out cell
 *      works in both zoomed and standard views (Start a validation test vector for aNote demo)
 *      Acquire and apply all backgrounds used in aNote, or generate your own as needed
 *
 *  @section    Ideas for Consideration
 *      white text to upper status bar
 *      shrink lower search bar border from 2px -> 1px
 *      extend to support all note display formats - Thumb, List, Detail, Diary, Photo, To-do, Calendar
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property of Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    //UI
    var upperBar  : UIView;
    var upperIcon : UIImageView;
    var upperText : UITextView;
    var divBar    : UIView;

    var textBar   : UIView;
    var textIcon  : UIImageView;
    var textField : UITextField;

    var bottBar   : UIView!;
    
    var aNoteTable        : ANoteTableView!;
    var aNoteTableHandler : ANoteTableViewHandler!;

    //Options
    var cellBordersVisible:Bool = true;

    //Data
    var rows : [Row];

    
    /********************************************************************************************************************************/
    /** @fcn        init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        //Init State
        upperBar = UIView();
        upperIcon = UIImageView();
        upperText = UITextView();
        textBar = UIView();
        textIcon  = UIImageView();
        textField = UITextField();
        divBar = UIView();
        

        //**************************************************************************************************************************//
        //                                                Initialize Rows of Table                                                  //
        //  @targ   Nice and simple, make rows to match Images/Ref:aNoteRef.jpg                                                     //
        //**************************************************************************************************************************//
        rows = [Row]();                                                                 /* init rows                                */

        for i in 0...(numRows-1) {
            
            var mainText : String;
            var bodyText : String;
            var bottText : String;
            
            //Main Text
            mainText = String(format: "Item #%i", (i+1));                               /* e.g "Item #1"                            */
            
            //Body Text
            if(i == 0) {
                bodyText = "Some text below that is short";
            } else {
                bodyText = "Some misc. text";
            }
            
            if(i < 2) {
                bottText = "Today \(i+2):00 PM";                                        /* e.g. "2:00 PM"                           */
            } else {
                bottText = "Today \(i+3):00 PM";                                        /* e.g. "3:00 PM"                           */
            }
            
            //Time Val
            let newTime : Int = ((i+3+12)*60);                      /* minutes since 12:00am today                                  */
            
            rows.append(Row(main: mainText, body: bodyText, bott: bottText, time: newTime));
        }
        
        //Super
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);

        //Init DataBackup
        DataBackup.storeViewController(self);

        //Backup Retrieve
        DataBackup.loadData();                                              /* load the backup if exists                            */
        
//<TEMP>
        //Var Updates
        self.printVars();
        self.updateVars();
        self.printVars();
        
        //Store Updates
        DataBackup.updateBackup();                                          /* store the update                                     */
///</TEMP>
        
        print("ViewController.init():              Initialization complete");

        return;
    }

    
    
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
        upperBar.frame = CGRect(x: 0, y: yOffs, width: view.frame.width, height: upper_bar_height);
        upperBar.backgroundColor = UIColor(patternImage: UIImage(named: "blue_bkgnd")!);                /* apply texture            */
        
        //Load Icon
        upperIcon.frame = CGRect(x: 10, y: 15, width: 50, height: 50);
        upperIcon.image = UIImage(named:"Upper Icon");
        

        //Load Text
        upperText.frame = CGRect(x: 65, y: 23, width: 290, height: 300);
        upperText.textAlignment = .left;
        upperText.textColor = UIColor.white;
        upperText.backgroundColor = nil;                                                        /* turn off bkgnd                   */
        upperText.text = "Demo iOS Dir";
        upperText.font = UIFont(name: ".SFUIDisplay-Medium", size: 19.0);
        upperText.isEditable = false;                                                           /* view only, disablbe both         */
        upperText.isSelectable = false;
        
        //Add views
        view.addSubview(upperBar);
        view.addSubview(upperIcon);
        view.addSubview(upperText);

        //Store offset
        yOffs += upperBar.frame.height;

        
        /****************************************************************************************************************************/
        /*                                                     Text Bar                                                             */
        /****************************************************************************************************************************/
        textBar.frame = CGRect(x: 0, y: yOffs, width: view.frame.width, height:  text_bar_height);
        
        //Load Icon
        textIcon.frame = CGRect(x: 13, y: 5, width: 28, height: 28);
        textIcon.image = UIImage(named:"clock");
        textBar.addSubview(textIcon);

        //Load Text Field
        textField.frame = CGRect(x: 47, y: 2, width: 250, height: Int(text_bar_height-1));
        textField.font = UIFont(name: ".SFUIText", size: 16);
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center;
        textField.placeholder = srch_dflt;
        textField.delegate = self;
        
        //Load Text Field Buttons
        let listButton : UIButton = UIButton(frame: CGRect(x: 223, y: 74, width: 25, height: 25));
        listButton.translatesAutoresizingMaskIntoConstraints = true;
        listButton.setBackgroundImage(UIImage(named:"List"), for: UIControlState());
        listButton.addTarget(self, action: #selector(self.listPressed(_:)), for:  .touchUpInside);
        
        let optionButton : UIButton = UIButton(frame: CGRect(x: 260, y: 74, width: 50, height: 25));
        optionButton.translatesAutoresizingMaskIntoConstraints = true;
        optionButton.setBackgroundImage(UIImage(named:"Option"), for: UIControlState());
        optionButton.addTarget(self, action: #selector(self.optionPressed(_:)), for:  .touchUpInside);

        //Upper Icons
        let settingsButton : UIButton = UIButton(frame: CGRect(x: 194, y: 30, width: 25, height: 25));
        settingsButton.translatesAutoresizingMaskIntoConstraints = true;
        settingsButton.setBackgroundImage(UIImage(named:"Folder Settings"), for: UIControlState());
        settingsButton.addTarget(self, action: #selector(self.settingsPressed(_:)), for:  .touchUpInside);
        self.view.addSubview(settingsButton);

        let searchButton : UIButton = UIButton(frame: CGRect(x: 239, y: 29, width: 25, height: 25));
        searchButton.translatesAutoresizingMaskIntoConstraints = true;
        searchButton.setBackgroundImage(UIImage(named:"Search Glass"), for: UIControlState());
        searchButton.addTarget(self, action: #selector(self.searchPressed(_:)), for:  .touchUpInside);
        self.view.addSubview(searchButton);
        
        let bookmarkButton : UIButton = UIButton(frame: CGRect(x: 283, y: 29, width: 25, height: 25));
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = true;
        bookmarkButton.setBackgroundImage(UIImage(named:"Bookmark Tab"), for: UIControlState());
        bookmarkButton.addTarget(self, action: #selector(self.bookmarkPressed(_:)), for:  .touchUpInside);
        self.view.addSubview(bookmarkButton);
        
        //Divider Bar
        divBar.backgroundColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0);   /* #bdbdbd                                  */
        divBar.frame = CGRect(x: 0,
                              y: (upperBar.frame.height+textBar.frame.height-1),
                              width: self.view.frame.width,
                              height: 1);
        
        //Add components
        textBar.addSubview(textField);
        view.addSubview(textBar);
        view.addSubview(listButton);
        view.addSubview(optionButton);
        view.addSubview(divBar);
        
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
        bottBar.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0);      /* #f9f9f9                              */
        bottBar.frame = CGRect(x: 0,
                               y: (view.frame.height - lower_bar_height),
                               width: view.frame.width,
                               height: lower_bar_height);
        
        //Return Arrow
        let returnArrow : UIButton = UIButton(frame: CGRect(x: 24, y: 533, width: 20, height: 20));
        returnArrow.translatesAutoresizingMaskIntoConstraints = true;
        returnArrow.setBackgroundImage(UIImage(named:"Bottom Arrow"), for: UIControlState());
        returnArrow.addTarget(self, action: #selector(self.returnPressed(_:)), for:  .touchUpInside);
        
        //Plus Button
        let plusButton : UIButton = UIButton(frame: CGRect(x: 265, y: 523, width: 40, height: 40));
        plusButton.translatesAutoresizingMaskIntoConstraints = true;
        plusButton.setBackgroundImage(UIImage(named:"Plus Button"), for: UIControlState());
        plusButton.addTarget(self, action: #selector(self.plusPressed(_:)), for:  .touchUpInside);

        //Add components
        self.view.addSubview(bottBar);
        self.view.addSubview(returnArrow);
        self.view.addSubview(plusButton);

        
        /****************************************************************************************************************************/
        /*                                                      Handler                                                             */
        /****************************************************************************************************************************/
        aNoteTableHandler = ANoteTableViewHandler(vc: self, mainView: self.view, ANoteTable: aNoteTable);

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

        let numRows   : CGFloat = CGFloat(rows.count);
        let rowHeight : CGFloat = row_height;
        
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
    

    /********************************************************************************************************************************/
    /** @fcn        func settingsPressed(_: (UIButton?))
     *  @brief      handle the settings button selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func settingsPressed(_: (UIButton?)) {
        print("ViewController.settingsPressed():   settings was pressed");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        func bookmarkPressed(_: (UIButton?))
     *  @brief      handle the bookmark button selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func bookmarkPressed(_: (UIButton?)) {
        print("ViewController.bookmarkPressed():   bookmark was pressed");
        DataBackup.updateBackup();                                          /* store the update                                     */
        print("ViewController.bookmarkPressed():   bookmark response completed");

        //@note     apply changes here for debug if desired
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        func searchPressed(_: (UIButton?))
     *  @brief      handle the search button selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func searchPressed(_: (UIButton?)) {
        print("ViewController.searchPressed():     search was pressed");

        //@note     apply secondary changes here for debug if desired
        
        print("ViewController.searchPressed():     exiting");
        
        return;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        func listPressed(_: (UIButton?))
     *  @brief      handle the search button selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func listPressed(_: (UIButton?)) {
        print("ViewController.listPressed():       list was pressed");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        func optionPressed(_: (UIButton?))
     *  @brief      handle the search button selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func optionPressed(_: (UIButton?)) {
        print("ViewController.optionPressed():     option was pressed");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        returnPressed(_: (UIButton?))
     *  @brief      handle the return button selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func returnPressed(_: (UIButton?)) {
        print("ViewController.returnPressed():     return was pressed");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        plusPressed(_: (UIButton?))
     *  @brief      handle the search button selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func plusPressed(_: (UIButton?)) {
        print("ViewController.plusPressed():       plus was pressed");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        textFieldShouldReturn(_ textField: UITextField) -> Bool
     *  @brief      Dismiss the keyboard when the user taps the "Return" key
     *  @details    x
     */
    /********************************************************************************************************************************/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        updateVars()
     *  @brief      Update or reset all backup vars
     *  @details    x
     */
    /********************************************************************************************************************************/
    func updateVars() {
/* @depr
        if(someVal_0 < 3) {
            someVal_0 = someVal_0 + 1;                                      / increment vars
            someStr_0 = someStr_0 + "\(someVal_0)";
            someVals[0] = someVals[0] + 1;
            someVals[1] = someVals[1] + 2;
            someVals[2] = someVals[2] + 3;
            someBlog.blogName  = someBlog.blogName + "!";
            somePers.firstName = somePers.firstName + ".";
            newRows[0].main = newRows[0].main! + "A";
            newRows[1].main = newRows[1].main! + "B";
            newRows[2].main = newRows[2].main! + "C";
            print("ViewController.updateVars():     vars incremented");
        } else {
            someVal_0 = 0;                                                  / reset vars
            someStr_0 = "A";
            someVals[0] = 0;
            someVals[1] = 0;
            someVals[2] = 0;
            someBlog.blogName  = "B";
            somePers.firstName = "Justin";
            somePers.lastName  = "Reina";
            newRows[0].main = "D";
            newRows[1].main = "D";
            newRows[2].main = "D";

            print("ViewController.updateVars():     vars reset");
        }
*/
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        printVars()
     *  @brief      printVars to console
     *  @details    x
     */
    /********************************************************************************************************************************/
    func printVars() {
/*@depr
        print("ViewController.printVars():         pre  - \(someVal_0),\t\(someStr_0), \t[\(someVals[0]), \(someVals[1]), \(someVals[2])], \(someBlog.blogName), \(somePers.firstName)");
        print("ViewController.printVars():         pre  - \(newRows[0].main!), \t\(newRows[1].main!), \t[\(newRows[2].main!)");
 */
        return;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        init?(coder aDecoder: NSCoder)
     *  @brief      backup restore initialization
     *  @details    x
     *
     *  @param      [in] (NSCoder) aDecoder - memory query device (backup access)
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
}

