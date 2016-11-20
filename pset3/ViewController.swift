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
    
    var movieTitle = ""
    var movieYear: String?
    var movieImage = "http://clipartix.com/wp-content/uploads/2016/08/Cliparts-about-questions-clipart-clipart-kid-3.jpeg"
    var movieDescription: String?
    
    var arrayWatchList = [String]()
    var arrayYear = [String]()
    var arrayImage = [String]()
    var arrayDescription = [String]()
    var watched: Int?
    var rowNumber: Int?
    
    // deleting movie
    func deleteMovie(index: Int) {
        
        self.arrayWatchList.remove(at: index)
        self.arrayYear.remove(at: index)
        self.arrayImage.remove(at: index)
        self.arrayDescription.remove(at: index)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // only fill array when movietitle is present
        if movieTitle.isEmpty {
            self.tableView.reloadData()
        }
        
        else {
            // put movietitle in the watch list
            arrayWatchList.insert(movieTitle, at: 0)
            arrayImage.insert(movieImage, at: 0)
            arrayYear.insert(movieYear!, at: 0)
            arrayDescription.insert(movieDescription!, at: 0)
        }
        
        
        // read from stored data
        let defaults = UserDefaults.standard
        if let name = defaults.stringArray(forKey: "title") {
            arrayWatchList.insert(contentsOf: name, at: 0)
        }
        
        if let year = defaults.stringArray(forKey: "year") {
            arrayYear.insert(contentsOf: year, at: 0)
        }
        
        if let image = defaults.stringArray(forKey: "image") {
            arrayImage.insert(contentsOf: image, at: 0)
        }
        
        if let description = defaults.stringArray(forKey: "description") {
            arrayDescription.insert(contentsOf: description, at: 0)
        }
        
        //when clicked on watched, add label to cell
        if watched  == 1 {
            deleteMovie(index: rowNumber!)
            watched = 0
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // load image
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
    
    // store arraywatchlist when new movie is add
    @IBAction func addNewMovie(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(arrayWatchList, forKey: "title")
        defaults.set(arrayYear, forKey: "year")
        defaults.set(arrayImage, forKey: "image")
        defaults.set(arrayDescription, forKey: "description")
    }
    
    
    // specifies number of rows we want in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayWatchList.count
    }
    
    // function that populates the cell. 
    // find index of the row with indexpath 
    // and then specifie for each row what must be in there
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WatchListViewCell
        
        cell.movieTitle.text = arrayWatchList[indexPath.row]
        cell.movieDescription.text = arrayYear[indexPath.row]
        loadImageFromUrl(url: arrayImage[indexPath.row], view: cell.movieImage)

        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // when clicked to new view, save the info for the watchlist
        let defaults = UserDefaults.standard
        defaults.set(arrayWatchList, forKey: "title")
        defaults.set(arrayYear, forKey: "year")
        defaults.set(arrayImage, forKey: "image")
        defaults.set(arrayDescription, forKey: "description")
        
            // send all the info to movie description when clicked on row.
            if let nextView = segue.destination as? movieDescriptionViewController {
                nextView.movietitle = arrayWatchList[self.tableView.indexPathForSelectedRow!.row]
                nextView.movieYear = arrayYear[self.tableView.indexPathForSelectedRow!.row]
                nextView.movieImage = arrayImage[self.tableView.indexPathForSelectedRow!.row]
                nextView.movieDescription = arrayDescription[self.tableView.indexPathForSelectedRow!.row]
                nextView.rowNumber = self.tableView.indexPathForSelectedRow!.row
            }
        }
    }




