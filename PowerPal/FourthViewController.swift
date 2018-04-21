//
//  FourthViewController.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-15.
//  Copyright © 2018 Avery Speller. All rights reserved.
//

import UIKit
import Charts
import SQLite3

class FourthViewController: UIViewController {
    var UserList = [User]()
    var db: OpaquePointer?
    var numbers = [Double]()
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
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
        
        readValues()
        print("Everything is fine")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func buttonBench(_ sender: Any) {
        numbers.removeAll()
        for i in 0...UserList.count-1{
            var user: User
            user = UserList[i]
            numbers.append(Double(user.benchMax))
        }
        
        print(numbers)
        updateGraph(graphName: "Bench Chart",lineName: "Max Bench")
    }
    @IBAction func buttonSquat(_ sender: Any) {
        numbers.removeAll()
        for i in 0...UserList.count-1{
            var user: User
            user = UserList[i]
            numbers.append(Double(user.squatMax))
        }
        
        print(numbers)
        updateGraph(graphName: "Squat Chart",lineName: "Max Squat")
    }
    @IBAction func buttonDL(_ sender: Any) {
        numbers.removeAll()
        for i in 0...UserList.count-1{
            var user: User
            user = UserList[i]
            numbers.append(Double(user.DLMax))
        }
        
        print(numbers)
        updateGraph(graphName: "DeadLift Chart",lineName: "Max Deadlift")
    }
    @IBAction func buttonWeight(_ sender: Any) {
        numbers.removeAll()
        for i in 0...UserList.count-1{
            var user: User
            user = UserList[i]
            numbers.append(Double(user.weight))
        }
        
        print(numbers)
        updateGraph(graphName: "Body Weight Chart",lineName: "Body Weight")
    }
    
    @IBAction func buttonWilks(_ sender: Any) {
        numbers.removeAll()
        readValues()
        for i in 0...UserList.count-1{
            var user: User
            user = UserList[i]
            numbers.append(Double(user.wilks))
        }
        
        print(numbers)
        updateGraph(graphName: "Wilks Chart",lineName: "Wilks Score")
    
    }
    

    
    
    func updateGraph(graphName: String, lineName: String){
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<numbers.count{
            let value = ChartDataEntry(x: Double(i), y: numbers[i])
            lineChartEntry.append(value)
        }
        let line1 = LineChartDataSet(values: lineChartEntry, label: lineName)
        line1.colors = [NSUIColor.blue]
        let data = LineChartData()
        data.addDataSet(line1)
        lineChartView.data = data
        lineChartView.chartDescription?.text = graphName
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
        //self.TableViewUser.reloadData()
    }


}
