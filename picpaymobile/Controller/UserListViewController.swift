//
//  ViewController.swift
//  picpaymobile
//
//  Created by Anderson Chagas on 30/04/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var listUsers : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppConstants.cellNibName, bundle: nil), forCellReuseIdentifier: AppConstants.cellIdentifier)
        populateTableView()
    }
    
    func populateTableView(){
        let users = Bundle.main.decode([User].self, from: AppConstants.UserJsonFile)
        listUsers.append(contentsOf: users)
    }
}

extension UserListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = listUsers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.cellIdentifier, for: indexPath) as! UserCellTableViewCell
        cell.userName.text = user.username
        cell.name.text = user.name
        cell.userPhoto.load(url: URL(string: user.img)!)
        
        return cell
    }
    
}





