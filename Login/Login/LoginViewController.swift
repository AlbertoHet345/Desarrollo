//
//  LoginViewController.swift
//  Login
//
//  Created by Alberto Garcia on 13/09/17.
//  Copyright © 2017 Alberto Garcia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfUserEmail: UITextField!
    @IBOutlet weak var tfUserPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userEmail = tfUserEmail.text!
        let userPassword = tfUserPassword.text!
        
        if (userEmail.isEmpty || userPassword.isEmpty) {
            displayMyAlertMessage(userMessage: "All fields are required")
            return
        }
        
        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail")
        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword")
        if (userEmailStored == userEmail) {
            if (userPasswordStored == userPassword) {
                // Login is successful
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
            } else {
                displayMyAlertMessage(userMessage: "Email or Password are wrong")
            }
        } else {
            displayMyAlertMessage(userMessage: "Email or Password are wrong")
        }
    }
    
    func displayMyAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
