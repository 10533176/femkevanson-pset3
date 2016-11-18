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

    var movieTitle = String()
    var movieDescription = String()
    var movieYear = String()
    var movieTitleSend = String()
    var movieDescriptionSend = String()
    var movieYearSend = String()
    var imagehttps = String()
    var imagehttpsSend = String()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        addMovie.isHidden = true

    }
    
    // when clicked on search, do httpsrequest
    @IBAction func searchAction(_ sender: AnyObject) {
        
            // send the request
            requestHTTPS(title: filledInTitle.text!)
            tableView.isHidden = false
            addMovie.isHidden = false
        
            // while loading
            movieTitle = "Loading..."
            movieDescription = ""
            imagehttps = ""
            self.tableView.reloadData()

    }
    
    //only passing data when add button is clicked.
    @IBAction func addMovie(_ sender: AnyObject) {
        
        addMovie.isHidden = true
        
        movieTitleSend = movieTitle
        movieYearSend = movieYear
        imagehttpsSend = imagehttps
        movieDescriptionSend = movieDescription
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
            
            //give values to variables
            DispatchQueue.main.async {
                self.movieTitle = ((json as AnyObject).value(forKey: "Title") as! String?)!
                self.movieYear = ((json as AnyObject).value(forKey: "Year") as! String?)!
                self.movieDescription = ((json as AnyObject).value(forKey: "Plot") as! String?)!
                self.imagehttps = ((json as AnyObject).value(forKey: "Poster") as! String?)!
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }
    
    
    // function to show immage
    func loadImageFromUrl(url: String, view: UIImageView){
        
        // Create Url from string
        let url = NSURL(string: url)!
        
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        
        let task = URLSession.shared.dataTask(with: url as URL) { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                
                // execute in UI thread
                DispatchQueue.main.async(execute: { () -> Void in
                    view.image = UIImage(data: data)
                })
            }
        }
        
        // Run task
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
        loadImageFromUrl(url: imagehttps, view: cell.movieImage)
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
            nextView.movieImage = imagehttpsSend
            nextView.movieDescription = movieDescriptionSend
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
