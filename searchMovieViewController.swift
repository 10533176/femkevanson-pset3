//
//  searchMovieViewController.swift
//  pset3
//
//  Created by Femke van Son on 16-11-16.
//  Copyright © 2016 Femke van Son. All rights reserved.
//

import UIKit

class searchMovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filledInTitle: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addMovie: UIButton!

    
    var titleMovie = String()
    var test = ["swift", "java", "ruby", "json"]
    var movieTitle = String()
    var movieDescription = String()
    var movieYear = String()
    var movieTitleSend = String()
    var movieYearSend = String()
    
    var dictionary = [
    "Title": "sblabla"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        addMovie.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    // when clicked on search, do httpsrequest
    @IBAction func searchAction(_ sender: AnyObject) {
        
            requestHTTPS(title: filledInTitle.text!)
            tableView.isHidden = false
            addMovie.isHidden = false

    }
    
    @IBAction func addMovie(_ sender: AnyObject) {
        
        addMovie.isHidden = true
        
        movieTitleSend = movieTitle
        movieYearSend = movieYear
    }
    
    // Make a HTTPS request
    func requestHTTPS(title: String){
        let newTitle = title.components(separatedBy: " ").joined(separator: "+")
        let url = URL(string: "https://omdbapi.com/?t="+newTitle+"&yplot=short&r=json")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                // pas aan met een alert voor de user
                print(error!)
                return
            }
            
            guard let data = data else {
                // pas aan met een alert voor de user
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print (json)
            
            DispatchQueue.main.async {
                self.movieTitle = ((json as AnyObject).value(forKey: "Title") as! String?)!
                self.movieYear = ((json as AnyObject).value(forKey: "Year") as! String?)!
                self.movieDescription = ((json as AnyObject).value(forKey: "Plot") as! String?)!
                print (self.movieTitle)
                self.tableView.reloadData()
                print (json)
            }
        }
        
        task.resume()
    }
    

    // specifies how number rows we want in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // function that populates the cell.
    // find index of the row with indexpath
    // and then specifie for each row what must be in there
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! searchListViewCell
        
        cell.movieTitle.text = movieTitle
        cell.movieDescription.text = movieDescription
        return cell
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextView = segue.destination as? ViewController {
            nextView.movieTitle = movieTitleSend
            nextView.movieYear = movieYearSend
        }
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
