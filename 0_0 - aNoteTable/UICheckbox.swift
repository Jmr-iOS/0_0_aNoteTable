//
//  UICheckBox.swift
//  0_0 - newNoteTable
//
//  URL: http://stackoverflow.com/questions/2599451/cabasicanimation-delegate-for-animationdidstop
//

import UIKit

class UICheckbox: UIView {
    
    //state
    var checkBoxImg : UIImageView!;
    var parentCell  : ANoteTableViewCell!;
    var state       : Bool = false;

    //images
    var uncheckedImage  :UIImage = UIImage(named:"anote_unchecked")!;
    var checkedImage    :UIImage = UIImage(named:"anote_checked")!;
    
    //threads
    let loadDelay_s : Double = 0.070;
    
    var loadThread : NSTimer!;
    var fadeThread : NSTimer!;
    
    /************************************************************************************************************************************/
    /* @fcn       init(view:UIView, parentCell: ANoteTableViewCell, xCoord:CGFloat, yCoord:CGFloat)                                     */
    /* @brief                                                                                                                           */
    /************************************************************************************************************************************/
    init(view:UIView, parentCell: ANoteTableViewCell, xCoord:CGFloat, yCoord:CGFloat) {

        super.init(frame:CGRectMake(0, 0, globals.cellOffs_Left(), globals.aNoteRowHeight()));  //make it to the tap size you want

        //store
        self.parentCell = parentCell;
        
        //image init
        checkBoxImg       = UIImageView(image: uncheckedImage);
        checkBoxImg.frame = CGRectMake(xCoord/*0*/, yCoord/*0*/, globals.checkBoxDim(), globals.checkBoxDim());
        
        //handle taps
        self.addTapRecognizer();
        
        //uiview setup: me<-image then main<-main
        self.addSubview(checkBoxImg);
        view.addSubview(self);
        
        if(coloredViews){self.backgroundColor = UIColor.blueColor();}
        
        
        if(verbose){print("UICheckbox.init():                      complete");}
        
        return;
    }

    
    /************************************************************************************************************************************/
    /* @fcn       addTapRecognizer()                                                                                                    */
    /* @details   handle taps, img change and fade                                                                                      */
    /************************************************************************************************************************************/
    func addTapRecognizer() {
        
        //Base Handle
        let tapRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:");

        //Tap Config
        tapRecognizer.numberOfTapsRequired    = 1;
        tapRecognizer.numberOfTouchesRequired = 1;
        
        //Gesture Config
        self.addGestureRecognizer(tapRecognizer);
        self.userInteractionEnabled = true;
        
        return;
    }
    

    /************************************************************************************************************************************/
    /* @fcn       handleTap(recognizer:UITapGestureRecognizer)                                                                          */
    /* @details   the self->UITapGestureRecognizer is set to call this on a tap                                                         */
    /************************************************************************************************************************************/
    func handleTap(recognizer:UITapGestureRecognizer) {
        
        //Swap w/Fade
        let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents");
        
        fadeAnim.fromValue = (self.checkBoxImg.image == uncheckedImage) ? uncheckedImage:checkedImage;
        fadeAnim.toValue   = (self.checkBoxImg.image == uncheckedImage) ? checkedImage:uncheckedImage;
        
        fadeAnim.duration = loadDelay_s;
        
        fadeAnim.delegate = self;
        
        
        //Update ImageView & State
        state = (self.checkBoxImg.image == uncheckedImage) ? true : false;    //if it was unchecked, now it's checked, true!

        checkBoxImg.image = (self.checkBoxImg.image == uncheckedImage) ? checkedImage:uncheckedImage;
        
        checkBoxImg.layer.addAnimation(fadeAnim, forKey: "contents");

        
        //Handle the Click
        self.buttonClicked();
        
        return;
    }
    

    /************************************************************************************************************************************/
    /* @fcn       buttonClicked()                                                                                                       */
    /* @details   called in self.handleTap(), when this checkBox is tapped!                                                             */
    /************************************************************************************************************************************/
    func buttonClicked() {
        
        if(verbose) { print("UICheckbox.buttonClicked():    entry"); }
        
        if(verbose) { print("//@todo   add a fade to the text-toggle! You'll need to cross fade to a NEW view of the text!!! see link belo"); }
        if(verbose) { print("//@url    http://stackoverflow.com/questions/2426614/how-to-animate-the-textcolor-property-of-an-uilabel"); }
        
        parentCell.clickResponse();
        
        if(verbose) { print("\(parentCell.tableIndex) was clicked"); }
        
        return;
    }
    
    override func animationDidStop (anim: CAAnimation, finished flag: Bool) { return; }
    override func animationDidStart(anim: CAAnimation) { return; }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder:aDecoder); }
}

