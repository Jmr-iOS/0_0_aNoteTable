/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @proj       0_0 - aNoteTable
 *  @brief      generation of aNote styled table of notes
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/19/17
 *  @last rev   12/26/17
 *
 *  @section    Current Opens
 *      Populate bottom bar
 *      ...
 *      Populate SubView
 *      Make SubView match aNote
 *      Make Parent View match aNote
 *      Add cross-out time addition to crossed out cell
 *      ...
 *      Table Cell correct
 *      placement of upper icons (loc & size)
 *      upper bar color
 *      text bar to white with border
 *      font sizes matching
 *      font colors matching
 *      font locations matching
 *      Add a backup
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
 *      Works in both zoomed and standard (un-zoomed) views
 *
 *  @section    Ideas for Consideration
 *      Extend to support all note display formats - Thumb, List, Detail, Diary, Photo, To-do, Calendar
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property of Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    var upperBar  : UIView!;
    var upperIcon : UIImageView!;
    var upperText : UITextView!;

    var textBar   : UIView!;
    var textIcon  : UIImageView;
    var textField : UITextField;

    var bottBar   : UIView!;
    
    var aNoteTable        : ANoteTableView!;
    var aNoteTableHandler : ANoteTableViewHandler!;
    
    static var items : [String] = [String]();
    
    //options
    var cellBordersVisible:Bool = true;
    
    
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

        //Super
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        //@todo     init code
        
        print("ViewController.init():        Initialization complete");
        
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
        print("Font: \((textField.font?.fontName)!), size: \((textField.font?.pointSize)!)");
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

        let searchButton : UIButton = UIButton(frame: CGRect(x: 194+25+10+10, y: 30-1, width: 25, height: 25));
        searchButton.translatesAutoresizingMaskIntoConstraints = true;
        searchButton.setBackgroundImage(UIImage(named:"Search Glass"), for: UIControlState());
        searchButton.addTarget(self, action: #selector(self.searchPressed(_:)), for:  .touchUpInside);
        self.view.addSubview(searchButton);
        
        let bookmarkButton : UIButton = UIButton(frame: CGRect(x: 194+25+10+25+10+20-1, y: 30-1, width: 25, height: 25));
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = true;
        bookmarkButton.setBackgroundImage(UIImage(named:"Bookmark Tab"), for: UIControlState());
        bookmarkButton.addTarget(self, action: #selector(self.bookmarkPressed(_:)), for:  .touchUpInside);
        self.view.addSubview(bookmarkButton);
                
        //Add components
        textBar.addSubview(textField);
        view.addSubview(textBar);
        self.view.addSubview(listButton);
        self.view.addSubview(optionButton);
       
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
        aNoteTableHandler = ANoteTableViewHandler(items: ViewController.items, mainView: self.view, ANoteTable: aNoteTable);
        
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
    /** @fcn        getItems() -> [String]
     *  @brief      get items of table
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func getItems() -> [String] {
        return items;
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
    

    /********************************************************************************************************************************/
    /** @fcn        func settingsPressed(_: (UIButton?))
     *  @brief      handle the settings button selection
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func settingsPressed(_: (UIButton?)) {
        print("settings was pressed");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        func bookmarkPressed(_: (UIButton?))
     *  @brief      handle the bookmark button selection
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func bookmarkPressed(_: (UIButton?)) {
        print("bookmark was pressed");
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        func searchPressed(_: (UIButton?))
     *  @brief      handle the search button selection
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func searchPressed(_: (UIButton?)) {
        print("search was pressed");
        return;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        func listPressed(_: (UIButton?))
     *  @brief      handle the search button selection
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func listPressed(_: (UIButton?)) {
        print("list was pressed");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        func optionPressed(_: (UIButton?))
     *  @brief      handle the search button selection
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func optionPressed(_: (UIButton?)) {
        print("option was pressed");
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
}

