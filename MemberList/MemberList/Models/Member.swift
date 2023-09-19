//
//  Member.swift
//  MemberList
//
//  Created by 최정은 on 2023/09/01.
//

import UIKit

// Class에서만 채택을 할 수 있는 프로토콜이라고 선언해주고, 이렇게 선언해줘야만 weak으로 선언해 줄 수 있음
protocol MemberDelegate: AnyObject {
    
    func addNewMember(_ member: Member)
    func update(index: Int, _ member: Member)
}

// 데이터 묶음은 구조체로 만듦, 간단한 데이터 모델은 구조체로 만듦
// 클래스는 무거움, 느림
struct Member{
    
    // 지연 저장 속성, 클로저 형식
    lazy var memberImage: UIImage? = {
        guard let name = name else {
            return UIImage(systemName: "person")
        }
        
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    // 멤버의 (절대적) 순서를 위한 타입 저장 속성
    // 회원이 몇명인지 알 수 있음
    static var memberNumbers: Int = 0
    
    let memberId: Int
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    init(name: String?, age: Int?, phone: String?, address: String?) {
        
        self.memberId = Member.memberNumbers
        
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        // 멤버를 생성한다면, 항상 타입 저장속성의 정수값 + 1
        Member.memberNumbers += 1
    }
}
