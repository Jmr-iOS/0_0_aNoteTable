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

    //Locals
    var mainView : UIView!;
    var cellSubView : CellSubview!;
    
    //Config
    let cell_fontName : String = cellFont;


    /********************************************************************************************************************************/
    /** @fcn        init(style: UITableViewCellStyle, reuseIdentifier: String?)
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (UIView) mainView - x
     *  @param      [in] (UITableViewCellStyle) style - x
     *  @param      [in] (String?) reuseIdentifier - x
     *
     *  @section    Opens
     *      make row border thinner & set to lighter color
     */
    /********************************************************************************************************************************/
    init(mainView : UIView, style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style:style, reuseIdentifier:reuseIdentifier);
    
        self.mainView = mainView;
        
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
        
        self.cellSubView = CellSubview(mainView: self.mainView, parentCell: self);
        
        self.mainView.addSubview(self.cellSubView);

        //Get Current Cell's Info
        let currRow : Row = rows[indexPath.item];
        
        
        /****************************************************************************************************************************/
        /*                                                      Checkbox                                                            */
        /****************************************************************************************************************************/
        let type : UICheckbox.CellType = (indexPath.row>0) ? .list : .todo;
        
        checkBox = UICheckbox(view:       self,
                              parentCell: self,
                              type:       type,
                              xCoord:     check_xOffs,
                              yCoord:     check_yOffs);
  
        self.addSubview(checkBox);

        
        /****************************************************************************************************************************/
        /*                                                  Main(Subject) Text                                                      */
        /****************************************************************************************************************************/
        let rChunk_width = UIScreen.main.bounds.width - tv_xOffs - tv_width;
        
        let subjFieldWidth : CGFloat = UIScreen.main.bounds.width - cell_xOffs - rChunk_width - tv_width;
        
        if(verbose) { print("ANoteTableViewCell.initialize():    Grabbing \(indexPath.item)"); }
        
        if(indexPath.item < numRows) {
            self.mainText = aNoteTable.items[indexPath.item];
        }

        let font : UIFont = UIFont(name: cell_fontName, size: mt_size)!;
        
        subjectField = UILabel(frame:  CGRect(x:      mt_xOffs,
                                              y:      mt_yOffs,
                                              width:  subjFieldWidth,                               /* '+1' not sure why            */
                                              height: font.pointSize*CGFloat(self.numLines+1)));
        subjectField.font = font;
        subjectField.text = currRow.main;
        subjectField.textAlignment = NSTextAlignment.left;


        //text-wrap
        subjectField.numberOfLines = 0;                                         /* set to 0 for auto-wrap                           */
        subjectField.lineBreakMode = .byWordWrapping;
        
        self.addSubview(subjectField);
        
        
        /****************************************************************************************************************************/
        /*                                                  Description Text                                                        */
        /****************************************************************************************************************************/
        let descrFieldWidth : CGFloat = UIScreen.main.bounds.width - cell_xOffs - rChunk_width;
        
        descripField = UILabel(frame: CGRect(x: descr_xOffs,
                                             y: descr_yOffs,
                                             width: descrFieldWidth,
                                             height: descr_height));
        
        descripField.text = currRow.body;

        descripField.font = UIFont(name: cell_fontName, size: descr_size);
        descripField.textAlignment = NSTextAlignment.left;
        descripField.textColor = descr_color;
        
        self.addSubview(descripField);
        
        
        /****************************************************************************************************************************/
        /*                                                      Bott Text                                                           */
        /****************************************************************************************************************************/
        let bottFieldWidth : CGFloat = UIScreen.main.bounds.width - cell_xOffs - rChunk_width;
        
        bottField = UILabel(frame: CGRect(x:bott_xOffs, y: bott_yOffs, width: bottFieldWidth, height:  bott_height));

        bottField.text = currRow.bott;
        
        bottField.font = UIFont(name: cell_fontName, size: bott_size);
        bottField.textAlignment = NSTextAlignment.left;
        bottField.textColor = bott_color;

        
        //load bell icon
        var bellIcon : UIImageView;
        bellIcon  = UIImageView();
        bellIcon.frame = CGRect(x: bell_xOffs, y: bell_yOffs, width: bell_width, height: bell_height);
        bellIcon.image = UIImage(named:"bell");
        
        //add it
        self.addSubview(bottField);
        self.addSubview(bellIcon);
        
        
        /****************************************************************************************************************************/
        /*                                                      Time Label                                                          */
        /****************************************************************************************************************************/
        let timeView : UIView = UIView(frame: CGRect(x:      tv_xOffs,
                                                     y:      tv_yOffs,
                                                     width:  tv_width,
                                                     height: tv_height));
        
        timeView.backgroundColor = nearColor_val;
        timeView.layer.cornerRadius = tv_corner;
        
        let timeLabel : UILabel = UILabel(frame: CGRect(x: tl_xOffs, y: tl_yOffs, width: tl_width, height:  tl_height));
        
        timeLabel.font  =   UIFont(name: cell_fontName, size: tl_size);
        timeLabel.text  =   "4:30 PM";
        timeLabel.textColor     = UIColor.white;
        timeLabel.textAlignment = NSTextAlignment.left;
        
        timeView.addSubview(timeLabel);
        
        //add it
        self.addSubview(timeView);
        
        return;
    }


    /********************************************************************************************************************************/
    /* @fcn       launchSubView()                                                                                                   */
    /* @details   launch the subview                                                                                                */
    /********************************************************************************************************************************/
    func launchSubView() {

        self.cellSubView.frame = g.getCSFrame(onscreen: false);
        
        //Slide in View
        UIView.animate(withDuration: launch_dur_s, delay: launch_del_s, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                print("ANoteTableViewCell.launchSubView(): sliding view in!");
                self.cellSubView.alpha = 1.0;
                self.cellSubView.frame = g.getCSFrame(onscreen: true);
        }, completion: { (finished: Bool) -> Void in
                print("ANoteTableViewCell.launchSubView(): sliding view in completion!");
            self.cellSubView.frame = g.getCSFrame(onscreen: true);
        });

        self.mainView.reloadInputViews();
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        getNumber() -> Int
     *  @brief      x
     *  @details    x
     *
     *  @return     (Int) number of active cell (e.g. '2' for Item #2)
     */
    /********************************************************************************************************************************/
    func getNumber() -> Int {
        return (tableIndex+1);
    }

    
    /********************************************************************************************************************************/
    /** @fcn        updateSelection(selected : Bool)
     *  @brief      update selected state of cell
     *  @details    cross out main text and greyed when selected
     *
     *  @param      [in] (Bool) selected - if the cell is selected (check box checked off)
     */
    /********************************************************************************************************************************/
    func updateSelection(selected : Bool) {
        
        if(selected) {
            if(verbose) { print("ANoteTableViewCell.updateSelection():   Selected"); }
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.subjectField.text!);
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length));
            
            self.subjectField.attributedText = attributeString;
            
            self.subjectField.textColor = UIColor.gray;
            
        } else {
            if(verbose) { print("ANoteTableViewCell.updateSelection():   Not Selected"); }
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.subjectField.text!);
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 0, range: NSMakeRange(0, attributeString.length));
            
            self.subjectField.attributedText = attributeString;
            
            self.subjectField.textColor = UIColor.black;
        }
        
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

