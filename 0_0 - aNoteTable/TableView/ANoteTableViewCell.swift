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
    let cell_fontName : String = cellFont_val;


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

        self.cellSubView = CellSubview(mainView: self.mainView);
        
        self.mainView.addSubview(self.cellSubView);
        
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
                              xCoord:     checkBox_xOffs_val,
                              yCoord:     checkBox_yOffs_val);
  
        self.addSubview(checkBox);

        
        /****************************************************************************************************************************/
        /*                                                  Main(Subject) Text                                                      */
        /****************************************************************************************************************************/
        let rightScreenChunk_Width = UIScreen.main.bounds.width - timeView_xOffs_val - timeView_Width_val;
        
        let subjFieldWidth : CGFloat = UIScreen.main.bounds.width - cellOffs_Left_val - rightScreenChunk_Width - timeView_Width_val;
        
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
        /* 1a - divider color lighter                                                                                               */
        /* 1b - time & icon over a bit                                                                                              */
        /* 2a - globals -> 'g'                                                                                                      */
        /* 2b - all vars to globals w/clean names (seperate commit)                                                                 */
        /* 3  - cell touchups, see if you can finalize all dims & colors                                                            */
        /****************************************************************************************************************************/
        let descrFieldWidth : CGFloat = UIScreen.main.bounds.width - cellOffs_Left_val - rightScreenChunk_Width;
        
        descripField = UILabel(frame: CGRect(x: cellOffs_Left_val-10,
                                             y: g.descripYOffs()-10,
                                             width: descrFieldWidth,
                                             height: descripHeight_val));
        
        descripField.text = currRow.body;

        descripField.font = UIFont(name: cell_fontName, size: 12);
        descripField.textAlignment = NSTextAlignment.left;
        descripField.textColor = UIColor.gray;
        
        self.addSubview(descripField);
        
        
        /****************************************************************************************************************************/
        /*                                                      Bott Text                                                           */
        /****************************************************************************************************************************/
        let xNewVal : CGFloat = 3+5;

        let bottFieldWidth : CGFloat = UIScreen.main.bounds.width - cellOffs_Left_val - rightScreenChunk_Width;
        
        bottField = UILabel(frame: CGRect(x:cellOffs_Left_val+xNewVal-1, y: g.bottYOffs()-10, width: bottFieldWidth, height:  20));

        bottField.text = currRow.bott;
        
        bottField.font = UIFont(name: cell_fontName, size: 12);
        bottField.textAlignment = NSTextAlignment.left;
        bottField.textColor = UIColor.gray;

        
        //load bell icon
        var bellIcon : UIImageView;
        bellIcon  = UIImageView();
        bellIcon.frame = CGRect(x: 36+xNewVal+1, y: 62, width: 13.2, height: 15.0);
        bellIcon.image = UIImage(named:"bell");
        
        //add it
        self.addSubview(bottField);
        self.addSubview(bellIcon);
        
        
        /****************************************************************************************************************************/
        /*                                                      Time Label                                                          */
        /****************************************************************************************************************************/
        let timeView : UIView = UIView(frame: CGRect(x:      timeView_xOffs_val,
                                                     y:      timeView_yOffs_val,
                                                     width:  timeView_Width_val,
                                                     height: timeView_Height_val));
        
        timeView.backgroundColor = nearColor_val;
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
        
        //add it
        self.addSubview(timeView);
        
        return;
    }

    
    /********************************************************************************************************************************/
    /* @fcn       launchSubView()                                                                                                   */
    /* @details   launch the subview                                                                                                */
    /********************************************************************************************************************************/
    func launchSubView() {

         self.cellSubView.frame = CGRect(x: 10, y: UIScreen.main.bounds.height, width: 360, height: 150);
        
        //Slide in View
        UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                print("sliding view in!");
                self.cellSubView.alpha = 1.0;
                self.cellSubView.frame = CGRect(x: 10, y: 350, width: 360, height: 150);
        }, completion: { (finished: Bool) -> Void in
                print("sliding view in completion!");
                self.cellSubView.frame = CGRect(x: 10, y: 350, width: 360, height: 150);
        });

        self.mainView.reloadInputViews();
        
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

