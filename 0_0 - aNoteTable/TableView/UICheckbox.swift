/************************************************************************************************************************************/
/** @file       UICheckBox.swift
 *  @brief      x
 *  @details    x
 *
 *  @section    Opens
 *      x
 *
 *  @section    Reference
 *      http://stackoverflow.com/questions/2599451/cabasicanimation-delegate-for-animationdidstop
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Vioteq related source files are the explicit property on Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
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
    
    var loadThread : Timer!;
    var fadeThread : Timer!;
    
    /********************************************************************************************************************************/
    /* @fcn       init(view:UIView, parentCell: ANoteTableViewCell, xCoord:CGFloat, yCoord:CGFloat)                                 */
    /* @brief                                                                                                                       */
    /********************************************************************************************************************************/
    init(view:UIView, parentCell: ANoteTableViewCell, xCoord:CGFloat, yCoord:CGFloat) {

        super.init(frame:CGRect(x: 0, y: 0, width: globals.cellOffs_Left(), height: globals.aNoteRowHeight()));  //make it to the tap size you want

        //store
        self.parentCell = parentCell;
        
        //image init
        checkBoxImg       = UIImageView(image: uncheckedImage);
        checkBoxImg.frame = CGRect(x: xCoord/*0*/, y: yCoord/*0*/, width: globals.checkBoxDim(), height: globals.checkBoxDim());
        
        //handle taps
        self.addTapRecognizer();
        
        //uiview setup: me<-image then main<-main
        self.addSubview(checkBoxImg);
        view.addSubview(self);
        
        if(coloredViews){self.backgroundColor = UIColor.blue;}
        
        
        if(verbose){print("UICheckbox.init():                      complete");}
        
        return;
    }

    
    /*********************************************************************************************************************************/
    /* @fcn       addTapRecognizer()                                                                                                */
    /* @details   handle taps, img change and fade                                                                                  */
    /* @note      @objc exposed to enabled handleTap() access, not sure why                                                         */
    /********************************************************************************************************************************/
    @objc func addTapRecognizer() {
        
        //Base Handle
        let tapRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UICheckbox.handleTap(_:)));

        //Tap Config
        tapRecognizer.numberOfTapsRequired    = 1;
        tapRecognizer.numberOfTouchesRequired = 1;
        
        //Gesture Config
        self.addGestureRecognizer(tapRecognizer);
        self.isUserInteractionEnabled = true;
        
        return;
    }
    

    /********************************************************************************************************************************/
    /* @fcn       handleTap(recognizer:UITapGestureRecognizer)                                                                      */
    /* @details   the self->UITapGestureRecognizer is set to call this on a tap                                                     */
    /********************************************************************************************************************************/
    @objc func handleTap(_ recognizer:UITapGestureRecognizer) {
        
        //Swap w/Fade
        let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents");
        
        fadeAnim.fromValue = (self.checkBoxImg.image == uncheckedImage) ? uncheckedImage:checkedImage;
        fadeAnim.toValue   = (self.checkBoxImg.image == uncheckedImage) ? checkedImage:uncheckedImage;
        
        fadeAnim.duration = loadDelay_s;
        
        fadeAnim.delegate = self as? CAAnimationDelegate;
        
        
        //Update ImageView & State
        state = (self.checkBoxImg.image == uncheckedImage) ? true : false;    //if it was unchecked, now it's checked, true!

        checkBoxImg.image = (self.checkBoxImg.image == uncheckedImage) ? checkedImage:uncheckedImage;
        
        checkBoxImg.layer.add(fadeAnim, forKey: "contents");

        
        //Handle the Click
        self.buttonClicked();
        
        return;
    }
    

    /********************************************************************************************************************************/
    /* @fcn       buttonClicked()                                                                                                   */
    /* @details   called in self.handleTap(), when this checkBox is tapped!                                                         */
    /********************************************************************************************************************************/
    func buttonClicked() {
        
        if(verbose) { print("UICheckbox.buttonClicked():    entry"); }
        
        if(verbose) { print("//@todo   add a fade to the text-toggle! You'll need to cross fade to a NEW view of the text!!! see link belo"); }
        if(verbose) { print("//@url    http://stackoverflow.com/questions/2426614/how-to-animate-the-textcolor-property-of-an-uilabel"); }
        
        parentCell.clickResponse();
        
        if(verbose) { print("\(parentCell.tableIndex) was clicked"); }
        
        return;
    }
    
//? override func animationDidStop (_ anim: CAAnimation, finished flag: Bool) { return; }
//? override func animationDidStart(_ anim: CAAnimation) { return; }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder:aDecoder); }
}
