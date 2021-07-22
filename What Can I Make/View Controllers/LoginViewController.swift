//
//  LoginViewController.swift
//  What Can I Make
//
//  Created by James Barkley on 7/2/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String? {
        
        
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        
        let cleanPW = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        // Check if the password is secure
        
        
        return nil
    }
    
    func showError (_ message:String){

        // There was an error
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    

    @IBAction func loginButtonTapped(_ sender: Any) {
        
        // Validate Fields
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            
            // Create cleaned versions of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                
                if error != nil {
                    self.errorLabel.text = error!
                    self.errorLabel.alpha = 1
                } else {
                    self.goToHomeScreen()
                }
            }
            
            
        }
        
    
    }
    
    func goToHomeScreen(){
        
        let initVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeVC")
        
        let navi = UINavigationController.init(rootViewController: initVC)
        
        self.view.window?.rootViewController = navi
    }


}
