//
//  SecondViewController.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-13.
//  Copyright © 2018 Avery Speller. All rights reserved.
//

import UIKit
import SQLite3

var weekNum : Int = 1
var uniqueDays : Int = 0
var startingPoint = 0
var endingPoint = 0

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var tableViewDays: UITableView!
    
    var unique: Array<Character> = []
    var workoutList = [Workout]()
    var listOfWeeks = [String]()
    func createPicker(){
        for j in 1...week.last!{
            listOfWeeks.append("Week" + String(j))
        }
        
    }
    
    let pickerView = UIPickerView()
    var rotationAngle: CGFloat!
    let width: CGFloat = 150
    let height: CGFloat = 150
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        weekNum = row + 1
        
        var dayArray: String = ""
        
        var numberOfvalues = week.filter{$0 == weekNum}.count
        
        startingPoint = week.index(of: weekNum)!
        endingPoint = startingPoint + (numberOfvalues - 1)
        
        if week.index(of: weekNum) != nil{
            
            
            
            for i in startingPoint...endingPoint{
                
                dayArray.append(String(day_week[i]))
                
            }
            
        }
        

        unique = Array(Set(dayArray))
        print("unique values are: ",unique)
        
        print("unique count: ",unique.count)
        
        print("numbers of enties for a week: ",week.filter{$0 == weekNum}.count)
        
        
        
        self.view.bringSubview(toFront: tableViewDays)
        
        self.tableViewDays.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubview(toFront: tableViewDays)
        //self.navigationController?.isNavigationBarHidden = true
        createPicker()
        // Do any additional setup after loading the view, typically from a nib.

        pickerView.delegate = self
        pickerView.dataSource = self
        // pickerView.layer.borderColor = UIColor
        rotationAngle = -90 * (.pi/180)
        pickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        //pickerView.frame = CGRect(x: 0 - 150, y: 0, width: view.frame.width + 100, height: 100)
        //pickerView.center = self.view.center
       
        self.view.addSubview(pickerView)
       
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizonalContraints = NSLayoutConstraint(item: pickerView, attribute:
            .leadingMargin, relatedBy: .equal, toItem: view,
                            attribute: .leadingMargin, multiplier: 1.0,
                            constant: 20)
        
        //pin the slider 20 points from the right edge of the super view
        //negative because we want to pin -20 points from the end of the superview.
        //ex. if with of super view is 300, 300-20 = 280 position
        let horizonal2Contraints = NSLayoutConstraint(item: pickerView, attribute:
            .trailingMargin, relatedBy: .equal, toItem: view,
                             attribute: .trailingMargin, multiplier: 1.0, constant: -20)
        
        
        let pinTop = NSLayoutConstraint(item: pickerView, attribute: .top, relatedBy: .equal,
                                        toItem: view, attribute: .top, multiplier: 1.0, constant: 30)
        
        let heightContraints = NSLayoutConstraint(item: pickerView, attribute:
            .height, relatedBy: .equal, toItem: nil,
                     attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
                     constant: 150)
        let widthContraints = NSLayoutConstraint(item: pickerView, attribute:
            .width, relatedBy: .equal, toItem: nil,
                    attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
                    constant: 300)
        
        NSLayoutConstraint.activate([horizonalContraints, horizonal2Contraints, widthContraints, heightContraints, pinTop])
       // print(exercise_name[0])
       // let unique = Array(Set(exercise_name))
       // print(unique)
        
        self.tableViewDays.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return unique.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDay = tableView.dequeueReusableCell(withIdentifier: "cellDay", for: indexPath ) as! DayTableViewCell
        
       // let workout: String

        //workout = exercise_name[indexPath.row]
        var startingPoint:Int
        startingPoint = week.index(of: weekNum)!
        
        print("start here: ",startingPoint)
        //cellDay.labelDay.text = "hello"
        var sortedUnique = unique.sorted()
        //cellDay.labelDay.text = ("Day " + String(sortedUnique[indexPath.row]))
        
        switch String(sortedUnique[indexPath.row]) {
            case "1":
                cellDay.labelDay.text = "Monday"
        case "2":
            cellDay.labelDay.text = "Tuesday"
        case "3":
            cellDay.labelDay.text = "Wednesday"
        case "4":
            cellDay.labelDay.text = "Thursday"
        case "5":
            cellDay.labelDay.text = "Friday"
        case "6":
            cellDay.labelDay.text = "Saturday"
        case "7":
            cellDay.labelDay.text = "Sunday"
            
        default:
            cellDay.labelDay.text = ("Day " + String(sortedUnique[indexPath.row]))
        }
        
        //print("hello::::: ")
        return cellDay
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "segue", sender: self)
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfWeeks.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 150
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: width, height: 30)
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: width, height: 30)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = listOfWeeks[row]
        view.addSubview(label)
        
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
        
        return view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

