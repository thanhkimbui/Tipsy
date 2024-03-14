//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    var tip = 0.1
    var numberOfPeople = 2
    var totalBill = 0.0
    var payResult2Decimal = "0.0"
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        if sender == zeroPctButton {
            tip = 0
        } else if sender == tenPctButton {
            tip = 10
        } else {
            tip = 20
        }
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        billTextField.endEditing(true)
        totalBill = Double(billTextField.text!) ?? 0.0
        
        let payResult = Double(totalBill * (1 + Double(tip)/100)) / Double(numberOfPeople)
        payResult2Decimal  = String(format: "%.2f", payResult)

//        print(payResult2Decimal)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.finalResult = payResult2Decimal
            destinationVC.finalTip = String(Int(tip))
            
            destinationVC.finalNumOfPeople = String(numberOfPeople)
        }

    }
}

