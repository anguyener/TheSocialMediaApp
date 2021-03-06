//
//  LoginViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var network = NetworkService()
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
      network.theToken = UserDefaults.standard.string(forKey: "token")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  if let username = UserDefaults.standard.string(forKey: "username") {
    //     usernameTextField.text = username }
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let user = Login(name: usernameTextField.text!, password: passwordTextField.text!)
        UserDefaults.standard.set(user.name, forKey: "username")
        network.fetchToken(user: user) {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                let first = tabBarController.viewControllers?.first as? UINavigationController
                let next = tabBarController.viewControllers?.dropFirst().first as? UINavigationController //?
                let home = first?.viewControllers.first as? HomeViewController
                home?.network = self.network
                let contacts = next?.viewControllers.first as? ContactsViewController
                contacts?.network = self.network
                self.present(tabBarController, animated: true, completion: nil)
             //   self.present(contacts!, animated: true, completion: nil)
            }
        }
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
      
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField && !(usernameTextField.text?.isEmpty ?? false) {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

