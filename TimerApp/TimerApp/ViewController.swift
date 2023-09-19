//
//  ViewController.swift
//  TimerApp
//
//  Created by 최정은 on 2023/08/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    weak var timer: Timer?
    
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    func configureUI(){
        mainLabel.text = "초를 선택하세요"
       slider.setValue(slider.maximumValue / 2, animated: true)
        
    }
    
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        number = Int(sender.value)
        mainLabel.text = "\(number)초"
    }
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(doSomeThingAfter1Second), userInfo: nil, repeats: true)
        
        //        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ [self] _ in
//
//            if number > 0 {
//                number -= 1
//
//                mainLabel.text = "\(number)초"
//                slider.setValue(Float(number), animated: true)
//            }
//            else
//            {
//                number = 0
//                mainLabel.text = "초를 선택하세요"
//
//                timer?.invalidate()
//                AudioServicesPlayAlertSound(SystemSoundID(1322))
//
//            }
//        }
    }
    
   @objc func doSomeThingAfter1Second(){
       if number > 0 {
           number -= 1
           
           mainLabel.text = "\(number)초"
           slider.setValue(Float(number), animated: true)
       }
       else
       {
           number = 0
           mainLabel.text = "초를 선택하세요"
           
           timer?.invalidate()
           AudioServicesPlayAlertSound(SystemSoundID(1322))
       }
   }
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        configureUI()
        number = 0
        timer = nil
    }
}

