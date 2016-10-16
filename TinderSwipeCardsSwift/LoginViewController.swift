//
//  LoginViewController.swift
//  TinderSwipeCardsSwift
//
//  Created by Priyanka Sekhar on 9/28/16.
//  Copyright © 2016 gcweb. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = FIRAuth.auth()?.currentUser
        {
            //self.logoutButton.alpha = 1.0
            self.usernameLabel.text = user.email
        }
        else
        {
            //self.logoutButton.alpha = 0.0
            self.usernameLabel.text = ""
        }
    }
    
    @IBAction func createAccountAction(sender: AnyObject) {
        if self.emailText.text == "" || self.passwordText.text == ""
        {
            let alertController = UIAlertController(title: "oops!", message: "Please enter an email and password.", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.createUserWithEmail(self.emailText.text!, password: self.passwordText.text!, completion: { (user,error) in
                
                if error == nil
                {
                    //self.logoutButton.alpha = 1.0
                    self.usernameLabel.text = user!.email
                    self.emailText.text = ""
                    self.passwordText.text = ""
                }
                else
                {
                    let alertController = UIAlertController(title: "oops!", message: error?.localizedDescription, preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
            })
        }

    }
}
