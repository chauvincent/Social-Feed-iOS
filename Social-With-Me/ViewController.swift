//
//  ViewController.swift
//  Social-With-Me
//
//  Created by Vincent Chau on 1/10/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil{
            self.performSegueWithIdentifier(SEGUE_HOME, sender: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookButtonPressed(sender: UIButton!){
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            if facebookError != nil{
                print("Facebook Login Failed")
            }else{
                let token = FBSDKAccessToken.currentAccessToken().tokenString
                print("Facebook logged in \(token)")
                
                // store user as facebook on firebase
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: token, withCompletionBlock: { error, authData -> Void in
                    
                    if error != nil{
                        print("login error \(error)")
                        
                    }else{
                        print("logged in\(authData)")
                        
                        // create new user object on firebase
                        let user = ["provider": authData.provider!, "blahblahblah":"test"]
                        DataService.ds.createFirebaseUser(authData.uid, user: user)
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_HOME, sender: nil)
                    }
                    
                })
                
            }
        }
    }
    @IBAction func emailLoginPressed(sender: UIButton){
        if let email = emailTextField.text where email != "",
            let pass = passwordTextField.text where pass != "" {
                // authorize the user
                DataService.ds.REF_BASE.authUser(email, password: pass, withCompletionBlock: { (error, authData) -> Void in
                    if error != nil{
                        
                        print(error)
                        if error.code == ERROR_ACCOUNT_DONT_EXIST{
                            DataService.ds.REF_BASE.createUser(email, password: pass, withValueCompletionBlock: { (error, result) -> Void in
                                
                                if error != nil{
                                    self.showError("Could not create account", msg: "Try another log-in credential")
                                }else{
                                    NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)

//                                    DataService.ds.REF_BASE.authUser(email, password: pass, withCompletionBlock: nil)
                                    DataService.ds.REF_USERS.authUser(email, password: pass, withCompletionBlock: { (error, authData) -> Void in
                                        let user = ["provider": authData.provider!, "blah2":"test2"]
                                        DataService.ds.createFirebaseUser(authData.uid, user: user)
                                    })
                                    self.performSegueWithIdentifier(SEGUE_HOME, sender: nil)
                                }
                            })
                        }else{
                            self.showError("Alert", msg: "Please check your login credentials")
                        }
                    }else{
                        self.performSegueWithIdentifier(SEGUE_HOME, sender: nil)
                          print("worked")
                    }
            })

        }else{
            showError("Enter a email and password", msg: "Please try again.")
            print("error")
        }
    }
    func showError(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}

