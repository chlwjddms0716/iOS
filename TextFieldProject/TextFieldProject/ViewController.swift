//
//  ViewController.swift
//  TextFieldProject
//
//  Created by 최정은 on 2023/08/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self = ViewController
        textField.delegate = self
        
        setup()
    }

    func setup(){
        
        //view.backgroundColor = UIColor.gray
        
        // 키보드 스타일
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "이메일 입력"
        textField.borderStyle = UITextField.BorderStyle.bezel
        
        // 선 스타일, 기본
        //  textField.borderStyle = UITextField.BorderStyle.line
        
        // 지우기 버튼
        textField.clearButtonMode = .always
        textField.returnKeyType = .next
        
        // 텍스트필드가 첫번째 응답 객체가 되면 키보드가 먼저 올라옴
        // 화면에 들어오자 마자 키보드 표시하는 방법
        textField.becomeFirstResponder()
    }

    // 화면에 탭을 감지하는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.view.endEditing(true)
        textField.resignFirstResponder()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
        // 첫번째 응답 객체를 지운다?
        textField.resignFirstResponder()
        
    }

}

extension ViewController: UITextFieldDelegate {
    
    // 텍스트필드의 입력을 시작할 때 호출(시작할지 말지의 여부를 허락하는 것)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 유저가 텍스트필드의 입력을 시작한 순간
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
    }
    
    // x 버튼 클릭 시 동작 할지 안할지 여부
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    
    // 텍스트필드 글자 내용이 (한글자 한글자) 입력되거나 지워질 때 호출, 표시할지 말지 허락
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(string)
        
        // 숫자 막기
        if Int(string) != nil {
            return false
        }
        else
        {
            return textField.text!.count + string.count <= 10
        }
    }
    
    // 텍스트필드의 엔터키가 눌러지면 다음 동작을 허락할것인지 말것인지
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        if textField.text == "" {
            textField.placeholder = "Type SomeThing!"
            return false
        }
        else
        {
            textField.text = ""
            return true
        }
    }
    
    // 텍스트필드의 입력이 끝나는걸 허락할지 말지
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트필드의 입력이 실제 끝났을 때 호출 (시점)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print(#function)
    }
}
