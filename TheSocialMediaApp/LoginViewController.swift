//
//  LoginViewController.swift
//  TheSocialMediaApp
//
//  Created by Anna Nguyen on 11/16/17.
//  Copyright © 2017 Anna Nguyen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let username = UserDefaults.standard.string(forKey: "username") {
            usernameTextField.text = username
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        //if(usernameTextField.text ) //not a valid user
        //else if not a matching pass
        //else trigger delegate
        let user = Login(name: "<#T##String#>", password: <#T##String#>)
        NetworkService().fetchToken()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        present(homeViewController, animated: true, completion: nil)
    }
    
}
