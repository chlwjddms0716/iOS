//
//  Member.swift
//  MemberList_Storyboard
//
//  Created by 최정은 on 2023/09/01.
//

import UIKit

struct Member{
    
    static var memberCount: Int = 0
    
   lazy var memberImage: UIImage? = {
        guard let name = name else { return UIImage(systemName: "person")}
        
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    let memberId: Int
    var name: String?
    var address: String?
    var age: Int?
    var phone: String?
    
    
    init(name: String?,age: Int?, phone: String?, address: String?  ) {
        
        self.memberId = Member.memberCount
        
        self.name = name
        self.address = address
        self.age = age
        self.phone = phone
        
        Member.memberCount += 1
    }
}
