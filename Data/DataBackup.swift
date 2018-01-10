/************************************************************************************************************************************/
/** @file		DataBackup.swift
 *	@project    0_0 - aNoteTable
 * 	@brief		x
 * 	@details	x
 *
 * 	@notes		x
 *
 * 	@section	Opens
 *          implemented backup & validated
 *          changed to global use of 'verbose'
 *          define a rows data to save and document or store
 *          store VC automatically (M)
 *
 *  @section    Data Definition
 *          UI    - none at present
 *          Table - [Cell Data] (one per row, non-volatile cell data)
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class DataBackup : NSObject, NSCoding {

    //Class Data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL         = DocumentsDirectory.appendingPathComponent("ANote_Ref_Sw_Bak4b");

    static let verbose : Bool = true;                                       /* given a seperate backup declaration for verbosity    */
    
    //System value FOR backup
    static var vc : ViewController!;                                        /* for use and access to data during a backup store/load*/

    //Backup Data
    var rows      : [ANoteRow]?;

    
//MARK: Initialization
    /********************************************************************************************************************************/
    /** @fcn        init?()
     *  @brief      initialization from backup
     *  @details    used by convienence init
     *  @param      [in] ([ANoteRow]?)  rows - rows of table
     */
    /********************************************************************************************************************************/
    init?(rows : [ANoteRow]?) {
        
        if(DataBackup.verbose) { print("DataBackup.init?():                 initialization from backup begin"); }

        self.rows = rows;

        super.init();
        
        if(DataBackup.verbose) { print("DataBackup.init?():                 initialization from backup complete"); }
        
        return;
    }


// MARK: NSCoding
    //Store
    /********************************************************************************************************************************/
    /** @fcn        encode()
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (NSCoder) aCoder - x
     */
    /********************************************************************************************************************************/
    func encode(with aCoder: NSCoder) {

        if(DataBackup.verbose) { print("DataBackup.encodeWithCoder():       storage init"); }

        let _ : Bool = ANoteRow.ANoteRowClass.saveStocksArray(rowArray: self.rows!);

        if(DataBackup.verbose) { print("DataBackup.encodeWithCoder():       storage complete"); }

        return;
    }
    
    
    //Retrieve
    /********************************************************************************************************************************/
    /** @fcn        convenience init?()
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (NSCoder) coder - x
     */
    /********************************************************************************************************************************/
    required convenience init?(coder aDecoder: NSCoder) {

        let rowsBackup : [ANoteRow]?  = ANoteRow.ANoteRowClass.loadStocksArray();
        
        var respStr : String;
        
        if(rowsBackup != nil) {
            if(rowsBackup!.count > 0) {
                respStr = rowsBackup![0].main!;
            } else {
                respStr = "nil";
            }
        } else {
            respStr = "empty";
        }
        
        if(DataBackup.verbose) { print("DataBackup.convience.init?():       retrieved '\(String(describing: respStr))' for rows[0].main"); }
        
        self.init(rows: rowsBackup);
        
        if(DataBackup.verbose) { print("DataBackup.convience.init?():       initialization complete"); }
        
        return;
    }


// MARK: Code Interface
    /********************************************************************************************************************************/
    /*	@fcn		class func loadData()                                                                                           */
    /*  @brief      retrieve the App data & state to from file backup                                                               */
    /*  @details    calls convienence init() on backup retrieval                                                                    */
    /*  @pre        vc is stored                                                                                                    */
    /********************************************************************************************************************************/
    class func loadData() {

        let vc : ViewController;
        
        //@pre
        if(!DataBackup.exists()) {
            print("DataBackup.loadData():             warning, vc not stored on call, aborting load");
            return;
        } else {
            vc = DataBackup.vc!;                                            /* grab vc                                              */
        }
        
        if(DataBackup.verbose) { print("DataBackup.loadData():              entering NSKeyedUnarchiver search"); }
        let retrievedData : DataBackup? = NSKeyedUnarchiver.unarchiveObject(withFile: DataBackup.ArchiveURL.path) as? DataBackup;
        if(DataBackup.verbose) { print("DataBackup.loadData():              exiting NSKeyedUnarchiver search with '\(retrievedData != nil)' status"); }

        //Grab archive
        let retrievedRows : [ANoteRow]? = (retrievedData?.rows);

        //Apply if found
        if(retrievedRows != nil) {
            vc.rows = retrievedRows!;
        }
        
        return;
    }


    /********************************************************************************************************************************/
    /*	@fcn		class func saveData()                                                                                           */
    /*  @brief      save the App data & state from the view controller access to file for later retrieval                           */
    /*  @pre        vc is stored                                                                                                    */
    /*  @assum      bak is valid data                                                                                               */
    /********************************************************************************************************************************/
    class func saveData() {

        let vc : ViewController = DataBackup.vc;                            /* grab vc                                              */
        
        
        //**************************************************************************************************************************//
        //                                          GEN BACKUP FOR STORAGE                                                          //
        //**************************************************************************************************************************//
        let currRows  : [ANoteRow]  = vc.rows;
        
        let backup : DataBackup = DataBackup(rows: currRows)!;

        
        //**************************************************************************************************************************//
        //                                             STORE BACKUP                                                                 //
        //**************************************************************************************************************************//
        let backupSaveStatus = NSKeyedArchiver.archiveRootObject(backup,      toFile: DataBackup.ArchiveURL.path);        

        if(verbose) { print("DataBackup.saveData():              name save status is '\(backupSaveStatus)' "); }

        return;
    }
    
    
    /********************************************************************************************************************************/
    /*	@fcn		class func updateBackup()                                                                                       */
    /*  @brief      a clean wrapper for simple and clear code architecture communication                                            */
    /********************************************************************************************************************************/
    class func updateBackup() {
        DataBackup.saveData();
        return;
    }
    
    
    /********************************************************************************************************************************/
    /*	@fcn		class func storeViewController(vc : ViewController)                                                             */
    /*  @brief      x                                                                                                               */
    /*                                                                                                                              */
    /*  @param      [in] (ViewController) vc - x                                                                                    */
    /********************************************************************************************************************************/
    class func storeViewController(_ vc : ViewController) {
        DataBackup.vc = vc;
        return;
    }
    
    
    /********************************************************************************************************************************/
    /*  @fcn        class func storeViewController(vc : ViewController)                                                             */
    /*  @brief      x                                                                                                               */
    /*  @details    calls convienence init() on backup retrieval                                                                    */
    /*                                                                                                                              */
    /*  @return     (Bool) if backup present                                                                                        */
    /********************************************************************************************************************************/
    class func exists() -> Bool {
        let retrievedData : DataBackup? = NSKeyedUnarchiver.unarchiveObject(withFile: DataBackup.ArchiveURL.path) as? DataBackup;
        return (retrievedData != nil);
    }
}

