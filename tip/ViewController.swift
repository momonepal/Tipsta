//
//  ViewController.swift
//  tip
//
//  Created by Mohit on 8/24/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var Stepper: UIStepper!
    
    @IBOutlet weak var stepperLabel: UILabel!
    
    @IBOutlet weak var perPerson: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
                // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func CalculateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        
        let tipPercentage = [0.12,0.15,0.20]
        let tip = tipPercentage[tipControl.selectedSegmentIndex] * bill
        let total = tip + bill
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        let pax = Stepper.value
        stepperLabel.text = "Split :  " + String(Int(pax))
        let pricePerPerson = total / (pax + 1)
        perPerson.text = String(format: "Each person pays $%.2f", pricePerPerson)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let bill = Double(billField.text!) ?? 0
        
        let defaultChanged = defaults.bool(forKey: "defaultChanged")
        if (defaultChanged || bill == 0) { // only update segment if the default is changed
            let intValue = defaults.integer(forKey: "tipIndex")
            tipControl.selectedSegmentIndex = intValue
            defaults.set(false, forKey: "defaultChanged") // updated
        }
        
        self.CalculateTip(self)
    }
}

