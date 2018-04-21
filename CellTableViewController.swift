//
//  CellTableViewController.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-22.
//  Copyright © 2018 Avery Speller. All rights reserved.
//
/*
import UIKit
import SQLite3
class CellTableViewController: UITableViewController{
    
    var UserList = [User]()
    var db: OpaquePointer?
    

    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this method is giving the row count of table view which is
        //total number of heroes in the list
        return UserList.count
    }
    
    
    //this method is binding the hero name with the tableview cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let user: User
        user = UserList[indexPath.row]
        
        
        
        cell.labelHeight.text = String(user.height)
        cell.labelWeight.text = String(user.weight)
         cell.labelBench.text = String(user.benchMax)
         cell.labelSquat.text = String(user.squatMax)
         cell.labelDL.text = String(user.DLMax)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        readValues()
    }
  
    func readValues(){
        
        //first empty the list of user
        UserList.removeAll()
        
        //this is our select query
        let queryString = "SELECT * FROM User"
        
        //statement pointer
        var stmt:OpaquePointer?
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let height = sqlite3_column_int(stmt, 1)
            let weight = sqlite3_column_int(stmt, 2)
            let benchMax = sqlite3_column_int(stmt, 3)
            let squatMax = sqlite3_column_int(stmt, 4)
            let DLMax = sqlite3_column_int(stmt, 5)
            
            //adding values to list
            UserList.append(User(id: Int(id), height: Int(height),weight: Int(weight),benchMax: Int(benchMax), squatMax: Int(squatMax), DLMax: Int(DLMax)))
            
            // print(UserList[1])
        }
        
        //print(UserList)
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}*/
