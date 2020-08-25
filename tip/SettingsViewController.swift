//
//  SettingsViewController.swift
//  tip
//
//  Created by Mohit on 8/25/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let tipIndex = defaults.integer(forKey: "TipSegmentIndex")
        tipControl.selectedSegmentIndex = tipIndex
    }
    
    @IBAction func tipValueChanged(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(tipControl.selectedSegmentIndex, forKey: "TipSegmentIndex")
        defaults.synchronize()
        
        
    }
    
        
        
    
}
