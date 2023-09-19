//
//  SecondViewController.swift
//  BMI
//
//  Created by 최정은 on 2023/08/25.
//

import UIKit

final class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        guard let bmi = bmi else {return}
        bmiNumberLabel.text = "\(bmi.value)"
        adviceLabel.text = bmi.advice
        bmiNumberLabel.backgroundColor = bmi.matchColor
    }
    
    func configureUI(){
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
        
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
