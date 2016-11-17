//
//  ViewController.swift
//  pset3
//
//  Created by Femke van Son on 15-11-16.
//  Copyright © 2016 Femke van Son. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movieTitle: String?
    var movieYear: String?
    var movieImage: String? 
    
    let test = ["swift", "java", "ruby", "json"]
    
    let testDes = [
        "swift": "sblabla",
        "java": "jblabla",
        "ruby": "srblabla",
        "jason": "jblabla"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // specifies how number rows we want in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    // function that populates the cell. 
    // find index of the row with indexpath 
    // and then specifie for each row what must be in there
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WatchListViewCell
        
        cell.movieTitle.text = movieTitle
        cell.movieDescription.text = movieYear
        return cell
        
    }
    
}
