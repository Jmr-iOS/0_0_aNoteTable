/************************************************************************************************************************************/
/** @file		CellSubview
 * 	@brief		x
 * 	@details	x
 *
 * 	@notes		x
 *
 * 	@section	Opens
 * 		none current
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class CellSubview : UIView {
    
    
    var returnButton : UIButton!;                                   /* return button of the subview                                 */
    var mainView     : UIView!;                                     /* main view of app                                             */
    
    
    /********************************************************************************************************************************/
	/**	@fcn		init(mainView : UIView)
	 *  @brief		x
     *
     *  @param      [in] (UIView) mainView - main view of app
     */
	/********************************************************************************************************************************/
    init(mainView : UIView) {
        super.init(frame: UIScreen.main.bounds);
        
        //Store
        self.mainView = mainView;
        
        //Init Vars
        let windowHeight : CGFloat = 150;
        let windowWidth  : CGFloat = 360;
        
        let borderSize : CGFloat = 2;
        let borderColor : CGColor = UIColor(red:   140/255, green: 140/255, blue:  140/255, alpha: 1.0).cgColor; //Apple Border Color

        
        //**************************************************************************************************************************//
        //                                              INIT UI                                                                     //
        //**************************************************************************************************************************//
        self.backgroundColor = UIColor.white;
        self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 375);
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: windowWidth, height: windowHeight);    /* init offset      */
 
        //Generate upper border for the View
        let upperBorder : CALayer = CALayer();
        upperBorder.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: borderSize);
        upperBorder.backgroundColor = borderColor;
 
        //Generate bottom border for the View
        let bottomBorder : CALayer = CALayer();
        bottomBorder.frame = CGRect(x: 0, y: windowHeight - borderSize, width: self.frame.width, height: borderSize);
        bottomBorder.backgroundColor = borderColor;
 
        //Generate left border for the View
        let leftBorder : CALayer = CALayer();
        leftBorder.frame = CGRect(x: 0,y: 0, width: borderSize, height: self.frame.height);
        leftBorder.backgroundColor = borderColor;
 
        //Generate left border for the View
        let rightBorder : CALayer = CALayer();
        rightBorder.frame = CGRect(x: self.frame.width-borderSize, y: 0, width: borderSize, height: self.frame.height);
        rightBorder.backgroundColor = borderColor;
 
        //Add border
        self.layer.addSublayer(upperBorder);          /* note - it could be added to self.view.layer instead if desired   */
        self.layer.addSublayer(bottomBorder);
        self.layer.addSublayer(leftBorder);
        self.layer.addSublayer(rightBorder);


        //**************************************************************************************************************************//
        //                                            INIT BUTTON                                                                   //
        //**************************************************************************************************************************//
        self.returnButton = UIButton(type: UIButtonType.roundedRect);
 
        self.returnButton.translatesAutoresizingMaskIntoConstraints = true;
        self.returnButton.setTitle("Return",      for: UIControlState());
        self.returnButton.backgroundColor = UIColor.green;
        self.returnButton.sizeToFit();
        self.returnButton.center = CGPoint(x: self.mainView.center.x, y: 50);
        self.returnButton.addTarget(self, action: #selector(self.returnPress(_:)), for:  .touchUpInside);
        
        //Add button
        self.addSubview(self.returnButton);
        
        //@temp for debug validation
        self.backgroundColor = UIColor.red;
        print("My Custom Cell SubView Init");
 
        return;
    }
    
    /********************************************************************************************************************************/
	/**	@fcn		returnPress(_ sender: UIButton!)
	 *  @brief		return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     */
	/********************************************************************************************************************************/
    @objc func returnPress(_ sender: UIButton!) {
        
        print("Return was pressed, dismissing view");
        
        //Move Frame offscreen
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.frame.width, height: self.frame.height);

        //Dismiss
        self.dismissSubView();
        
        return;
    }
 
    
    /********************************************************************************************************************************/
    /* @fcn       dismissSubView()                                                                                                  */
    /* @details   dismiss the subview                                                                                               */
    /* @todo      dims to globals                                                                                                   */
    /* @todo      globals to 'g'                                                                                                    */
    /********************************************************************************************************************************/
    func dismissSubView() {
        
        self.frame = CGRect(x: 10, y: 350, width: 360, height: 150);
        
        //Slide in View
        UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            print("sliding view in!");
            self.alpha = 1.0;
            self.frame = CGRect(x: 10, y: UIScreen.main.bounds.height, width: 360, height: 150);
        }, completion: { (finished: Bool) -> Void in
            print("sliding view in completion!");
            self.frame = CGRect(x: 10, y: UIScreen.main.bounds.height, width: 360, height: 150);
        });
        
        self.mainView.reloadInputViews();
        
        return;
    }
    
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}

