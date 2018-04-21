//
//  FirstViewController.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-13.
//  Copyright © 2018 Avery Speller. All rights reserved.
//

import UIKit
import SQLite3

var week = [Int]()
var day_week = [Int]()
var exercise_name = [String]()
var set = [Int]()
var reps = [Int]()
var weight = [Double]()
var completed = [Int]()
var id = [Int]()





class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    var FileName = "CANDITO"
    
    var db: OpaquePointer?
    var workoutList = [Workout]()
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var labelWorkouts: UILabel!
    @IBOutlet weak var WorkoutPickerView: UIPickerView!
    
    
    let workouts = ["","CANDITO", "5/3/1", "STRONGLIFT 5X5"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return workouts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workouts.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        labelWorkouts.text = workouts[row]
        if workouts[row] == "CANDITO"{
            FileName = "CANDITO"
            descriptionTextView.text = "The Candito 6 Week Strength Program is a 6 week training program built using periodization. Because of this each week will be different. You will train either three, four, or five days per week depending on what week of the cycle you are currently on. Each week of the program effects the other.The program is focused on the three main lifts; squat, bench press, deadlift. The weights you use each lifting day is based off of your current 1 rep max for the squat, bench press, and deadlift. You will be lifting using several different set and rep ranges throughout the 6 week program."
        }
        if workouts[row] == "STRONGLIFT 5X5"{
            FileName = "STRONGLIFT5X5"
            descriptionTextView.text = "StrongLifts 5×5 is the simplest, most effective workout to build muscle, gain strength and get ripped. Thousands of people worldwide have used it to change their bodies and lives. It’s the most popular strength and muscle building program on the internet because it’s simple and works.\n\nOn StrongLifts 5×5 you workout three times a week. Each workout you do three barbell exercises for sets of five reps. The five exercises you’ll do on StrongLifts 5×5 are the Squat, Bench Press, Deadlift, Overhead Press and Barbell Row. Together they work your whole body. \n\nThe goal on StrongLifts 5×5 is to increase the weight. You start light, lift with proper form, and add 2,5kg/5lb each workout. This progressive increase in weight triggers your body to get stronger and build muscle. It’s the simplest and most effective way to get results.\n\nStrongLifts 5×5 is most effective for beginners new to lifting weights. This is the definitive guide to the StrongLifts 5×5 workout program."
        }
        if workouts[row] == "5/3/1"{
            FileName = "5_3_1"
            descriptionTextView.text = "Wendler’s 5/3/1 is all about starting with very light weights while progressing slowly and consistently. This extremely popular strength training program is based off of the rep schemes 5, 3, 1, as the name suggests. Throughout the routine you will work with percentages based off of your max, and strive to hit rep PR’s each workout."
        }
        if workouts[row] == ""{
            labelWorkouts.text = "Please select a workout plan"
            descriptionTextView.text = ""
        }
        
    }
    
    
    
    @IBAction func AddWorkoutButton(_ sender: Any) {
        
        //print(parseCSV())
        
        var values = parseCSV()
        successLabel.text = "Success"
      //  print(values[0][1])
        

        
        
        print (values.count)
        print (values[0].count)
        for i in 1...values.count-1{
            for j in 0...values[i].count-1{
               // print("i, j = ",i,j)
                switch j {
                    case 0:
                        id.append(Int(values[i][j])!)
                    case 1:
                        week.append(Int(values[i][j])!)
                    case 2:
                        day_week.append(Int(values[i][j])!)
                    case 3:
                        exercise_name.append(values[i][j])
                    case 4:
                        set.append(Int(values[i][j])!)
                    case 5:
                        reps.append(Int(values[i][j])!)
                    case 6:
                        weight.append(Double(values[i][j])!)
                    case 7:
                        completed.append(Int(values[i][j])!)

                default:
                    break
                }
            }
        }
        print("id: ", id)
        print("week: ",week)
        print("day_week: ",day_week)
        print("exercise_name: ",exercise_name)
        print("set: ",set)
        print("reps: ",reps)
        print("weight: ", weight)
        print("completed: ",completed)
        
        
        
        for i in 0...values.count-2{
            
            //creating a statement
            
            var stmt: OpaquePointer?
            
            var queryString1 = "INSERT INTO Day_table (week, day) VALUES (?,?)"
            var queryString2 = "INSERT INTO Exercise_table (name, sets, reps, weight) VALUES (?,?,?,?)"
            var queryString3 = "INSERT INTO Workout_table (E_id, D_id, completed) VALUES (?,?,?)"

            
            /******************************DAY_TABLE***********************************/
            
            
            //preparing the query
            if sqlite3_prepare(db, queryString1, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return
            }
            
            
            
            //binding the parameters
            if sqlite3_bind_int(stmt, 1, Int32(week[i])) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding height: \(errmsg)")
                return
            }
            if sqlite3_bind_int(stmt, 2, Int32(day_week[i])) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding weight: \(errmsg)")
                return
            }
            
            //executing the query to insert values
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting User: \(errmsg)")
                return
            }
            
            
            /******************************EXERCISE_TABLE***********************************/
            
            
            
            //preparing the query
            if sqlite3_prepare(db, queryString2, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return
            }
            //binding the parameters
            if sqlite3_bind_text(stmt, 1, exercise_name[i], -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding height: \(errmsg)")
                return
            }
            if sqlite3_bind_int(stmt, 2, Int32(set[i])) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding weight: \(errmsg)")
                return
            }
            if sqlite3_bind_int(stmt, 3, Int32(reps[i])) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding weight: \(errmsg)")
                return
            }
            if sqlite3_bind_double(stmt, 4, weight[i]) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding weight: \(errmsg)")
                return
            }
            //executing the query to insert values
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting User: \(errmsg)")
                return
            }
            
            
            /******************************WORKOUT_TABLE***********************************/
            
            
            //preparing the query
            if sqlite3_prepare(db, queryString3, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return
            }
            //binding the parameters
            if sqlite3_bind_int(stmt, 1, Int32(id[i])) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding height: \(errmsg)")
                return
            }
            if sqlite3_bind_int(stmt, 2, Int32(id[i])) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding weight: \(errmsg)")
                return
            }
            if sqlite3_bind_int(stmt, 3, Int32(completed[i])) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding weight: \(errmsg)")
                return
            }
            
            //executing the query to insert values
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting User: \(errmsg)")
                return
            }
            //displaying a success message
            print("Workout info saved successfully")
        }

        readValues()
    }
    
    
    func parseCSV()-> Array<Array<String>>{
        
        //Reading File
        
        var stringArr = [String]()
        var newCSV = [[String]]()
        
        if let filepath = Bundle.main.path(forResource: FileName, ofType: "csv") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let newString = contents.replacingOccurrences(of: "\r", with: "", options: .literal, range: nil)
               // print(newString)
                stringArr = newString.components(separatedBy: "\n")

              //  print(stringArr)
                var CSVValue = [String]()
                
                for each in stringArr{
        
                        
                    CSVValue = each.components(separatedBy: ",")
                    newCSV.append(CSVValue)
                }
                //print (newCSV)
                //print(CSVValue[3])
                
                
                /*for i in 0...stringArr.count-1{
                 stringArr[i].append("\n")
                 }*/
                
            } catch {
                print("contents not loaded")
            }
        } else {
            // example.txt not found!
            print("input not found")
        }
        
       // print(stringArr)
        
        return newCSV
        
    }
    
    
    func readValues(){
        workoutList.removeAll()
        
        var queryString = "SELECT * FROM Exercise_table e JOIN Day_table d ON e.Exercise_id = d.Day_id"//, Workout_table WHERE Day_id = Exercise_id"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
           /* for i in 0...8{
 
                let ptr = sqlite3_column_name(stmt, Int32(i))
                let str = String(cString: ptr!)
                print(str)
                
            }*/
            //print(sqlite3_column_name(stmt, 0))//.fromCString(sqlite3_column_name(stmt, 0)))
            let id = sqlite3_column_int(stmt, 0)
            let week = sqlite3_column_int(stmt, 6)
            let day_week = sqlite3_column_int(stmt, 7)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let set = sqlite3_column_int(stmt, 2)
            let reps = sqlite3_column_int(stmt, 3)
            let weight = sqlite3_column_double(stmt, 4)
            
   
            workoutList.append(Workout(id: Int(id), week: Int(week), day_week: Int(day_week),exercise_name: String(describing: name), set: Int(set), reps: Int(reps), weight: weight))
        }
        print("First Entry: ",workoutList[0].id, workoutList[0].week, workoutList[0].day_week, workoutList.last?.exercise_name, workoutList[0].set, workoutList[0].reps, workoutList[0].weight)
        /*print("Last Entry: ",workoutList[102].id, workoutList[102].week, workoutList[102].day_week, workoutList.last?.exercise_name, workoutList[102].set, workoutList[102].reps, workoutList[102].weight)*/
        
        
       /*
        
        queryString = "SELECT name FROM Exercise_table, Day_table WHERE Exercise_id = Day_id AND Day_table.week = 1"//, Workout_table WHERE Day_id = Exercise_id"
        
        
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
             for i in 0...1{
             
             let ptr = sqlite3_column_name(stmt, Int32(i))
                if ptr != nil{
                    let str = String(cString: ptr!)
                    print(str)
                }
             
             
             
             }
            //print(sqlite3_column_name(stmt, 0))//.fromCString(sqlite3_column_name(stmt, 0)))
            if stmt != nil{
                let name2 = String(cString: sqlite3_column_text(stmt, 1))
                
                print (name2)
                
            }

        }*/
        
        //self.tableViewHeroes.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Do any additional setup after loading the view.
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("WorkoutDatabase.sqlite")
        
        if sqlite3_open(fileURL.path,&db) != SQLITE_OK{
            print ("Error Opening Database")
            return
        }
        
      /*  if sqlite3_exec(db, "PRAGMA foreign_keys = on", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("something: \(errmsg)")
            return
        }*/

        
        if sqlite3_exec(db, "DROP TABLE Day_table; CREATE TABLE IF NOT EXISTS Day_table (Day_id INTEGER PRIMARY KEY AUTOINCREMENT, week INTEGER, day INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return
        }
        if sqlite3_exec(db, "DROP TABLE Exercise_table; CREATE TABLE IF NOT EXISTS Exercise_table (Exercise_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, sets INTEGER, reps INTEGER, weight DOUBLE)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return
        }
        if sqlite3_exec(db, "DROP TABLE Workout_table; CREATE TABLE IF NOT EXISTS Workout_table (id INTEGER PRIMARY KEY AUTOINCREMENT, E_id INTEGER, D_id INTEGER, completed INTEGER, FOREIGN KEY (E_id) REFERENCES Exercise_table(Exercise_id), FOREIGN KEY (D_id) REFERENCES Day_table(Day_id))", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

