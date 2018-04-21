//
//  insideDayViewController.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-28.
//  Copyright © 2018 Avery Speller. All rights reserved.
//

import UIKit

class insideDayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var insideDayTableView: UITableView!
    
    
    let unique = Array(Set(exercise_name))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        insideDayTableView.estimatedRowHeight = 165.0
        insideDayTableView.rowHeight = UITableViewAutomaticDimension
        self.insideDayTableView.setNeedsLayout()
        self.insideDayTableView.layoutIfNeeded()
        
        self.insideDayTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return unique.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 165.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let insideDayCell = tableView.dequeueReusableCell(withIdentifier: "insideDayCell", for: indexPath) as! InsideDayTableViewCell
        
        
        
        var insideDayExerciseNames = [String]()
        
        let sortedUnique = unique.sorted()
        insideDayCell.labelExerciseName.text = sortedUnique[indexPath.row]
        insideDayCell.labelSet1.text = "100"
        insideDayCell.labelSet2.text = "200"
        insideDayCell.labelSet3.text = "300"
        insideDayCell.labelSet4.text = "400"
        //self.InsideDayTableView.reloadData()
        return insideDayCell
       
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
