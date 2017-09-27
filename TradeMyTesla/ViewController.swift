//
//  ViewController.swift
//  TradeMyTesla
//
//  Created by Tinnell, Clay on 9/24/17.
//  Copyright © 2017 Tinnell, Clay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cars = Cars()
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var model: UISegmentedControl!
    @IBOutlet weak var upgrades: UISegmentedControl!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var mileage: UISlider!
    @IBOutlet weak var condition: UISegmentedControl!
    @IBOutlet weak var valuation: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stackView.setCustomSpacing(30, after: model)
        stackView.setCustomSpacing(30, after: upgrades)
        stackView.setCustomSpacing(30, after: mileage)
        stackView.setCustomSpacing(60, after: condition)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculateValue(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        let formattedMileage = formatter.string(for: mileage.value) ?? "0"
        mileageLabel.text = "MILEAGE (\(formattedMileage) miles"
        
        //create a prediction by passing in all of the input form the UI
        if let prediction = try? cars.prediction(model: Double(model.selectedSegmentIndex),
                                                 premium: Double(upgrades.selectedSegmentIndex),
                                                 mileage: Double(mileage.value),
                                                 condition: Double(condition.selectedSegmentIndex)) {
            
            //clamp the price so it's at least $2000
            let clampedValuation = max(2000, prediction.price)
            
            //display the valuation
            formatter.numberStyle = .currency
            valuation.text = formatter.string(for: clampedValuation)
        } else {
            valuation.text = "Error! %&@!"
        }
    }
}

