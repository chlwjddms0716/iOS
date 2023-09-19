//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by 최정은 on 2023/08/28.
//

import Foundation
import UIKit


struct BMICalculatorManager{
  private var bmi: BMI?
    
   mutating func getBMIResult(height: String, weight: String) -> BMI {
      
        calculateBMI(height: height, weight: weight)
        
        return bmi ?? BMI(value: 0.0,  advice: "문제발생", matchColor: .white)
    }
    
  mutating  private func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {  return }
      
        var bmiNumber = w / (h * h) * 10000
        bmiNumber = round(bmiNumber * 10) / 10
        
        switch bmiNumber {
        case ..<18.6:
            bmi = BMI(value: bmiNumber, advice: "저체중", matchColor: UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1))
        case 18.6..<23.0:
            bmi = BMI(value: bmiNumber, advice: "표준", matchColor:  UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1))
        case 23.0..<25.0:
            bmi = BMI(value: bmiNumber, advice: "과체중", matchColor:  UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1))
        case 25.0..<30.0:
            bmi = BMI(value: bmiNumber, advice: "중도비만", matchColor:  UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1))
        case 30.0...:
            bmi = BMI(value: bmiNumber, advice: "비만", matchColor:   UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1))
        default:
           bmi = BMI(value: 0.0,  advice: "문제발생", matchColor: .white)
        }
    }
    
  
    
}
