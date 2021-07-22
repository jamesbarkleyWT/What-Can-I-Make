//
//  SignUpViewController.swift
//  What Can I Make
//
//  Created by James Barkley on 7/2/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var utils = Utilities()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        errorLabel.alpha = 0
        
    }
    
    
    
    func validateFields() -> String? {
        
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        
        let cleanPW = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if utils.isPasswordValid(cleanPW) == false {
            return "Please make sure your password is at least 8 characters, contains a specials character and a number"
        }
        // Check if the password is secure
        
        
        return nil
    }
    

    @IBAction func signUpButton(_ sender: Any) {
        
        // Validate Fields
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            
            // Create cleaned versions of the data
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // Create User
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in

                if err != nil {

                    // Means there was an error

                    self.showError("Error creating user")
                } else {
                    // User was created successfully
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName": firstName, "lastname": lastName, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            self.showError("User data could not be created")
                        }
                    }
                    
                    // Transition to home screen
                    self.goToHomeScreen()
                    
                }
            }
            
        }
        
    }
    
    
    
    func showError (_ message:String){

        // There was an error
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
   
    func goToHomeScreen(){
        let initVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeVC")
        
        let navi = UINavigationController.init(rootViewController: initVC)
        
        self.view.window?.rootViewController = navi
    }

}
