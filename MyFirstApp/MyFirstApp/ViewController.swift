//
//  ViewController.swift
//  MyFirstApp
//
//  Created by 최정은 on 2023/08/23.
//

import UIKit

class ViewController: UIViewController {

    // 컴퓨터가 알 수 있도록 정보를 표시
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    
    
    // 앱의 화면에 들어오면 처음 실행시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.backgroundColor = UIColor.yellow
        
    }

   
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        myButton.backgroundColor = .black
        myButton.setTitleColor(.blue, for: UIControl.State.normal)
        if(mainLabel.text!.contains("안녕하세요"))
        {
            mainLabel.text = "반갑습니다"
            mainLabel.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        }
        else
        {
            mainLabel.text = "안녕하세요"
            mainLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
    }
    
}

