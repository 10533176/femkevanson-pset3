//
//  movieDescriptionViewController.swift
//  pset3
//
//  Created by Femke van Son on 18-11-16.
//  Copyright © 2016 Femke van Son. All rights reserved.
//

import UIKit

class movieDescriptionViewController: UIViewController {
    
    var movietitle: String?
    var movieYear: String?
    var movieImage: String?
    var movieDescription: String?
    var rowNumber: Int?
    var watched: Int?
    
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var yearDescription: UILabel!
    @IBOutlet weak var imageDescription: UIImageView!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var deleteMovie: UIButton!
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleDescription.text = movietitle
        yearDescription.text = movieYear
        Description.text = movieDescription
        loadImageFromUrl(url: movieImage!, view: imageDescription)
        
    }
    
    // delete movie when clicked on button
    @IBAction func deleteMovie(_ sender: AnyObject) {
        
        watched = 1
        deleteMovie.isHidden = true
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextView = segue.destination as? ViewController {
            nextView.watched = watched
            nextView.rowNumber = rowNumber
        }
    }

}
