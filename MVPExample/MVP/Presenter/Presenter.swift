//
//  Presenter.swift
//  MVPExample
//
//  Created by Berkehan on 27.04.2021.
//

import Foundation

import UIKit

typealias PresenterDelegate = UserPresenterDelegate & UIViewController
protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [User])
    func presentAlert(title: String, message: String)
    
    
}


class UserPresenter {
    weak var delegate: PresenterDelegate?
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate  = delegate
    }
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data, err == nil  else {
                return
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self.delegate?.presentUsers(users: users)
            }
            catch {
                print(err)
            }
        }
        task.resume()
    }
    func didTapUser(user: User)  {
        let title = "information About User"
        let message  = " username \(user.name) \n email \(user.email)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        delegate?.present(alert,animated: true)
    }
}
