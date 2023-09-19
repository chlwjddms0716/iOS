//
//  ViewController.swift
//  BMI
//
//  Created by 최정은 on 2023/08/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    var bmiManaber = BMICalculatorManager()
       
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
    }
    
    func configureUI(){
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해주세요"
        
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        
        heightTextField.placeholder = "cm단위로 입력해주세요"
        weightTextField.placeholder = "kg단위로 입력해주세요"
    }

    @IBAction func calculateButtonTapped(_ sender: UIButton) {
       
    }
    
    // 다음화면으로 넘어가는 것을 허락할지 말지
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print(#function)
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다!!"
            mainLabel.textColor = .red
            
            return false
        }
        
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        mainLabel.textColor = .black
        return true
    }
    
    // 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#function)
        if segue.identifier == "toSecondVC" {
            
            let secondVC = segue.destination as! SecondViewController
            secondVC.bmi = bmiManaber.getBMIResult(height: heightTextField.text!, weight:weightTextField.text!)
           
        }
        
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
  
}

extension ViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 글자를 지울 때 빈문자열 들어옴!
        if Int(string) != nil || string == "" || string == "." {
            return true
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if heightTextField.text != "", weightTextField.text != ""{
            weightTextField.resignFirstResponder()
            heightTextField.resignFirstResponder()
            return true
        }
        else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        
        return false
    }
}
