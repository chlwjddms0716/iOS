//
//  ViewController.swift
//  UpDownGame
//
//  Created by 최정은 on 2023/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var comChoice = Int.random(in: 1...10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = "선택하세요"
        numberLabel.text = ""
    }


    
    @IBAction func buttonPressed(_ sender: UIButton) {
       
        guard let numString = sender.currentTitle else { return }
        numberLabel.text = numString
    }
    
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        
        guard let myNumString = numberLabel.text else { return }
        guard let myNumber = Int(myNumString) else { return }
        
        if comChoice < myNumber {
            mainLabel.text = "Down"
        }
        else if comChoice > myNumber {
            mainLabel.text = "Up"
        }
        else{
            mainLabel.text = "Bingo😁"
        }
    }
    
    
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        comChoice = Int.random(in: 1...10)
        
        mainLabel.text = "선택하세요"
        numberLabel.text = ""
    }
}

