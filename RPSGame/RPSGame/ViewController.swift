//
//  ViewController.swift
//  RPSGame
//
//  Created by 최정은 on 2023/08/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var comImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var comChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    var myChoice : Rps = Rps.rock
    var comChoice : Rps = Rps(rawValue: Int.random(in: 0...2))!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1) 첫번째/두번째 이미지뷰에 준비(묵) 이미지를 띄워야 함
        // 2) 첫번째/두번째 label에 '준비'라고 문자열을 띄워야 함
        
        comImageView.image = #imageLiteral(resourceName: "ready")
        myImageView.image = UIImage(named: "ready.png")
        
        comChoiceLabel.text = "준비"
        myChoiceLabel.text = "준비"
    }

    
    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        // 선택한 항목 저장
        
       guard let title = sender.currentTitle else { return }
                
       //let title = sender.currentTitle!
        
        switch(title)
        {
        case "가위":
            myChoice =  Rps.scissors
        case "바위":
            myChoice = Rps.paper
        case "보":
            myChoice =  Rps.rock
        default:
            break
        }
    }
    
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        
        // 컴퓨터가 랜덤 선택한 것을 이미지, 레이블 표시
        // 내가 선택한 것을 이미지, 레이블 표시
        // 컴퓨터가 선택한 것과 내가 선택한 것을 비교해서 판단한 다음 상단 label 표시
        
        switch(comChoice){
        case Rps.rock:
            comImageView.image = #imageLiteral(resourceName: "rock")
            comChoiceLabel.text = "바위"
        case Rps.paper:
            comImageView.image = #imageLiteral(resourceName: "paper")
            comChoiceLabel.text = "보"
        case Rps.scissors:
            comImageView.image = #imageLiteral(resourceName: "scissors")
            comChoiceLabel.text = "가위"
        }
        
        
        switch(myChoice){
        case Rps.rock:
            myImageView.image = #imageLiteral(resourceName: "rock")
            myChoiceLabel.text = "바위"
        case Rps.paper:
            myImageView.image = #imageLiteral(resourceName: "paper")
            myChoiceLabel.text = "보"
        case Rps.scissors:
            myImageView.image = #imageLiteral(resourceName: "scissors")
            myChoiceLabel.text = "가위"
        }
        
        
        if(comChoice == myChoice){
            mainLabel.text = "비겼다"
        }
        else if (comChoice == .rock && myChoice == .paper){
            mainLabel.text = "이겼다"
        }
        else if (comChoice == .paper && myChoice == .scissors){
            mainLabel.text = "이겼다"
        }
        else if (comChoice == .scissors && myChoice == .rock){
            mainLabel.text = "이겼다"
        }
        else{
            mainLabel.text = "졌다"
        }
    }
    
    

    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 컴퓨터가 준비상태를 이미지, 레이블 표시
        // 내가 준비상태를 이미지, 레이블 표시
        // 상단 레이블에도 '선택하세요' 표시
        // 컴퓨터가 다시 랜덤 가위바위보를 선택하고 저장
        
        comImageView.image = #imageLiteral(resourceName: "ready")
        myImageView.image = UIImage(named: "ready.png")
        
        comChoiceLabel.text = "준비"
        myChoiceLabel.text = "준비"
        
        mainLabel.text = "선택하세요"
        
        comChoice = Rps(rawValue: Int.random(in: 0...2))!
    }
}
