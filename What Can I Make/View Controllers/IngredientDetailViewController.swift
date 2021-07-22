//
//  IngredientDetailViewController.swift
//  What Can I Make
//
//  Created by James Barkley on 6/24/21.
//

import UIKit

// Add Ingredient View
class IngredientDetailViewController: UIViewController {

    var name: String = ""
    @IBOutlet weak var ingredientName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            name = ingredientName.text!
        }
    }
    
    
    
    
    
    
    

}
