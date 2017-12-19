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
 *  @section    Data Architecture
 *      each row represents a data entry whose data is captured in completion by the row's cell subview, presented here. all data
 *      fields are thus represented as fields of the cell subview (e.g. nameLabel, etc.)
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class CellSubview : UIView {
    
    //Ref
    var mainView     : UIView!;                                     /* main view of app                                             */
    var parentCell   : ANoteTableViewCell!;
    
    //UI
    var returnButton : UIButton!;                                   /* return button of the subview                                 */

    //Data
    var nameLabel    : UILabel!;
    
    
    /********************************************************************************************************************************/
	/**	@fcn		init(mainView : UIView, parentCell : ANoteTableViewCell)
	 *  @brief		x
     *
     *  @param      [in] (UIView) mainView - main view of app
     *  @param      [in] (ANoteTableViewCell) - parent cell for subview
     */
	/********************************************************************************************************************************/
    init(mainView : UIView, parentCell : ANoteTableViewCell) {
        super.init(frame: UIScreen.main.bounds);
        
        //Store
        self.mainView = mainView;
        self.parentCell = parentCell;

        
        //**************************************************************************************************************************//
        //                                              INIT UI                                                                     //
        //**************************************************************************************************************************//
        self.backgroundColor = UIColor.white;
        self.frame = g.getCSFrame(onscreen: false);
 
        //Generate upper border for the View
        let upperBorder : CALayer = CALayer();
        upperBorder.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: cs_borderSize);
        upperBorder.backgroundColor = cs_borderColor;
 
        //Generate bottom border for the View
        let bottomBorder : CALayer = CALayer();
        bottomBorder.frame = CGRect(x: 0, y: CGFloat(csHeight) - cs_borderSize, width: self.frame.width, height: cs_borderSize);
        bottomBorder.backgroundColor = cs_borderColor;
 
        //Generate left border for the View
        let leftBorder : CALayer = CALayer();
        leftBorder.frame = CGRect(x: 0,y: 0, width: cs_borderSize, height: self.frame.height);
        leftBorder.backgroundColor = cs_borderColor;
 
        //Generate left border for the View
        let rightBorder : CALayer = CALayer();
        rightBorder.frame = CGRect(x: self.frame.width-cs_borderSize, y: 0, width: cs_borderSize, height: self.frame.height);
        rightBorder.backgroundColor = cs_borderColor;
 
        //Add border
        self.layer.addSublayer(upperBorder);                    /* @note    it could be added to self.view.layer instead if desired */
        self.layer.addSublayer(bottomBorder);
        self.layer.addSublayer(leftBorder);
        self.layer.addSublayer(rightBorder);

		//Add name label
        self.nameLabel = UILabel();
        
        self.nameLabel.text = "Item #\(self.parentCell.getNumber()) Subview";
        self.nameLabel.font = UIFont(name: "MarkerFelt-Thin", size: 15);
        self.nameLabel.textColor = UIColor.black;        
        self.nameLabel.numberOfLines = 1;

        self.nameLabel.numberOfLines = 0;
        self.nameLabel.sizeToFit();
        self.nameLabel.textAlignment = .center;
        self.nameLabel.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 15);
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = true;
        
        self.mainView.reloadInputViews();
        self.addSubview(self.nameLabel);


        //**************************************************************************************************************************//
        //                                            INIT BUTTON                                                                   //
        //**************************************************************************************************************************//
        self.returnButton = UIButton(type: UIButtonType.roundedRect);
 
        self.returnButton.translatesAutoresizingMaskIntoConstraints = true;
        self.returnButton.setTitle("Return",      for: UIControlState());
        self.returnButton.backgroundColor = UIColor.green;
        self.returnButton.sizeToFit();
        self.returnButton.center = CGPoint(x: self.mainView.center.x, y: ret_yOffs);
        self.returnButton.addTarget(self, action: #selector(self.returnPress(_:)), for:  .touchUpInside);
        
        //Add button
        self.addSubview(self.returnButton);
        
        //@temp for debug validation
        self.backgroundColor = UIColor.red;
        
        if(verbose) { print("CellSubview.init():                 My Custom Cell SubView Init"); }
 
        return;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		returnPress(_ sender: UIButton!)
	 *  @brief		return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
	/********************************************************************************************************************************/
    @objc func returnPress(_ sender: UIButton!) {
        
        if(verbose) { print("CellSubview.returnPress():  Return was pressed, dismissing view"); }
        
        //Move Frame offscreen
        self.frame = g.getCSFrame(onscreen: false);

        //Dismiss
        self.dismissSubView();
        
        return;
    }
 

    /********************************************************************************************************************************/
    /* @fcn       dismissSubView()                                                                                                  */
    /* @details   dismiss the subview                                                                                               */
    /********************************************************************************************************************************/
    func dismissSubView() {
        
        self.frame = g.getCSFrame(onscreen: true);
        
        //Slide in View
        UIView.animate(withDuration: launch_dur_s, delay: launch_del_s, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            print("CellSubview.dismissSubView():   sliding view out");
            self.alpha = 1.0;
            self.frame = g.getCSFrame(onscreen: false);
        }, completion: { (finished: Bool) -> Void in
            print("CellSubview.dismissSubView():   sliding view out completion");
            self.frame = g.getCSFrame(onscreen: false);
        });
        
        self.mainView.reloadInputViews();
        
        return;
    }
    
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}

