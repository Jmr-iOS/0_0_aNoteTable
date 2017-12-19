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
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
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

        super.init(frame:CGRect(x: 0, y: 0, width: cellOffs_Left_val, height: aNoteRowHeight_val));  //make it to the tap size you want

        //store
        self.parentCell = parentCell;
        
        //image init
        checkBoxImg       = UIImageView(image: uncheckedImage);
        checkBoxImg.frame = CGRect(x: xCoord, y: yCoord, width: checkBoxDim_val, height: checkBoxDim_val);
        
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
        
        if(verbose) { print("UICheckbox.handleTap():   handling tap response"); }
        
        //Get state
        let prevState : Bool =  (self.checkBoxImg.image == checkedImage);           /* was previously selected?                     */
        let newState  : Bool = !prevState;                                          /* inverted on selection                        */
        
        //Swap w/Fade
        let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents");
        
        fadeAnim.fromValue = (prevState) ? checkedImage:uncheckedImage;
        fadeAnim.toValue   = (prevState) ? uncheckedImage:checkedImage;
        
        fadeAnim.duration = loadDelay_s;
        
        fadeAnim.delegate = self as? CAAnimationDelegate;
        
        
        //Update ImageView & State
        state = (prevState) ? false : true;                                      /* if it was unchecked, now it's checked, true!    */

        checkBoxImg.image = (prevState) ? uncheckedImage:checkedImage;

        checkBoxImg.layer.add(fadeAnim, forKey: "contents");

        //Update text
        parentCell.updateSelection(selected: newState);
        
        return;
    }

    
//? override func animationDidStop (_ anim: CAAnimation, finished flag: Bool) { return; }
//? override func animationDidStart(_ anim: CAAnimation) { return; }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder:aDecoder); }
}

