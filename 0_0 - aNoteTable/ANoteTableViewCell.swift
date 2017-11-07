//
//  ANoteTableViewCell.swift
//  0_0 - newNoteTable
//

import UIKit

class ANoteTableViewCell: UITableViewCell {
    
    //State
    var tableIndex   : Int!;
    var mainText     : String!;
    let numLines     : Int = 2;
    
    var checkBox     : UICheckbox!;
    var subjectField : UILabel!;
    var descripField : UILabel!;
    var bottField    : UILabel!;

    //Config
    let aNoteRowHeight : CGFloat = globals.aNoteRowHeight();  //emperically chosen
    let checkBoxDim    : CGFloat = globals.checkBoxDim();     //all values
    let checkBox_xOffs : CGFloat = globals.checkBox_xOffs();
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
        super.init(style:style, reuseIdentifier:reuseIdentifier);
        
        if(verbose){ print("aNoteTableViewCell.init():          cell was initialized"); }
    
        return;
    }
    
    

    /************************************************************************************************************************************/
    /* @fcn       initialize(indexPath : NSIndexPath, aNoteTable : aNoteTableView)                                                      */
    /* @details   initialize the cell, after creation                                                                                   */
    /************************************************************************************************************************************/
    func initialize(indexPath : NSIndexPath, aNoteTable : ANoteTableView) {
        
        if(verbose){print("UITableViewCell.initialize():          adding: '\(aNoteTable.items[indexPath.item])'");}

        self.tableIndex = indexPath.item;
        
        
        /********************************************************/
        /* Checkbox                                             */
        /********************************************************/
        checkBox = UICheckbox(view:       self,
                              parentCell: self,
                              xCoord:     checkBox_xOffs,
                              yCoord:     ((aNoteRowHeight-checkBoxDim)/2)/2 - 9); //why div 2, div 2? hell if I know, emperically found!!!!
        
        self.addSubview(checkBox);
        
        /*******************************************************/
        /* Main(Subject) Text                                  */
        /*******************************************************/
        let rightScreenChunk_Width = UIScreen.mainScreen().bounds.width - globals.timeView_xOffs() - globals.timeView_Width();
        
        let subjFieldWidth : CGFloat = UIScreen.mainScreen().bounds.width - globals.cellOffs_Left() - rightScreenChunk_Width - globals.timeView_Width();
        
        if(indexPath.item == 0) {
            self.mainText = "Example aNote Subject Field And Your Momma's House, and why I think this is clear. It is because";
        } else {
            self.mainText = aNoteTable.items[indexPath.item];
        }

        subjectField = UILabel(frame:  CGRect(x:      globals.cellOffs_Left(),
                                              y:      globals.subjFieldYOffs(),
                                              width:  subjFieldWidth,
                                              height: globals.subjFont.pointSize*CGFloat(self.numLines+1))); //'+1', I  //have no idea why... emperically works
        subjectField.text = self.mainText;
        subjectField.font = globals.subjFont;
        subjectField.textAlignment = NSTextAlignment.Left;


        //text-wrap
        subjectField.numberOfLines = 0; //set to 0 for auto-wrap
        subjectField.lineBreakMode = .ByWordWrapping;
        
        self.addSubview(subjectField);
        
        
        
        
        
        /*******************************************************/
         /* Description Text                                    */
         /*******************************************************/
        let descrFieldWidth : CGFloat = UIScreen.mainScreen().bounds.width - globals.cellOffs_Left() - rightScreenChunk_Width;
        
        descripField = UILabel(frame: CGRect(x:globals.cellOffs_Left(), y: globals.descripYOffs(), width: descrFieldWidth, height:  globals.descripHeight()));
        
        if(indexPath.item == 0) {
            descripField.text = "Some description of the item";
        } else {
            descripField.text = aNoteTable.items[indexPath.item];
        }

        descripField.font = UIFont(name: self.textLabel!.font.fontName, size: 14);
        descripField.textAlignment = NSTextAlignment.Left;
        descripField.textColor = UIColor.grayColor();
        
        self.addSubview(descripField);
        
        
        /*******************************************************/
         /* Bott Text                                    */
         /*******************************************************/
        let bottFieldWidth : CGFloat = UIScreen.mainScreen().bounds.width - globals.cellOffs_Left() - rightScreenChunk_Width;
        
        bottField = UILabel(frame: CGRect(x:globals.cellOffs_Left(), y: globals.bottYOffs(), width: bottFieldWidth, height:  20));
        
        if(indexPath.item == 0) {
            bottField.text = "bott date text";
        } else {
            bottField.text = aNoteTable.items[indexPath.item];
        }
        
        bottField.font = UIFont(name: self.textLabel!.font.fontName, size: 12);
        bottField.textAlignment = NSTextAlignment.Left;
        bottField.textColor = UIColor.grayColor();
        
        self.addSubview(bottField);
        
        
        /********************************************************/
         /* Time Label                                           */
         /********************************************************/
        let timeView : UIView = UIView(frame: CGRect(x:      globals.timeView_xOffs(),
                                                     y:      globals.timeView_yOffs(),
                                                     width:  globals.timeView_Width(),
                                                     height: globals.timeView_Height()));
        
        timeView.backgroundColor = globals.nearColor();
        timeView.layer.cornerRadius = 12;
        
        let timeLabel : UILabel = UILabel(frame: CGRect(x:9, y: 0, width: timeView.frame.width, height:  timeView.frame.height));
        
        timeLabel.font  =   UIFont(name: "HelveticaNeue", size: 10);
        timeLabel.text  =   "4:30 PM";
        timeLabel.textColor     = UIColor.whiteColor();
        timeLabel.textAlignment = NSTextAlignment.Left;
        
        timeView.addSubview(timeLabel);

        
        //color it!
        if(coloredViews){subjectField.backgroundColor = UIColor.redColor();}
        if(coloredViews){descripField.backgroundColor = UIColor.grayColor();}
        if(coloredViews){   bottField.backgroundColor = UIColor.yellowColor();}

        
        //add it
        self.addSubview(timeView);
        
        return;
    }

    
    /************************************************************************************************************************************/
    /* @fcn       clickResponse()                                                                                                       */
    /* @details   set the main text to the new color and state. Called in response to cell click (typ by checkbox)                      */
    /************************************************************************************************************************************/
    func clickResponse() {
        
        //Color
        subjectField.textColor = (self.checkBox.state) ? UIColor.grayColor() : UIColor.blackColor();
        

        //Font & Strikethrough
        let newFontState : Int     = (self.checkBox.state) ? 2 : 0;
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.subjectField.text!);
        
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: newFontState, range: NSMakeRange(0, attributeString.length))
        
        subjectField.attributedText = attributeString;
        
        
        if(verbose) { print("click. it's now \(self.checkBox.state)!"); }
        
        return;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder);
        fatalError("init(coder:) has not been implemented");
    }
    
    
    func numberOfLinesInLabel(yourString: NSString, labelWidth: CGFloat, labelHeight: CGFloat, font: UIFont) -> Int {
        
        let paragraphStyle = NSMutableParagraphStyle()
    
        paragraphStyle.minimumLineHeight = labelHeight;
        paragraphStyle.maximumLineHeight = labelHeight;
        paragraphStyle.lineBreakMode = .ByWordWrapping;
        
        let attributes  : [String: AnyObject] = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle];
        let size        :  CGSize  = yourString.sizeWithAttributes(attributes);
        let stringWidth :  CGFloat = size.width;

        let constrain   :  CGSize  = CGSizeMake(labelWidth, labelHeight);
        
        let numberOfLines = ceil(Double(stringWidth/constrain.width))
        
        return Int(numberOfLines);
    }
}

