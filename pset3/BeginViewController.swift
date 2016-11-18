//
//  BeginViewController.swift
//  pset3
//
//  Created by Femke van Son on 17-11-16.
//  Copyright © 2016 Femke van Son. All rights reserved.
//

import UIKit

class BeginViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var watchList: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //deleting the data
        //if let bundle = Bundle.main.bundleIdentifier {
          //  UserDefaults.standard.removePersistentDomain(forName: bundle)
        //}

        // Do any additional setup after loading the view.
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
