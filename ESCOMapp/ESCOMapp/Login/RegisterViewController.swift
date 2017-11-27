//
//  RegisterViewController.swift
//  ESCOMapp
//
//  Created by Alberto Garcia on 26/11/17.
//  Copyright © 2017 Alberto Garcia. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRepeatPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        let userEmail = tfEmail.text!
        let userPassword = tfPassword.text!
        let userRepeatPassword = tfRepeatPassword.text!
        
        // Check for empty fields
        if (userEmail.isEmpty || userPassword.isEmpty || userRepeatPassword.isEmpty) {
            
            // Display alert message
            displayMyAlertMessage(userMessage: "All fields are required")
            return
        }
        // Check if passwords match
        if (userPassword != userRepeatPassword) {
            
            //Display alert message
            displayMyAlertMessage(userMessage: "Passwords do not match")
            return
        }
        
        // Store data
        
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        UserDefaults.standard.synchronize()
        
        // Display alert messsage with confirmation
        let myAlert = UIAlertController(title: "Alert", message: "Successful registration", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){ action in
            self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func displayMyAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
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
