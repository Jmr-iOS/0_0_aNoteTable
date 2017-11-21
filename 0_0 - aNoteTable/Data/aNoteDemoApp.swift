/************************************************************************************************************************************/
/** @file        aNoteDemoApp.swift
 *  @project     0_0 - aNoteTable
 *  @details     data for the example display of table
 *
 *  @section    Opens
 *      none current
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import Foundation

class aNoteDemoApp : NSObject {

    let N : Int = 10;                                           /* table contains 10 entries, screen displays 5 at a time           */
    var rows : [Row] = [Row]();
    
    //******************************************************************************************************************************//
    //                                                               PROTOTYPES                                                     //
    //******************************************************************************************************************************//
    struct Row {
        var main : String!;                                     /* primary text to display                                          */
        var body : String!;                                     /* sub text displayed below main and smaller                        */
        var time : Int!;                                        /* minutes of day since 12:00 am                                    */
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        override init()
     *  @brief      x
     *  @details    x
     *
     *  @section    Time Values
     *      3:00..4:00...7:00..8:00
     */
    /********************************************************************************************************************************/
    override init() {
        super.init();

        //Nice and simple, make rows to match Images/Ref:aNoteRef.jpg
        for i in 0...(N-1) {
            
            //Main Text
            let mainText : String = String(format: "Item #%i", (i+1));
            
            //Body Text
            var bodyText : String = "Some misc. text";
            
            if(i == 0) {
                bodyText = "Some text below that is short";
            }
            
            //Time Val
            let newTime : Int = ((i+3+12)*60);                      /* minutes since 12:00am today                                  */
            
            rows.append(Row(main: mainText, body: bodyText, time: newTime));
        }

        return;
    }


    func getRows() -> [Row] {
        return self.rows;
    }
}



