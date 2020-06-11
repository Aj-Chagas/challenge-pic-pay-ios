//
//  ViewController.swift
//  picpaymobile
//
//  Created by Anderson Chagas on 30/04/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import UIKit
import os.log

class UserListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchActive : Bool = false
    var listUsers : [User] = []
    var filteredUsers : [User] = []
    var selectedUser : User? = nil
    
    var isSearchBarEmpty: Bool {
      return searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering : Bool {
        return searchActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.setTitleNavigationBar()
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredUsers = listUsers.filter({ (user : User) -> Bool in
            return user.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
        
    }
    
    func configureTableView(){
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: AppConstants.cellNibName, bundle: nil), forCellReuseIdentifier: AppConstants.cellIdentifier)
       
        populateTableView()
    }
    
    func populateTableView(){
        let users = Bundle.main.decode([User].self, from: AppConstants.UserJsonFile)
        listUsers.append(contentsOf: users)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "registerCreditCardSegue"){
            guard let regiterCreditCardViewController = segue.destination as? RegisterCreditCardViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            regiterCreditCardViewController.user = selectedUser
        }
    }
    
    func isFiltering(_ indexPath : IndexPath) -> User {
        var user : User
        if isFiltering {
            user = filteredUsers[indexPath.row]
        } else {
            user = listUsers[indexPath.row]
        }
        return user
    }

}

extension UserListViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
    
}

extension UserListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredUsers.count
        }
        return listUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = isFiltering(indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.cellIdentifier, for: indexPath) as! UserCellTableViewCell
        bindTableView(cell, user)
     
        cell.selectionStyle = .none
        
        return cell
    }
    
    func bindTableView(_ cell : UserCellTableViewCell, _ user : User) {
        cell.userName.text = user.username
        cell.name.text = user.name
        cell.userPhoto.load(url: URL(string: user.img)!)
    }
    
}

extension UserListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = isFiltering(indexPath)
        performSegue(withIdentifier: "registerCreditCardSegue", sender: self)
    }
}





