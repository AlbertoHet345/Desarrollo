//
//  ViewController.swift
//  Login
//
//  Created by Alberto Garcia on 12/09/17.
//  Copyright © 2017 Alberto Garcia. All rights reserved.
//

import UIKit
import LocalAuthentication // To import Touch ID Functions

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if (isUserLoggedIn) {
            testTouchID()
        }
        if (!isUserLoggedIn) {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
    
    func notifyUser(_ msg: String, err: String?) {
        let alert = UIAlertController(title: msg, message: err, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func testTouchID() {
        let context = LAContext()
        
        var error: NSError?
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // The device can use Touch ID
            
            context.evaluatePolicy(
                LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Access requires authentication", reply: {
                    (success, error) in DispatchQueue.main.async {
                        if error != nil {
                            switch error!._code {
                            case LAError.Code.systemCancel.rawValue:
                                self.notifyUser("Session cancelled", err: error?.localizedDescription)
                            case LAError.Code.userCancel.rawValue:
                                self.notifyUser("Please try again", err: error?.localizedDescription)
                            case LAError.Code.userFallback.rawValue:
                                self.notifyUser("Authentication", err: "Password option selected")
                            // Custom code to obtain password here
                            default:
                                self.notifyUser("Authentication", err: error?.localizedDescription)
                            }
                        } else {
                            self.notifyUser("Authentication Successful", err: "You now have full access")
                        }
                    }
                }
            )
        } else {
            // The devide cannot use Touch ID
            
            switch error!.code {
            case LAError.Code.touchIDNotEnrolled.rawValue:
                notifyUser("ToucgID is not enrolled", err: error?.localizedDescription)
            case LAError.Code.passcodeNotSet.rawValue:
                notifyUser(" A passcode has not been set", err: error?.localizedDescription)
            default:
                notifyUser("TouchID not available", err: error?.localizedDescription)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

