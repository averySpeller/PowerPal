//
//  ThirdViewController.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-15.
//  Copyright © 2018 Avery Speller. All rights reserved.
//

import UIKit
import SQLite3

class ThirdViewController: UIViewController{

    

    
    var UserList = [User]()
    var db: OpaquePointer?
    
  //  @IBOutlet weak var UserTableView: UITableView!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var BenchTextField: UITextField!
    @IBOutlet weak var squatTextField: UITextField!
    @IBOutlet weak var DLTextField: UITextField!
    @IBOutlet weak var labelWilks: UILabel!
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        
        var height = ""
        height = (heightTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        var weight = ""
        weight = (weightTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        var benchMax = ""
        benchMax = (BenchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        var squatMax = ""
        squatMax = (squatTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        var DLMax = ""
        DLMax = (DLTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        var wilks: Double
        wilks = 0.0
        wilks = calcWilks(weight: Double(weight)!, bench: Double(benchMax)!, squat: Double(squatMax)!, DL: Double(DLMax)!)
        print (wilks)
        
        //validating that values are not empty
        if(height.isEmpty){
            heightTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(weight.isEmpty){
            weightTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        if(benchMax.isEmpty){
            BenchTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        if(squatMax.isEmpty){
            squatTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        if(DLMax.isEmpty){
            DLTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        //creating a statement
        var stmt: OpaquePointer?
        
        //the insert query
        let queryString = "INSERT INTO User (height,weight,benchMax,squatMax,DLMax,wilks) VALUES (?,?,?,?,?,?)"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //binding the parameters
        if sqlite3_bind_int(stmt, 1, (height as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding height: \(errmsg)")
            return
        }
        if sqlite3_bind_int(stmt, 2, (weight as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding weight: \(errmsg)")
            return
        }
        if sqlite3_bind_int(stmt, 3, (benchMax as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding benchMax: \(errmsg)")
            return
        }
        if sqlite3_bind_int(stmt, 4, (squatMax as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding squatMax: \(errmsg)")
            return
        }
        if sqlite3_bind_int(stmt, 5, (DLMax as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding DLMax: \(errmsg)")
            return
        }
        if sqlite3_bind_double(stmt, 6, wilks) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding wilks: \(errmsg)")
            return
        }
        
        //executing the query to insert values
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting User: \(errmsg)")
            return
        }
        //emptying the textfields
        heightTextField.text=""
        weightTextField.text=""
        BenchTextField.text=""
        squatTextField.text=""
        DLTextField.text=""
    
        
        labelWilks.text = String(format: "%.2f", calcWilks(weight: Double(weight)!, bench: Double(benchMax)!, squat: Double(squatMax)!, DL: Double(DLMax)!))
        
        

        
        
        //wilksScore()
       // readValues()
        
        //displaying a success message
        print("User info saved successfully")
    }

    func calcWilks(weight: Double, bench: Double, squat: Double, DL: Double)-> Double{
        
        
        var a, b, c, d, e, f: Double
        var totalLifted: Double
        var wilksScore: Double
        let bodyWeight = weight
        
        
        totalLifted = bench + squat + DL
        
        a = -216.0475144
        b = 16.2606339
        c = -0.002388645
        d = -0.00113732
        e = 0.00000701863
        f = -0.00000001291
        
        wilksScore = a + (b * bodyWeight)
        wilksScore = wilksScore + c * pow(bodyWeight,2)
        wilksScore = wilksScore + d * pow(bodyWeight,3)
        wilksScore = wilksScore + e * pow(bodyWeight,4)
        wilksScore = wilksScore + f * pow(bodyWeight,5)
        
        wilksScore = 500 / wilksScore
        
        wilksScore = totalLifted * wilksScore

        
        return wilksScore
    }
    
    func printwilksScore(){
        UserList.removeAll()
        
        //this is our select query
        let queryString = "SELECT * FROM User"
        
        //statement pointer
        var stmt:OpaquePointer?
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing iiinsert: \(errmsg)")
            //return
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
            UserList.append(User(id: Int(id), height: Int(height),weight: Int(weight),benchMax: Int(benchMax), squatMax: Int(squatMax), DLMax: Int(DLMax),wilks: Double(wilks)))
            
            // print(UserList[1])
        }
        
        //print(UserList)
       /* var currentValues: Int
        
        for i in UserList{
            currentValues =

        }*/
        var a, b, c, d, e, f: Double
        var totalLifted: Double
        var wilksScore: Double
        let bodyWeight = Double((UserList.last?.weight)!)
        
        totalLifted = Double(UserList.last!.benchMax + (UserList.last?.squatMax)! + (UserList.last?.DLMax)!)
        
        a = -216.0475144
        b = 16.2606339
        c = -0.002388645
        d = -0.00113732
        e = 0.00000701863
        f = -0.00000001291
        
        wilksScore = a + (b * bodyWeight)
        wilksScore = wilksScore + c * pow(bodyWeight,2)
        wilksScore = wilksScore + d * pow(bodyWeight,3)
        wilksScore = wilksScore + e * pow(bodyWeight,4)
        wilksScore = wilksScore + f * pow(bodyWeight,5)
        
        wilksScore = 500 / wilksScore
            
        wilksScore = totalLifted * wilksScore
            
            
        labelWilks.text = String(format: "%.2f", wilksScore)
          
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

        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY AUTOINCREMENT, height INTEGER, weight INTEGER, benchMax INTEGER, squatMax INTEGER, DLMax INTEGER, wilks Double)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return
        }
        //readValues()
        labelWilks.text = ""
        
        print("Everything is fine")
   
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
