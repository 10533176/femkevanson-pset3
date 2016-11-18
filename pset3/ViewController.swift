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
    var movieImage = "http://clipartix.com/wp-content/uploads/2016/08/Cliparts-about-questions-clipart-clipart-kid-3.jpeg"
    var movieDescription: String?
    
    var arrayWatchList = [String]()
    var arrayYear = [String]()
    var arrayImage = [String]()
    var arrayDescription = [String]()
    var currentIndex: Int?
    var watched: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // put movietitle in the watch list
            arrayWatchList.insert(movieTitle!, at: 0)
            arrayImage.insert(movieImage, at: 0)
            arrayYear.insert(movieYear!, at: 0)
            arrayDescription.insert(movieDescription!, at: 0)
        
            
            // read from stored data
            let defaults = UserDefaults.standard
            if let name = defaults.stringArray(forKey: "title"){
                print (name)
                arrayWatchList.insert(contentsOf: name, at: 0)
                print (arrayWatchList)
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
    
    // store arraywatchlist
    @IBAction func addNewMovie(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(arrayWatchList, forKey: "title")
        defaults.set(arrayYear, forKey: "year")
        defaults.set(arrayImage, forKey: "image")
        defaults.set(arrayDescription, forKey: "description")
    }
    
    
    // specifies how number rows we want in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWatchList.count
    }
    
    // function that populates the cell. 
    // find index of the row with indexpath 
    // and then specifie for each row what must be in there
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WatchListViewCell
        
        cell.checkWatched.isHidden = true
        
        //mark movie as watched 
        if watched == 1 {
            cell.checkWatched.isHidden = false
        }
        
        cell.movieTitle.text = arrayWatchList[indexPath.row]
        cell.movieDescription.text = arrayYear[indexPath.row]
        loadImageFromUrl(url: arrayImage[indexPath.row], view: cell.movieImage)
        
        currentIndex = indexPath.row
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let nextView = segue.destination as? movieDescriptionViewController {
                nextView.movietitle = arrayWatchList[self.tableView.indexPathForSelectedRow!.row]
                nextView.movieYear = arrayYear[self.tableView.indexPathForSelectedRow!.row]
                nextView.movieImage = arrayImage[self.tableView.indexPathForSelectedRow!.row]
                nextView.movieDescription = arrayDescription[self.tableView.indexPathForSelectedRow!.row]
                nextView.rowNumber = self.tableView.indexPathForSelectedRow!.row
            }
        }
    }




