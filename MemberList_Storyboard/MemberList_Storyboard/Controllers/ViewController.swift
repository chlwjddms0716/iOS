//
//  ViewController.swift
//  MemberList_Storyboard
//
//  Created by 최정은 on 2023/09/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var memberListManager = MemberListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        memberListManager.getMemberListDatas()
    }
    
   func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
       
       tableView.rowHeight = 60
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMembersList().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell", for: indexPath) as! MemberTableViewCell
        
        cell.memberImageView.image = memberListManager[indexPath.row].memberImage
        cell.nameLabel.text = memberListManager[indexPath.row].name
        cell.addressLabel.text = memberListManager[indexPath.row].address
        
        cell.selectionStyle = .none
        return cell
    }
    
   
    
    
}
