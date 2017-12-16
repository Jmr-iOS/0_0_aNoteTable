/************************************************************************************************************************************/
/** @file       ANoteTableViewCell.swift
 *  @brief      x
 *  @details    x
 *
 *  @section    Opens
 *      add images for checkboxes as demo. post as demo to SE
 *
 *  @section    Notes
 *      Color changing is not exposed for the checkbox and the solution is instead to use pictures to apply color
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

class ANoteTableViewCell: UICustomTableViewCell {
    
    //State
    var tableIndex   : Int!;
    var mainText     : String!;
    let numLines     : Int = 2;
    
    var checkBox     : UICheckbox!;
    var subjectField : UILabel!;
    var descripField : UILabel!;
    var bottField    : UILabel!;

    //Config
    let aNoteRowHeight : CGFloat = globals.aNoteRowHeight();                /* emperically chosen                                   */
    let checkBoxDim    : CGFloat = globals.checkBoxDim();                   /* all values                                           */
    let checkBox_xOffs : CGFloat = globals.checkBox_xOffs();
    let checkBox_yOffs : CGFloat = globals.checkBox_yOffs();
    
    let cell_fontName : String = globals.cell_fontName();
    //font sizes here too!
    
    /********************************************************************************************************************************/
    /** @fcn        override init(style: UITableViewCellStyle, reuseIdentifier: String?)
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (UITableViewCellStyle) style - x
     *  @param      [in] (String?) reuseIdentifier - x
     *
     *  @section    Opens
     *      subjectField var defs to Globals
     */
    /********************************************************************************************************************************/
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
        super.init(style:style, reuseIdentifier:reuseIdentifier);
        
        if(verbose){ print("aNoteTableViewCell.init():          cell was initialized"); }
    
        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       initialize(indexPath : NSIndexPath, aNoteTable : aNoteTableView)                                                  */
    /* @details   initialize the cell, after creation                                                                               */
    /********************************************************************************************************************************/
    func initialize(_ indexPath : IndexPath, aNoteTable : ANoteTableView) {
        
        if(verbose){print("UITableViewCell.initialize():          adding: '\(aNoteTable.items[indexPath.item])'");}

        self.tableIndex = indexPath.item;
        
        
        //Get Current Cell's Info
        let demoApp : aNoteDemoApp = aNoteDemoApp();
        let currRow : aNoteDemoApp.Row = demoApp.getRows()[indexPath.item];
        
        
        /****************************************************************************************************************************/
        /*                                                      Checkbox                                                            */
        /****************************************************************************************************************************/
        checkBox = UICheckbox(view:       self,
                              parentCell: self,
                              xCoord:     checkBox_xOffs,
                              yCoord:     checkBox_yOffs);
  
        self.addSubview(checkBox);

        
        /****************************************************************************************************************************/
        /*                                                  Main(Subject) Text                                                      */
        /****************************************************************************************************************************/
        let rightScreenChunk_Width = UIScreen.main.bounds.width - globals.timeView_xOffs() - globals.timeView_Width();
        
        let subjFieldWidth : CGFloat = UIScreen.main.bounds.width - globals.cellOffs_Left() - rightScreenChunk_Width - globals.timeView_Width();
        
        print("Grabbing \(indexPath.item)");
        
        if(indexPath.item < 10) {
            self.mainText = aNoteTable.items[indexPath.item];
        }

        let font : UIFont = UIFont(name: cell_fontName, size: 16)!;
        
        subjectField = UILabel(frame:  CGRect(x:      46,
                                              y:      2,
                                              width:  subjFieldWidth,                               /* '+1' not sure why            */
                                              height: font.pointSize*CGFloat(self.numLines+1)));
        subjectField.font = font;
        subjectField.text = currRow.main;
        subjectField.textAlignment = NSTextAlignment.left;


        //text-wrap
        subjectField.numberOfLines = 0; //set to 0 for auto-wrap
        subjectField.lineBreakMode = .byWordWrapping;
        
        self.addSubview(subjectField);
        
        
        /****************************************************************************************************************************/
        /*                                                  Description Text                                                        */
        /****************************************************************************************************************************/
        let descrFieldWidth : CGFloat = UIScreen.main.bounds.width - globals.cellOffs_Left() - rightScreenChunk_Width;
        
        descripField = UILabel(frame: CGRect(x:globals.cellOffs_Left()-10, y: globals.descripYOffs()-10, width: descrFieldWidth, height:  globals.descripHeight()));
        
        descripField.text = currRow.body;

        descripField.font = UIFont(name: cell_fontName, size: 14);
        descripField.textAlignment = NSTextAlignment.left;
        descripField.textColor = UIColor.gray;
        
        self.addSubview(descripField);
        
        
        /****************************************************************************************************************************/
        /*                                                      Bott Text                                                           */
        /****************************************************************************************************************************/
        let bottFieldWidth : CGFloat = UIScreen.main.bounds.width - globals.cellOffs_Left() - rightScreenChunk_Width;
        
        bottField = UILabel(frame: CGRect(x:globals.cellOffs_Left(), y: globals.bottYOffs()-10, width: bottFieldWidth, height:  20));

        bottField.text = currRow.bott;
        
        bottField.font = UIFont(name: cell_fontName, size: 12);
        bottField.textAlignment = NSTextAlignment.left;
        bottField.textColor = UIColor.gray;
        
        self.addSubview(bottField);
        
        
        /****************************************************************************************************************************/
        /*                                                      Time Label                                                          */
        /****************************************************************************************************************************/
        let timeView : UIView = UIView(frame: CGRect(x:      globals.timeView_xOffs(),
                                                     y:      globals.timeView_yOffs(),
                                                     width:  globals.timeView_Width(),
                                                     height: globals.timeView_Height()));
        
        timeView.backgroundColor = globals.nearColor();
        timeView.layer.cornerRadius = 10;
        
        let timeLabel : UILabel = UILabel(frame: CGRect(x:9, y: 0, width: timeView.frame.width, height:  timeView.frame.height));
        
        timeLabel.font  =   UIFont(name: cell_fontName, size: 9);
        timeLabel.text  =   "4:30 PM";
        timeLabel.textColor     = UIColor.white;
        timeLabel.textAlignment = NSTextAlignment.left;
        
        timeView.addSubview(timeLabel);

        
        //color it!
        if(coloredViews){subjectField.backgroundColor = UIColor.red;}
        if(coloredViews){descripField.backgroundColor = UIColor.gray;}
        if(coloredViews){   bottField.backgroundColor = UIColor.yellow;}
        
        //load bell icon
        var bellIcon : UIImageView;
        bellIcon  = UIImageView();
        bellIcon.frame = CGRect(x: 36, y: 62, width: 13.2, height: 15.0);
        bellIcon.image = UIImage(named:"bell");
        
        //add it
        self.addSubview(timeView);
        self.addSubview(bellIcon);
        
        return;
    }

    
    /********************************************************************************************************************************/
    /* @fcn       clickResponse()                                                                                                   */
    /* @details   set the main text to the new color and state. Called in response to cell click (typ by checkbox)                  */
    /********************************************************************************************************************************/
    func clickResponse() {
        
        //Color
        subjectField.textColor = (self.checkBox.state) ? UIColor.gray : UIColor.black;
        

        //Font & Strikethrough
        let newFontState : Int     = (self.checkBox.state) ? 2 : 0;
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.subjectField.text!);
        
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: newFontState, range: NSMakeRange(0, attributeString.length))
        
        subjectField.attributedText = attributeString;
        
        
        if(verbose) { print("click. it's now \(self.checkBox.state)!"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        required init?(coder aDecoder: NSCoder)
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (NSCoder) coder aDecoder - x
     *
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder);
        fatalError("init(coder:) has not been implemented");
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        func numberOfLinesInLabel(_ yourString: NSString, labelWidth: CGFloat, labelHeight: CGFloat, font: UIFont) -> Int
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (NSString) yourString - x
     *  @param      [in] (CGFloat) labelWidth - x
     *  @param      [in] (CGFloat) labelHeight - x
     *  @param      [in] (UIFont) font - x
     *
     *  @return     (Int) descrip
     *
     */
    /********************************************************************************************************************************/
    func numberOfLinesInLabel(_ yourString: NSString, labelWidth: CGFloat, labelHeight: CGFloat, font: UIFont) -> Int {
        
        let paragraphStyle = NSMutableParagraphStyle()
    
        paragraphStyle.minimumLineHeight = labelHeight;
        paragraphStyle.maximumLineHeight = labelHeight;
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
//!     let attributes  : [String: AnyObject] = [NSAttributedStringKey.font.rawValue: font, NSAttributedStringKey.paragraphStyle.rawValue: paragraphStyle];
//!     let size        :  CGSize  = yourString.size(withAttributes: attributes);
        let size        :  CGSize  = CGSize(width: 1, height: 2);
        let stringWidth :  CGFloat = size.width;

        let constrain   :  CGSize  = CGSize(width: labelWidth, height: labelHeight);
        
        let numberOfLines = ceil(Double(stringWidth/constrain.width))
        
        return Int(numberOfLines);
    }
}

