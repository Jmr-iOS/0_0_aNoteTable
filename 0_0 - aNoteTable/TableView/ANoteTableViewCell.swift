/************************************************************************************************************************************/
/** @file       ANoteTableViewCell.swift
 *  @brief      x
 *  @details    x
 *
 *  @section    Opens
 *      x
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
    
    
    /********************************************************************************************************************************/
    /** @fcn        override init(style: UITableViewCellStyle, reuseIdentifier: String?)
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (UITableViewCellStyle) style - x
     *  @param      [in] (String?) reuseIdentifier - x
     *
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

        subjectField = UILabel(frame:  CGRect(x:      globals.cellOffs_Left(),
                                              y:      globals.subjFieldYOffs(),
                                              width:  subjFieldWidth,
                                              height: globals.subjFont.pointSize*CGFloat(self.numLines+1))); //'+1', I have no idea why... emperically works
        subjectField.text = self.mainText;
        subjectField.font = globals.subjFont;
        subjectField.textAlignment = NSTextAlignment.left;


        //text-wrap
        subjectField.numberOfLines = 0; //set to 0 for auto-wrap
        subjectField.lineBreakMode = .byWordWrapping;
        
        self.addSubview(subjectField);
        
        
        /****************************************************************************************************************************/
        /*                                                  Description Text                                                        */
        /****************************************************************************************************************************/
        let descrFieldWidth : CGFloat = UIScreen.main.bounds.width - globals.cellOffs_Left() - rightScreenChunk_Width;
        
        descripField = UILabel(frame: CGRect(x:globals.cellOffs_Left(), y: globals.descripYOffs(), width: descrFieldWidth, height:  globals.descripHeight()));
        
        if(indexPath.item == 0) {
            descripField.text = globals.firstRowText;
        } else if(indexPath.item < 10) {
            descripField.text = globals.descriptionText;
        }

        descripField.font = UIFont(name: self.textLabel!.font.fontName, size: 14);
        descripField.textAlignment = NSTextAlignment.left;
        descripField.textColor = UIColor.gray;
        
        self.addSubview(descripField);
        
        
        /****************************************************************************************************************************/
        /*                                                      Bott Text                                                           */
        /****************************************************************************************************************************/
        let bottFieldWidth : CGFloat = UIScreen.main.bounds.width - globals.cellOffs_Left() - rightScreenChunk_Width;
        
        bottField = UILabel(frame: CGRect(x:globals.cellOffs_Left(), y: globals.bottYOffs(), width: bottFieldWidth, height:  20));
        
        if(indexPath.item == 0) {
            bottField.text = "bott date text";
        } else {
            if(indexPath.item < 10) {
                bottField.text = "";
            }
        }
        
        
        
        bottField.font = UIFont(name: self.textLabel!.font.fontName, size: 12);
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
        timeView.layer.cornerRadius = 12;
        
        let timeLabel : UILabel = UILabel(frame: CGRect(x:9, y: 0, width: timeView.frame.width, height:  timeView.frame.height));
        
        timeLabel.font  =   UIFont(name: "HelveticaNeue", size: 10);
        timeLabel.text  =   "4:30 PM";
        timeLabel.textColor     = UIColor.white;
        timeLabel.textAlignment = NSTextAlignment.left;
        
        timeView.addSubview(timeLabel);

        
        //color it!
        if(coloredViews){subjectField.backgroundColor = UIColor.red;}
        if(coloredViews){descripField.backgroundColor = UIColor.gray;}
        if(coloredViews){   bottField.backgroundColor = UIColor.yellow;}
        
        //add it
        self.addSubview(timeView);
        
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

