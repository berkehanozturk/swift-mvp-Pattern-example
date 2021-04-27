//
//  ViewController.swift
//  MVPExample
//
//  Created by Berkehan on 27.04.2021.
//

import UIKit

class UserViewController: UIViewController, UserPresenterDelegate{

 
    
    var usersArray: [User]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()

    private let presenter = UserPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Users"
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func presentUsers(users: [User]) {
        usersArray = users
    }
    
    func presentAlert(title: String, message: String) {
        
    }
    
}

extension UserViewController: UITableViewDelegate,UITableViewDataSource {
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  usersArray?.count ?? 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text =  usersArray?[indexPath.row].name
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //ask presenter to show alert
        if let userArray = usersArray {
            presenter.didTapUser(user: userArray[indexPath.row])
        }
    }
    
}
