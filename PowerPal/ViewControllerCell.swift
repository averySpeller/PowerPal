//
//  ViewControllerCell.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-23.
//  Copyright © 2018 Avery Speller. All rights reserved.
//

import UIKit
import SQLite3

class ViewControllerCell: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var TableViewUser: UITableView!
    
    var UserList = [User]()
    var db: OpaquePointer?
    
    override func viewWillAppear(_ animated: Bool) {
        readValues()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("UserDatabase.sqlite")
        
        if sqlite3_open(fileURL.path,&db) != SQLITE_OK{
            print ("Error Opening Database")
            return
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY AUTOINCREMENT, height INTEGER, weight INTEGER, benchMax INTEGER, squatMax INTEGER, DLMax INTEGER, wilks DOUBLE)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return
        }
        
        
        
        
        
        
        /*if sqlite3_exec(db, "DELETE * FROM User", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return
        }*/
        readValues()
        print("Everything is fine")

        // Do any additional setup after loading the view.
    }

    
    

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this method is giving the row count of table view which is
        //total number of heroes in the list
        return UserList.count
    }
    
    
    //this method is binding the hero name with the tableview cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let user: User
        user = UserList.reversed()[indexPath.row]
        
        
        
        cell.labelHeight.text = String(user.height)
        cell.labelWeight.text = String(user.weight)
        cell.labelBench.text = String(user.benchMax)
        cell.labelSquat.text = String(user.squatMax)
        cell.labelDL.text = String(user.DLMax)
        
        
        print("wilks is \(user.wilks)")

        //cell.labelWilks.text = String(user.wilks)
        cell.labelID.text = String(format: "%.2f",user.wilks)
        //cell.labelWilks.text = String(user.wilks)
        return cell
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
            print("error preparing insertttt: \(errmsg)")
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
            let wilks = sqlite3_column_double(stmt, 6)
            
            //adding values to list
            UserList.append(User(id: Int(id), height: Int(height),weight: Int(weight),benchMax: Int(benchMax), squatMax: Int(squatMax), DLMax: Int(DLMax), wilks: Double(wilks)))
        }
        self.TableViewUser.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
