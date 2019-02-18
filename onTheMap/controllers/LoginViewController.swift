//
//  LoginViewController.swift
//  onTheMap
//
//  Created by Ahmed Fahmy on 08/02/2019.
//  Copyright © 2019 Mohtaref. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loadingView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        emailTextField.text = "ahmed.fahmy.hassan@gmail.com"
        passwordTextField.text = "hpld1717"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToNotificationsObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromNotificationsObserver()
    }
    func updateView(){
        roundCorners(loginButton)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
    }
    func enableForm(_ isEnabled: Bool) {
        DispatchQueue.main.async {
            self.emailTextField.isEnabled = isEnabled
            self.passwordTextField.isEnabled = isEnabled
            self.loginButton.isEnabled = isEnabled
            self.signUpButton.isEnabled = isEnabled
        }
    }
    
 
    
    @IBAction func signupPressed(_ sender: Any) {
        if let url = URL(string: "https://www.udacity.com/account/auth#!/signup"),
        UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let email = emailTextField.text,!email.isEmpty,
            let password = passwordTextField.text,!password.isEmpty else{
                showAlert(title: "Error", message: "Email and password is empty...")
                return
        }
        let ai = self.startAnActivityIndicator()
        enableForm(false)
        API.postSession(username: email, password: password) { (errString) in
            ai.stopAnimating()
            self.enableForm(true)
            guard errString == nil else {
                self.showAlert(title: "Error", message: errString!)
                return
            }
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "Login", sender: nil)
            }
        }
    }
    
    
    
}
