//
//  SettingsViewController.swift
//  tip
//
//  Created by Mohit on 8/25/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBAction func defaultTipChanged(_ sender: Any) {
        let tipIndex = tipControl.selectedSegmentIndex
        
        let defaults = UserDefaults.standard
        defaults.set(tipIndex, forKey: "tipIndex")
        defaults.set(true, forKey: "defaultChanged")
        defaults.synchronize()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let intValue = defaults.integer(forKey: "tipIndex")        
        tipControl.selectedSegmentIndex = intValue
    }
    
}
