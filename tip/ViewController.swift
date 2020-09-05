//  ViewController.swift
//  tip
//  Created by Mohit on 8/24/20.
//  Copyright © 2020 All rights reserved.

import UIKit

import MessageUI

class ViewController: UIViewController , MFMailComposeViewControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate {
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var Stepper: UIStepper!
    
    @IBOutlet weak var stepperLabel: UILabel!
    
    @IBOutlet weak var perPerson: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        billField.becomeFirstResponder()
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
    
    @IBAction func emailBill(_ sender: Any) {
        sendEmail()
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>Here's the split bill. /(perPerson.text) </p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert if they don't have mail set up
            let alert = UIAlertController(title: "Email the Bills?", message: "\n Mail is not setup. \n Please setup your mail to enable emailing your bills.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))

            self.present(alert, animated: true)
            }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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

